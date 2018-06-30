+++
author = "Kevin Liu"
title = "VFIO, Because I Got Tired of Rebooting My Server"
date = 2017-02-18T08:22:08-04:00
description = "An adventure on VFIO escapades in Proxmox Linux"
draft = false
toc = false
categories = []
tags = ["vfio", "tech"]
images = []
+++

Hi! First post. (I’m not sure if anyone will actually read this but ¯\\\_(ツ)\_/¯. I thought that writing down how I set up VFIO would be helpful, both for me in the future and for anyone else who wants to try the same thing.)

## Prelude

So, at home I had an Arch Linux desktop running a bunch of Docker containers. It acted both as my main computer for tinkering and my server, which is not a good combination for stability or security. Every time I tried Wayland on KDE and my computer locked up, every time I tried a new glitchy kernel, I’d have to reboot the whole computer, taking down my server while I was at it. Unfortunately, I couldn’t have my server on a different computer, because I am a broke high school student.

So I decided to try something different—VFIO! Virtual Function I/O, aka virtualizing your main computer while passing through the host graphics card to the virtual machine. Normally this is done with a Windows guest on a Linux host, so one can run Linux for normal applications and then play games using the beefy graphics card. However, I wanted something a little different: I wanted to run my Arch desktop in the virtual machine with the graphics card, and have the server in another.

## Specifications

Here are the important specs of my desktop-turned-VFIO-host:

- **CPU**: i7-4820k (it supports Intel VT-d and also having a model that supports IOMMU interrupt remapping is important, I think; I just got lucky and happened to have one that does)
- **Motherboard**: Gigabyte GA-X79-UP4
- **RAM**: 16 GB non-ECC DDR3 (not ideal, probably)
- **SSD**: Samsung 840 EVO 256GB (super sucky)
- **GPU (desktop guest)**: MSI GTX 770 Twin Frozr 2 GB (sort of out of date now)
- **GPU (host)**: This sucky ATI Radeon X300 or something, stolen from an old Dell Inspiron from 2005
- (a bunch of other stuff that isn’t really important)

As you can tell, this isn’t the most high end setup, but still fairly formidable, I think.

Now, you might be wondering, “why the two dedicated GPUs? even if one is sucky?” Well, the host OS needs a GPU for itself to display the UEFI bootup and console output, and the i7-4820k unfortunately does not have an integrated GPU. There are ways using only one GPU, apparently, but ¯\\\_(ツ)\_/¯.

And here’s the software setup:

- **Host OS**: Proxmox VE 4.4
- **Desktop Guest OS**: Arch Linux
- **Server Guest OS**: Ubuntu Server 16.04

## Configuration

After installing Proxmox on the SSD, I first resized the root partition from ~60GB to ~20 GB to give me more room for the VMs. (Actually, I did this later, and it was a pain in the butt. Do it now.)

Then I created the server VM—the easy part, since there’s no GPU passthrough to screw around with. I made a UEFI VM and passed through a few block devices, running `qm set <vm-id> -virtio<0-4> /dev/disk/blahblah` as detailed [here](http://blog.imnotacyb.org/disk-passthrough-in-proxmox/).

The desktop VM was quite a bit more complicated. I wanted it to also be UEFI using OVMF, so I had to first [make sure that my GPU ROM supported UEFI](https://vfio.blogspot.com/2014/08/does-my-graphics-card-rom-support-efi.html). …And it didn’t (MSI, man, such a slacker), so I had to google for some sketchy UEFI-supporing ROM for my card and flash it.

Then I pretty much followed [Proxmox’s PCI passthrough guide to the letter](https://pve.proxmox.com/wiki/Pci_passthrough), passing through the GPU using OVMF and PCI-Express. To pass through my USB devices, I tried futilely to pass through each individual one, but it turns out that there’s a limit of 5 USB devices that can be passed through and passing through hubs doesn’t work for some reason. So I just passed through the entire USB chipset, which seems to work fine. I also passed through the audio chipset for audio.

Moral of the story: To get something in a VM, PCI passthrough does the trick every time.

## Problems

VFIO is not exactly known for its ease of use and simplicity.

- Graphics output did display the UEFI boot logo on my guest GPU (yes!), but when I tried to boot into any Linux installation, it lost all signal unless I disabled kernel mode setting. Turns out there’s a bug in nouveau where kernel mode setting fails unless you have `nouveau.config=NvForcePost=1` on the kernel command line. (At least that works for me; apparently the problem persists for many others.)
- Rebooting the guest OS makes the GPU screwy, so that I have to reboot the entire system to fix it. Linux 4.9 works pretty well, but sometimes nouveau logs a bunch of `TRAP`s and errors in dmesg on reboot? Linux 4.10-rc5 seems to break rebooting completely, to the point where not even the UEFI boot logo shows up. TTYs also seem broken. Not sure if that’s just because 4.10’s still in rc or because of VFIO.
- Audio seems to glitch occasionally. Not a big deal, really; it seems to happen in moments of high CPU load. I’m also not sure if it’s PulseAudio’s fault or PCI passthrough’s.

Overall though, I’m quite pleased with the results! If nothing else, it was fun to set up and satisfying to use. Hopefully this guide helps you avoid some of the headaches I encountered if you decide to try the same thing.

## Update (2017-02-11)

After a while of usage, I encountered another problem in dmesg:

```
Uhhuh. NMI received for unknown reason 0a on CPU 0.
Do you have a strange power saving mode enabled?
Dazed and confused, but trying to continue
```

A bit weird, don’t you think? This seems to coincide with a notable reduction in performance. After a bunch of googling, I changed the `machine` parameter in `vmid.conf` to use `i440fx` instead of `q35`. A good summary of the differences is [here](https://www.reddit.com/r/VFIO/comments/5ireij/differencesbenefits_between_i440fx_and_q35/dbb2e01/). Since `i440fx` doesn’t have PCI-E support, I also had to remove the `pcie=1` parameter from my `hostpciX` entries. (I guess it does some sort of frankenstein PCI-E-through-PCI passthrough now?) And it seems to work a lot better! I haven’t gotten any weird NMI entries, and the VM stays snappy.

I also found a solution to the problem where the VM wouldn’t show display output after a reboot. Testing with Linux 4.10-rc8, with the command line parameters of `nouveau.config=NvForcePost=1` [`nouveau.config=NvBoost=2`](https://www.phoronix.com/scan.php?page=article&item=nouveau-410-blob&num=1), the problem only seems to arise when the pstate is reclocked to `0f` on shutdown. Easy fix—just create a systemd unit to automatically lower the pstate back to the original of `07` on shutdown.
