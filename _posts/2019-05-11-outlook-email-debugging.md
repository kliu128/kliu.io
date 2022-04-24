---
layout: post
comments: true
title: "Tracking Down a Fifteen-Hour Email Delay from Outlook & Office 365"
date: 2019-05-11T09:40:23-04:00
description: "TL;DR: Don't put your mail server behind a CNAME."
tags: ["tech"]
---

For the past month, emails have been (seemingly randomly) delayed to our mail server.

At first, I suspected a configuration problem on our side: it's quite hard to run a decent mail server, after all. But further confusing things was the fact that _not all emails were delayed_. The majority, in fact, were not.

Eventually, I noticed a common thread -- the delayed emails all came from Outlook or Office365.

{{< figure alt=" " caption="An example of a slow email. It was delayed 15 hours by Outlook's 'outbound protection' mail server." src="/images/2019-05-11-slow-email.png" >}}

So I went to the darkest, deepest corners of the internet, from which few return: Office 365 tech support.

- 2019-04-18 - Initial inquiry
- 2019-05-11 - Issue resolved

After a few weeks of back-and-forth, sending example email headers from those that got delayed, I eventually received the following advice:

> Hello Kevin,
>
> Thank you for your email.
>
> Is it possible to remove CNAME of [***]? If yes then remove the CNAME and then check still you are receiving email with delay.
>
> Please check and reply to this email with the outcome. I will wait for your reply.

Previously, I had the DNS set up like so: MX (mail) --> CNAME (alias to another domain) --> A (IP address of mail server). As suggested, I changed it to MX --> A, retested, and... it worked!

In summary: Outlook doesn't like MX records pointing to CNAMEs, apparently. I'd be interested to know if this is standard behavior at all or if it's just a Microsoft peculiarity (especially since all other mail servers appear to be fine with a CNAME.)

edit: Actually, [upon further research](https://exchangepedia.com/2006/12/should-mx-record-point-to-cname-records-aliases.html) it appears that RFC 2181 _does_ mandate pointing an MX directly to an A record. So Outlook is in the clear here (although most mail servers apparently handle MX -> CNAME -> A alright). An interesting quirk to keep in mind!
