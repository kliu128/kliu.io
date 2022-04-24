---
layout: post
comments: true
title: "Nouveau and VFIO: A Random Collection of Data Points"
date: 2017-04-17T08:33:24-04:00
description: "The struggles I faced getting Nouveau + VFIO to work"
tags: ["vfio", "tech"]
---

So, as mentioned in my previous post about VFIO, I’m running nouveau _inside_ of a Linux VM using PCI passthrough. Here are some random tips and notes that I’ve learned.

(Kernel: 4.10-rc8)

- **The system shows "no signal" during modesetting.**
  - **Workaround**: Use `nomodeset nouveau.modeset=0` kernel parameters to disable kernel modesetting. This, however, disables the nouveau driver, so you won’t be running any graphical applications.
  - **Solution**: Use `nouveau.config=NvForcePost=1` to force a POST on the graphics card. This seems to fix it.
  - UPDATE 2017-04-17: This doesn’t seem to be VFIO-specific — I have to do it when booting from a live CD anymore.
- **The display shows "no signal" after a reboot when using nouveau’s experimental reclocking.**
  - **Workaround**: Lower the pstate to 07 before rebooting.
- **TTYs are nonfunctional on a dual-monitor setup.** (This might not be VFIO-specific.)
  - **Solution**: Unknown. Bugzilla issue here.
  - UPDATE 2017-04-17: Fixed in the kernel as of 4.11.
