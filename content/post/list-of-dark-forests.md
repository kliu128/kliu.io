+++
title = "List of real-world dark forests and detection techniques"
date = 2021-12-19T17:43:34-05:00
summary =  "CHANGEME"
draft = true
toc = false
categories = []
tags = []
images = []
+++

> The universe is a dark forest. Every civilization is an armed hunter stalking through the trees like a ghost, gently pushing aside branches that block the path and trying to tread without sound. Even breathing is done with care. The hunter has to be careful, because everywhere in the forest are stealthy hunters like him. If he finds other life—another hunter, an angel or a demon, a delicate infant or a tottering old man, a fairy or a demigod—there’s only one thing he can do: open fire and eliminate them. In this forest, hell is other people.
>
> -- [Cixin Liu, _The Dark Forest_](https://www.goodreads.com/quotes/7378369-the-universe-is-a-dark-forest-every-civilization-is-an)

_The Dark Forest_ paints a grim picture of interstellar life, where one wrong move can reveal your presence and lead to guaranteed death. Recently, I've seen this concept come up again and again in surprisingly unintuitive ways, so I wanted to collate a few known instances here.

# Ethereum / cryptocurrencies

- Miner-extracted value https://quantstamp.com/blog/mev-ethereums-dark-forest-and-keeperdao
- Dark forest smart contract front running https://www.paradigm.xyz/2020/08/ethereum-is-a-dark-forest/

# The web

- Everything being used for fingerprinting e.g. pool party attacks https://brave.com/privacy-updates/13-pool-party-side-channels/

# Tor / cybersecurity

- Side-channel attacks of all kinds
- Scanners / color printers
- New vulnerabilities must be patched within 24-72 hours of disclosure https://threatpost.com/mean-time-hardening-next-gen-security-metric/151402/, 80% of 320 honeypots were compromised within 24 hours https://unit42.paloaltonetworks.com/exposed-services-public-clouds/#:~:text=Researchers%20found%20that%2080%25%20of,for%20the%20other%20three%20applications.
- EMF from power lines can be used to timestamp a large majority of videos https://www.youtube.com/watch?v=e0elNU0iOMY

# AGI

- Boxed myopic AI, "The Box" https://arxiv.org/pdf/1905.12186.pdf (will it be penetrated? Probably.)

# 2b2t

2b2t is a Minecraft anarchy server with cheats allowed. Traditionally, the only way to escape death is to run as far away from spawn as possible, ensuring nobody knows the coordinates of your base. Any base is easily griefed when found, while building is asymmetrically much harder.

1. From 2018-2021, the location of anyone moving around on the server was exposed and logged by the user leijurv using a poorly-known exploit plus [insanely complex systems engineering](https://github.com/nerdsinspace/nocom-explanation/blob/main/README.md).
1. Even without that, if you ever took a picture that showed Bedrock (a block whose exact texture is algorithmically determined from its coordinates), you could be deanonymized with a few hours of GPU/OpenCL brute-forcing of Minecraft generations.
1. When the [Log4j](TODO) exploit was released, it only took a day TODO until it was exploited.

- Log4j - exploit existed for N hours before someone found it

# Real life

- Shreshth and the cheeseburger
