+++
title = "Projects"
date = 2020-07-28T10:05:32-04:00
description = "I work on a lot of projects, often rather unproductively. Here's some of them."
draft = false
+++

Here's a snapshot of the projects I'm currently working on. I tend to gravitate to highly technical projects, or more recently anything involving machine learning.

## Launched

- **[Delphus](https://delph.us)** -- a trustable research management system. Built using TypeScript, React, and Web3. Commits encrypted data to the Ethereum blockchain to improve scientific transparency and provide data provenance. I'm working on this with a [group of other co-founders](https://delph.us/team).

- **[Zero][]** -- my homelab, running a Matrix server, GitLab, Asterisk, and the blog you're currently reading, along with a constellation of other services that I use daily. I run a collection of Ubuntu VMs using [Proxmox][], and run [microk8s][] to deploy my services to Kubernetes.

[Zero]: https://gitlab.kliu.io/kevin/zero
[Proxmox]: https://proxmox.com/en/
[microk8s]: https://microk8s.io

## Under Construction

- **Stanford One for the World website** -- a website for the Stanford [One for the World chapter](https://1fortheworld.org/), encouraging students to pledge to donate at least 1% of their income to effective charities. For context, research demonstrates that effective charities can save a life with funding on the order of ~$500-1000. It's crazy how neglected this is.

- **Learning machine learning** -- I'd like to [go into AI safety][] in the future. To work toward this, I'm currently learning basic ML techniques, after which I'd like to dive into Reinforcement Learning or something similar. I'm also very interested in [GPT-3][] and OpenAI's other models. (If you know of any good resources or tips on getting started, please [let me know][]!)

[go into AI safety]: https://80000hours.org/problem-profiles/positively-shaping-artificial-intelligence/
[GPT-3]: https://arxiv.org/abs/2005.14165
[let me know]: /about

## Completed & Past Projects

- **[gasleaks.info](https://gasleaks.info)** -- Open access to National Grid, HEET's, and Gas Safety Inc.'s' data on gas leaks in Acton, MA. Natural gas leaks are a major problem in New England's aging infrastructure, and can contribute to ~10% of Massachusetts greenhouse gas emissions. I worked on this project at Resource Force, a club at Acton-Boxborough Regional High School.

- **[Netflix Party Reborn](https://github.com/kliu128/netflix-party-reborn)** -- a lightly-updated fork of Netflix Party to get the extension working properly on modern versions of Firefox.

- **[giffs](https://gitlab.kliu.io/kevin/giffs)** -- a FUSE filesystem that appends a GIF header to every file (in case you ever needed it). Effectively prefixes every file with a given prefix.

- **[cubic20](https://gitlab.kliu.io/kevin/cubic20)** -- an Android app to give reminders every 20 minutes to maintain eye health. Dreadfully out-of-date now, thanks to Android's strict power saving behaviors, but may still be useful.

- **[AB Robotics control code](https://github.com/acton-robotics-team/ftc_app)** for control of an FTC robot.

### Hackathon Projects

{{<details "Show all">}}

- Cortex -- ETHWaterloo 2019 -- Torus, ENS, and NuCypher Sponsor Awards
- reBlock -- MIT Bitcoin Expo 2018 -- 2nd Place
- reBlock -- MAHacks III - 1st Place
- Delphus - DoraHacks GHS - 1st Place
- Akira -- LexHack -- 2nd Place
- Litcoin -- HackNEHS -- 3rd Place
- Duck Feed -- HackExeter 2017 -- Developer's Award
- Production Focus -- HackExeter 2018 -- Production Focus
- Hack3 2020 -- Organizer

{{</details>}}

## Ideas

Unfortunately, there isn't enough time in the world to pursue every idea. Here are the ones I'm currently thinking about doing. Feel free to pick one up, and [let me know](/about) how it goes!

- [2020-07-27] A GPT-2/3 persuasion bot. Make GPT-X predict both its output _and the user's response_ several times. Then, use sentiment analysis or another form of ranking to evaluate how convinced the user is of a certain claim from each possible GPT statement. Pick the most convincing one, and repeat.
- [2020-07-26] A web extension that shows when an NPM package supports TypeScript on the NPM registry pages.
- [2020-07-08] A web extension to block spiders or other phobia-inducing images from the internet, using a machine learning model. I started working on [Image Begone](https://gitlab.kliu.io/kevin/image-begone), but I decided to pause to learn more about the fundamentals of ML first.