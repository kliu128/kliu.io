---
layout: post
comments: true
title: A Tale of Two Servers
date: 2019-04-02T16:01:45-04:00
description: "Two servers, one IP address. Featuring SNI proxies, SSH, and everyone's favorite service to self-host: mail!"
tags: tech homelab
categories: ""
---

<!-- +++
layout = "post"
title = "A Tale of Two Servers"
date = 2019-04-02T16:01:45-04:00
summary = "Two servers, one IP address. Featuring SNI proxies, SSH, and everyone's favorite service to self-host: mail!"
draft = false
toc = false
categories = []
tags = ["tech", "homelab"]
images = []
+++ -->

Recently (due to causes unimportant in this blog post), I was tasked with running a self-hosted server in my residence. Now, as a seasoned Linux system administrator (heh), this would normally be a fairly easy task. The server had to run web services, mail, and GitLab, which typically would only necessitate some port forwarding.

Complicating things, however, was the fact that I _already had_ a server in my house, which also runs web services, mail, and GitLab. Since residential homes are usually only given one IP address, mine being no exception, this meant I had to find some way to host both servers on one IP address.

Here's how I did it!

## Web - Port 80, 443

Web servers are typically pretty easy to proxy. Set up `nginx` and a few virtual hosts, and voilá.

Unfortunately, both servers (hosting `potatofrom.space` and an unnamed sister site[^1]) use HTTPS with Let's Encrypt. With a reverse proxy setup like `nginx`, `nginx` would have to manage all TLS certificates for both sites, which is not what I wanted, since I wanted both servers to maintain separate configurations. (It is a distinct possibility that I might end up giving back or decommissioning the other server at some point.) This sort of setup would also require manual updates whenever I added a subdomain on either `potatofrom.space` or the other site.

I had some ridiculous ideas at first, namely to use a Raspberry Pi or other device with nginx and two wildcard Let's Encrypt certificates (`*.potatofrom.space`, `*.<redacted>`) for simpler proxying. But that too seemed annoying.

Then came [SNIPROXY](https://github.com/dlundquist/sniproxy)!

If you have never had the good fortune of coming across this incredible piece of software, it lets you proxy TLS, without providing certificates. If you're like me, this blew your mind.

Here's how it works:

- To support hosting multiple (sub)domains on one IP with different certificates, TLS has an extension called Server Name Indication (SNI), where the client sends the name of the server they want to connect to in their handshake.
- The SNI message is _unencrypted_. It happens before setting up encryption!

(This design also leads to [some privacy issues](https://blog.cloudflare.com/esni/).)

`sniproxy` hence looks at that first SNI message, then sets up the connection with the backend server _without touching encryption at all_. After that first handshake, it merely relays encrypted ciphertext. The upshot of this is that each of my servers can keep on managing their own Let's Encrypt certificates, minimizing workflow disruptions. It also makes `sniproxy` configuration much simpler. Here's my config right now:

```
error_log {
  # Log to the daemon syslog facility
  syslog daemon
}
# Global access log for all listeners
access_log {
  # Log to the daemon syslog facility
  syslog daemon
}
listen 80 {
  proto http
}
listen 443 {
  proto tls
}
table {
  ^((.+\.)|())potatofrom\.space$ 10.99.0.1
  ^((.+\.)|())redacted\.com$ 192.168.1.3
}
```

Wonderfully simple.

## GitLab - Port 22

A self-hosted GitLab instance generally runs an SSH daemon port 22, so that users can clone repositories through SSH.

Unfortunately, [it appears SSH does not send the hostname as part of the protocol](https://serverfault.com/questions/34552/is-there-a-name-based-virtual-host-ssh-reverse-proxy), so hosting multiple SSH servers on the same port is impossible.

After some consideration, I decided to just turn off SSH for https://gitlab.potatofrom.space, since I'm the only one using it. I switched instead to cloning through HTTPS using personal access tokens.

## Mail - Ports 25, 110, 143, 465, 587, 993, 995, Oh My!

Mail servers use... a lot of ports. Thankfully, only some of them are really necessary.

- **25 (SMTP)**: This port _must_ be publicly-accessible by other mail servers so they can deliver mail to you. This port is _not configurable_, no matter how much [RFC 6186](https://tools.ietf.org/html/rfc6186) might tell you otherwise.[^2]
- **587 (SMTP)**: Mail submission for email clients. This has to be different from port 25, since [a][1] [lot][2] [of][3] [internet service providers][4] block port 25 for users. You can change it from 587, though; you just need to reconfigure your mail clients if so.
- **143 (IMAP)**: Modern mail retrieval for mail clients.[^3] Again, this port can be changed, but you will need to reconfigure mail clients.

[1]: https://forums.att.com/t5/AT-T-Internet-Features/Unblock-port-25/td-p/4343420
[2]: https://forums.verizon.com/t5/Verizon-net-Email/Verizon-is-blocking-TCP-port-25/td-p/851629
[3]: https://community.cisco.com/t5/routing/block-outbound-port-25/td-p/1198091
[4]: https://www.xfinity.com/support/articles/email-port-25-no-longer-supported

Resolving the conflict on ports 143 and 587 was simple enough: I forwarded 143 and 587 to the new server and forwarded 10143 and 10587 to my old one. Port 25 was annoying, though.

In the end, I figured the best way to do it would be to have the new server forward any mail it got for `potatofrom.space` to my personal mailserver. This way, the new server would be the sole public-facing presence on my IP, but I would still be able to receive mail on both servers. Since the new server uses [Mailu](https://mailu.io), which has a "relayed domains" feature, I figured this would be fairly easy.

As with all things mail, it was not.

To all the poor souls (or future mes) facing the same problem, here's the magic incantation:

```
smtpd_client_restrictions =
  permit_mynetworks,
  reject_non_fqdn_sender,
  reject_unknown_sender_domain,
  reject_unknown_recipient_domain,
  permit
```

In `postfix.cf`. Note the [lack of `reject_unverified_recipient`](https://github.com/Mailu/Mailu/blob/94e42c9b520557387520622306af0a23458a0ccb/core/postfix/conf/main.cf#L93). This stopped Mailu from preemptively rejecting the mail _even though_ I had explicitly configured it for relaying.

Then, I added the Mailu server's IP address as a `TrustedHosts` on my own mailserver, so that it wouldn't get tilted and reject what it was receiving.

And voilá! A few server reconfigurations on my side, and both servers were now working.

## Conclusion

Should you do this? Probably not. [Just get another IP address](https://www.verizon.com/business). Or, uh, don't have two servers?

If, however, you are like me, and want the lowest-cost, least-disruption solution... well, here you are.

[^1]: Yes, I know basically anyone could find out what the other server is, considering I literally said it's on the same IP address as the website you're looking at now. Still, for confidentiality's sake I'd rather not say.
[^2]: I haven't read RFC 6186 too closely, but I _think_ it's usage of the `_submission` SRV record may only be for mail user agents to follow, not other mail servers. In any case, I wouldn't want to rely on it when forty years of backwards compatibility argue against it.
[^3]: Please don't use POP3.
