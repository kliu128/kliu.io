+++
title = "LizardFS is Pretty Nice"
date = 2019-01-21T10:28:54-05:00
description = "My LizardFS storage setup - basically living the dream"
draft = false
toc = true
categories = []
tags = ["tech", "homelab"]
images = []
+++

For the past few months, I've been running [LizardFS](https://lizardfs.com/) on my home servers, providing 26 TB of error-checked, erasure-coded storage. All on mismatched disks spread over two computers.

I like it. A lot.

# The Problem

As an unorganized digital packrat, I have spontaneously purchased hard drives of very varying capacities over the years. In my storage cluster, I have 250 GB disks all the way to 8 TB disks. Conventional RAID filesystems, like ZFS or software RAID, tend to not handle mismatched disks very well, and they do not let you use all the disks to their fullest capacity.

With ZFS especially, it requires [quite some finangling](https://www.reddit.com/r/zfs/comments/85nf1y/zfs_with_different_size_disks/) to create a storage pool from mismatched disks, and adding new disks to a RAIDZ is impossible without [creating more vdevs](https://louwrentius.com/the-hidden-cost-of-using-zfs-for-your-home-nas.html), which incurs parity overhead. Thus, despite ZFS's legendary other features (e.g. deduplication, snapshotting, block devices...), it wouldn't work for me.

BTRFS is also another option, but, uh, [yeah](https://btrfs.wiki.kernel.org/index.php/RAID56). Let's just say, I wouldn't trust BTRFS on anything larger than a single-disk filesystem. (Heck, even my root filesystem on BTRFS crashes every few weeks with some arcane BTRFS error.)

An option that is _nearly_ ideal is [SnapRAID](http://www.snapraid.it/). With SnapRAID, you simply put files on individual disks, and SnapRAID periodically (e.g. daily) reads through the disks and calculates parity, which it puts on a **parity drive**. The downside, however, is that (1) this delayed parity calculation means new files are at risk for some time, and (2) the parity drive must be the largest of all your drives. In my case, this would mean giving an entire 8 TB drive to parity, which is not really ideal. And if I were to want double parity? Two 8 TB drives.

Also, a shared issue with these filesystems is that they are inherently _single-computer_ -- there's no sharing of a ZFS filesystem across multiple computers, or calculating SnapRAID parity across two PCs.

# LizardFS: The Solution

LizardFS operates in a similar manner to SnapRAID -- it writes directly to ordinary filesystems on individual drives (e.g. ext4, BTRFS). It essentially provides a virtual filesystem that you can write to, and it will pick drives to write to. However, it doesn't write files whole -- it breaks each into 64 MB chunks and distributes them across its drives. This means it can use all disks to their fullest capacity.

To provide redundancy, however, it also provides **goals**, different options for how data should be replicated/erasure-coded. Goals can be set on individual files or folder trees, so you could have your movie collection at 2 data : 1 parity (so one drive could fail before losing data), while your personal documents are at 2x replication.

To manage this entire system, LizardFS operates a **master daemon**, which handles all filesystem metadata and lets clients know where to find chunks. Chunks are served and written by **chunkservers**, which deal directly with individual disks. These chunkservers can be on different computers, providing redundancy and scalability. There are two ways to think about chunkservers:

1. One chunkserver per computer; the chunkserver writes to a ZFS array/RAID array/etc.
2. [One chunkserver per disk](https://github.com/lizardfs/lizardfs/issues/231); the chunkserver writes to an individual disk.

I went for the latter, because I am too poor for option one, and I only have two computers. (The benefit of option one, though, is that you can _literally unplug a computer_ and your file system is fine.)

LizardFS also provides snapshot functionality, though I personally can't use them (see below).

This kind of architecture is similar to those of other distributed filesystems, including Ceph and GlusterFS. As far as I know, though, neither has as much flexibility in, e.g. assigning different goals to files.

# How I Run LizardFS

I run LizardFS on two computers. One (i7-4820k, 20 GB RAM) runs the **master daemon** and chunkservers, while the other (AMD Athlon X2, 6 GB RAM) runs more chunkservers and the **metalogger** (basically a backup for the master daemon).

I orchestrate this entire process using [NixOS](https://nixos.org/), [NixOps](https://nixos.org/nixops/), and a custom LizardFS configuration module that I have written.

Most of my files are at `ec(2,1)`; this means that I can lose one drive and still reconstruct all data. Important files are at `ec(4,2)`, so I can lose 2 drives for those.

# The Downsides

A few things about LizardFS make me worried about its longer-term relevance.

1. [The repository](https://github.com/lizardfs/lizardfs) hasn't been updated since June 2018. Now, it seems that they only update their public repository on new software releases, but the fact remains that v3.13.0-rc1 has been out for nearly a year (and rather [buggily at that](https://github.com/lizardfs/lizardfs/issues/746)) with no stable release.

2. There have been some bugs. Sometimes, after my computer crashes, taking down the master daemon and several chunkservers, I reboot to find missing chunks. I believe this is because mounts don't wait for all data + EC writes to finish, which may be solved by [the `REDUNDANCY_LEVEL` option](https://github.com/lizardfs/lizardfs/issues/338). I'm still worried that it can happen _at all_, though.

3. Scalability. The master daemon stores all metadata (e.g. filenames, modtimes) in RAM, providing lightning-quick access, but at the cost of memory usage. At times, it has grown to ~1.5 GB. This also makes extensive snapshots unusable for me, as each snapshot essentially *duplicates the entire metadata set*, doubling memory usage.

    The daemon also [forks on the hour](https://github.com/lizardfs/lizardfs/issues/323), which briefly doubles memory usage. So you basically have to reserve twice the size of the metadata set in RAM.

    I've tried to work around this by forcing the daemon to use swap by setting [`MemoryMax=` in `systemd`](https://www.freedesktop.org/software/systemd/man/systemd.resource-control.html). This works surprisingly well (metadata access is still pretty fast), but it causes several-minute hangs on shutdown, so I stopped doing it.

4. Not a lot of people use it. While Ceph / GlusterFS / SnapRAID have lots of blog posts on the internet and setup guides, LizardFS has quite sparse documentation. Hence why I'm writing this post now. For more info, I would recommend [wintersdark's guide on reddit](https://www.reddit.com/r/HomeServer/comments/98ex85/one_server_isnt_enough_my_adventures_with_lizardfs/), which introduced me to LizardFS.

    If anyone else is using LizardFS or has any questions about trying it out, please [contact me](/about)!

Overall, though, these aren't too bad. It's the best storage solution available right now for my use case, and I'm happy <3
