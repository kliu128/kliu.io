---
layout: post
comments: true
title: "Gentoo on the HP Envy 15t (i7-7500U)"
date: 2017-04-17T08:37:15-04:00
description: "List of kernel configurations to run Gentoo successfully"
tags: ["tech"]
---

## Video

`VIDEO_CARDS="intel i965"` in `/etc/portage/make.conf`. Easy.

## SD Card Reader

Enable kernel config option `CONFIG_MFD_RTSX_PCI` (aka `Device Drivers --> Multifunction device drivers --> Realtek PCI-E card reader`).

## Touchscreen

Whoo boy. This one took a while to figure out. I knew that Linux had support for this touchscreen, because live CDs using all-inclusive kernel configurations supported it.

Turns out it’s an I2C touchscreen using the `hid-multitouch` driver running off of a "Sunrise Point-LP Serial IO I2C Controller", according to lspci. I had enabled `hid-multitouch` and `i2c_hid` and everything, so why didn’t it work??

Turns out the I2C controller uses the kernel’s Intel Low Power Subsystem driver (LPSS), which I had disabled. It’s in `Device drivers --> Multifunction device drivers`. You then should enable the Quark config option that shows up, then go back to `Device drivers --> I2C support --> I2C Hardware Bus` support and you’ll see `CONFIG_I2C_DESIGNWARE_PLATFORM` and `CONFIG_I2C_DESIGNWARE_BAYTRAIL` show up. Enable those, and that should work. (I don’t know if all of those are necessary, but that’s what worked for me!)
