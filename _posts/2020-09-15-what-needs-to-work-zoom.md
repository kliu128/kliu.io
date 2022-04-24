---
layout: post
comments: true
title: "What needs to work for your Zoom call to work?"
date: 2020-09-15T23:05:48-04:00
description: "It's amazing how tall the tower of computer abstraction is. Let's explore a few of those layers here."
draft: false
toc: false
categories: []
tags: ["tech"]
images: []
---

> "If I have seen further, it is by standing on the shoulders of ~~giants~~ _terrible and demonic abstractions_."
>
> -Isaac Newton, probably

Zoom feels obscenely normal now. It's become so day-to-day that [Zoom fatigue](https://www.nationalgeographic.com/science/2020/04/coronavirus-zoom-fatigue-is-taxing-the-brain-here-is-why-that-happens/) is now a known thing.

But honestly, it's a miracle every time it works. In the spirit of those [blog posts about what happens when you press enter in your browser](https://github.com/alex/what-happens-when), here's a (clearly incomplete) list of everything that has to go right for you to have that _definitely_ pointless 10am Zoom call[^1].

A note before we begin: many of these will sound ridiculously obvious, and many of you may have always had them. However, across the world, across social classes, and across levels of technical understanding, what is normal for one person may seem like a pure luxury to another. That is part of why I wanted to write this list.[^2]

## Hardware/Other Services (outside the computer)

1. You need stable power. If you're on a laptop or phone, this probably comes from an integrated battery; if you're on a desktop, it probably comes from mains electricity unless you're lucky enough to have a UPS.
1. [Your local electricity system needs to have enough power to meet its customers' demand](https://www.iol.co.za/news/world/california-warns-of-possible-load-shedding-as-record-heat-wave-takes-hold-e7f039c8-02dc-443e-90bc-e3d469c65f8e).
1. The power lines to your house must be intact and undamaged by [hurricanes](https://time.com/5889332/hurricane-sally-path/) or [fire/the threat of fire](https://www.nbcnews.com/business/business-news/power-outages-hamper-evacuation-warnings-distance-learning-wildfire-torn-california-n1239858).
1. More broadly, [your house must not be on fire](https://www.nytimes.com/interactive/2020/us/fires-map-tracker.html).
1. [You need access to the Internet](https://ourworldindata.org/internet).
1. Your Internet service provider must not be having a service outage.
1. Your Internet service provider must not be experiencing [unprecedented loads due to COVID](https://www.nytimes.com/2020/03/26/business/coronavirus-internet-traffic-speed.html).
1. Your modem/optical network terminal that connects you to your Internet service provider needs to be working.
1. Most likely, [your calendar and email services need to be up](https://www.engadget.com/2019-06-18-google-calendar-is-down.html) to find your Zoom link.
1. [Zoom must be up](https://status.zoom.us/).
1. Your router needs to be working and perhaps to be [capable of handling a large amount of connections from multiple users at the same time](https://community.verizonwireless.com/t5/My-Business-Account/Actiontec-MI424WR-NAT-Table-Issues/td-p/4686).
1. Either your Ethernet cables have to be in good condition and plugged in properly, or there has to be an unobstructed path to your wifi router without [too many people using the same channel](https://www.howtogeek.com/209450/how-you-and-your-neighbors-are-making-each-other%E2%80%99s-wi-fi-worse-and-what-you-can-do-about-it/).

## Hardware (inside the computer)

1. [You need a computer](https://www.statista.com/statistics/748551/worldwide-households-with-computer/).
1. You need a computer satisfying Zoom's [minimum hardware requirements](https://support.zoom.us/hc/en-us/articles/201362023-System-requirements-for-Windows-macOS-and-Linux).
1. You need speakers or a pair of headphones.
1. You need a microphone.
1. You probably want a webcam, too. [That might be a little challenging.](https://www.digitaltrends.com/computing/webcams-sold-out-where-to-buy/)
1. Your network card needs to be working, without shorts or frayed wires to degrade its performance.
1. Your hard drive needs to hold Zoom's application data (and presumably, enough of your operating system to open a Zoom link) without [bitrotting](https://en.wikipedia.org/wiki/Bit_rot) or [failing](https://www.backblaze.com/blog/backblaze-hard-drive-stats-q1-2020/).
1. Your graphics card needs to correctly render content without any artifacting.
1. Your computer processor needs to stably run at its current voltage and clock speed.
1. If you're using Bluetooth for your headphones, your headphones need to be charged and working correctly. Same for any wireless keyboard or mouse.

## Software

1. If you're running Windows, [let's hope you don't have any Windows updates pending](https://www.shamusyoung.com/twentysidedtale/?p:50715).
1. [Your computer must not be infected with malware that prevents it from starting](https://www.wired.com/story/notpetya-cyberattack-ukraine-russia-code-crashed-the-world/).
1. You need enough disk space to install Zoom.
1. You need to not be running Windows Vista or below, or macOS 10.8 or below.
1. [Your operating system needs to support your wifi card](https://wireless.wiki.kernel.org/en/users/Drivers), and [you need to have the correct drivers already installed](https://itsfoss.com/fix-no-wireless-network-ubuntu/) (remember, you can't download them just-in-time from the Internet!)
1. Your operating system needs to support your graphics card, and [your graphics drivers must be installed](https://wiki.debian.org/NvidiaGraphicsDrivers).
1. Your graphics drivers must not be [buggy or crash](https://gitlab.freedesktop.org/drm/amd/-/issues) for you.
1. Your [desktop environment must not crash on you](https://www.google.com/search?q:explorer+crash+windows).
1. You need a [working audio software stack](https://duckduckgo.com/?t:ffab&q:pulseaudio+problems&ia:web).
1. If you're using Bluetooth audio, [your operating system must support your Bluetooth chipset](https://fosspost.org/linux-bluetooth-problem/).
1. If you're using Bluetooth audio, [your operating system must support a codec that your headphones use](https://www.soundguys.com/understanding-bluetooth-codecs-15352/).
1. Zoom must support your operating system.
1. [Your browser must be working and not crash](https://duckduckgo.com/?t:ffab&q:chrome+crashes+on+start&ia:web), so you can open your Zoom link.
1. You must have properly configured Zoom to use the correct webcam, microphone, and speakers.
1. [You need to be properly logged into Zoom](https://www.reddit.com/r/Zoom/comments/hba4cq/problems_with_zoom_sso/).

## Politics

1. [Your government must not have a state-sponsored firewall to block Zoom or any of its dependent services](https://www.nbcnews.com/tech/tech-news/zoom-was-window-through-china-s-great-firewall-it-may-n1230511).
1. [Your government must not have been banned by Zoom for regulatory reasons](https://support.zoom.us/hc/en-us/articles/203806119-Restricted-countries-or-regions).
1. [Your government must not have shut down the Internet due to school exams, isolation, riots, or other events.](https://netblocks.org/)

## Social

1. You must not be [one of the 939,185 people who have died of the coronavirus as of September 16, 2020](https://www.worldometers.info/coronavirus/).
1. Or the [~60 million people who will die each year](https://ourworldindata.org/births-and-deaths). Yeah, uh, in summary [death is bad and we should try to stop it](https://en.wikipedia.org/wiki/Transhumanism).
1. You must not have anything more pressing to do. Which, in today's world, might not be true.
1. You must have an environment where it's safe to do Zoom calls, and where those around you won't stop you from doing so through harassment or any other means.
1. [You probably want a quiet space where you can focus and deal with the social tradeoffs of virtual meetings in comparison to physical interaction](https://www.bbc.com/worklife/article/20200421-why-zoom-video-chats-are-so-exhausting).
1. And finally: [you have to want to go to that Zoom call](https://twitter.com/search?q:don%27t%20want%20to%20go%20to%20zoom&src:typed_query).

## In summary

There are a lot of external or otherwise uncontrollable factors that mean that someone can't make it to a call these days. Maybe, we can be a little kinder when someone says they can't make it?

[^1]: To open-source enthusiasts, Google fanatics, or any other group that would prefer a different videocommunications system: `s/Zoom/whateveryouwant`.
[^2]: The other part is that you can use this as a _really_ long flowchart, if you want, for why your Zoom call isn't working. Just kidding.
