---
layout: post
comments: true
title: "Tailscale is Pretty Cool"
date: 2020-08-01T11:26:28-04:00
description: "An automatic mesh network that uses WireGuard under the hood. Why it's good, and what I use it for."
tags: ["tech", "homelab"]
images: []
---

_This post is 2/100 in my goal to write 100 blog posts in a year._

Tailscale is, quite frankly, awesome. Through the magic of WireGuard and automatic NAT hole-punching, it creates a virtual private network between servers, laptops, and phones that adapts automatically as you change locations in the real world.

## How Do You Use It?

Well, you sign up for an account (which typically uses Google/other SSO), and then [install it](https://tailscale.com/download) (they have packages for every main operating system). You login with `sudo tailscale up`, and then you have a new, static IP address on your very own virtual network that never changes. It's similar to [Tinc](https://tinc-vpn.org/) (another mesh VPN) in usage and [WireGuard](https://wireguard.com) (a high-speed VPN & encryption protocol) in implementation, but without having to manually push server keys to each server's configuration directory.

Here's an example:

```
kevin@you:~ » ip a s tailscale0
59: tailscale0: <POINTOPOINT,MULTICAST,NOARP,UP,LOWER_UP> mtu 1280 qdisc fq state UNKNOWN group default qlen 500
    link/none
    inet 100.65.99.106/32 scope global tailscale0
       valid_lft forever preferred_lft forever
    inet6 fe80::7513:6301:cc50:ac0d/64 scope link stable-privacy
       valid_lft forever preferred_lft forever
kevin@you:~ » ping rem.i.kliu.io
PING rem.i.kliu.io (100.66.41.4) 56(84) bytes of data.
64 bytes from 100.66.41.4 (100.66.41.4): icmp_seq=1 ttl=64 time=0.984 ms
64 bytes from 100.66.41.4 (100.66.41.4): icmp_seq=2 ttl=64 time=1.11 ms
^C
--- rem.i.kliu.io ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 1001ms
rtt min/avg/max/mdev: 0.984/1.047/1.111/0.063 ms
```

That's me pinging one of my home servers from my laptop over Tailscale. Granted, right now (thank you COVID!) I'm on the same network as my home server, so there isn't much benefit to Tailscale, but even if I were on the other side of the world, I could still directly ping my home server with the same commands.

## How I Use It

Of course, memorizing all of those [`100.64.0.0/10`](https://www.tailscale.com/kb/1015/100.x-addresses) addresses is pretty hard. To keep track of them all, I've set up DNS under a subdomain (i.kliu.io) pointing to all my servers. DNS records don't have to point to public IP addresses, so you can [literally just use the DNS server you're already using for your public website](https://tailscale.com/kb/1054/dns?q=DNS).

Right now, I use it primarily for interactive SSH access. In the future, I'm also hoping to make an IP camera network out of some old phones, with each phone hooked into the Tailscale network!

## When I Wouldn't Use It

Unfortunately, [it uses the userspace `wireguard-go` implementation of the WireGuard protocol, not the recently merged in kernel module](https://github.com/tailscale/tailscale/issues/426). This means that it doesn't get _quite_ the maximum performance on high-speed (e.g. Gigabit Ethernet) connections - when transferring files to my home server over NFS, I get around ~25 MB/s (200 Mbps) instead of the line speed maximum of 1 Gbps. So that, coupled with the fact that it's _really_ hard in systemd to create a mount that waits for Tailscale to start first, means that I typically don't use Tailscale for file mounting.

Another issue with using a subdomain of \*.i.kliu.io for my Tailscale hosts is that if I want to run any private web services over Tailscale, I won't be able to access them using their pretty hostname because of [HTTP Strict Transport Security](https://en.wikipedia.org/wiki/HTTP_Strict_Transport_Security). The gist is as follows: I have enforced that my site and all subdomains present valid HTTPS encryption. However, you can't get a valid certificate for a domain that isn't on the public internet.

I could solve this by creating a self-signed certificate with a custom root Certificate Authority, and then adding that root CA to each of my computer's certificate stores to trust it, but that seems like a lot of hassle when I could just host the service publicly and use Let's Encrypt instead.

(Tailscale people: if you have any tips or ideas here, I'd love to hear about it!)
