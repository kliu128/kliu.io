---
layout: post
comments: true
title: Large Language Models can Simulate Everything
date: 2023-05-13
tags: [tech, ai, simulation]
description: And they should.
---

<!-- Output copied to clipboard! -->

<!-----

Yay, no errors, warnings, or alerts!

Conversion time: 0.562 seconds.


Using this Markdown file:

1. Paste this output into your source file.
2. See the notes and action items below regarding this conversion run.
3. Check the rendered output (headings, lists, code blocks, tables) for proper
   formatting and use a linkchecker before you publish this page.

Conversion notes:

* Docs to Markdown version 1.0β34
* Sat May 13 2023 14:49:33 GMT-0700 (PDT)
* Source doc: AI #1-3 - simulation, compute, and quantification
* This is a partial selection. Check to make sure intra-doc links work.
----->

And they should.

TL; DR: Simulation is the only way to forecast how future complex / AI systems will misbehave.

This is post #1 in a series of 3 outlining my current views on AI. Part 1 focuses on the need for improving how people _think_, rather than improving their leverage over the world. Part 2 gives “no brainer,” objective strategies helpful for improving the safety of ML systems on the margin. Part 3 focuses on the best ways to measure and empirically evaluate ML systems as they are deployed in the world.

A hot take: the #2 most important use case for AI in the next decade will be performing large-scale, _in-silico_ sociological simulations.

This has _huge_ potential for safety; in a world where 99% of AI innovations make us more productive with less oversight (giving us a bigger hammer), it’s important to better understand _where to point_ that hammer. Simulation and forecasting techniques can help us improve institutional decision-making, provide plausible tail scenarios with natural language feedback, and help us run instant, virtual A/B tests to iterate faster on all levels of policy and design.

# Why simulation?

The world is incredibly complex. Many real-world scenarios we care about lack closed-form solutions; no unified theory will tell you how the Inflation Reduction Act will impact manufacturing in 2023 or what the public sentiment for artificial meat will be like in 2026. Humans are complex, and their interactions are even more so.

Today, we rely on simple simulations and forecasts of all kinds to guide policy. Traffic simulations can show when a road needs to be widened (or narrowed). Quant traders develop hundreds of economic models to guide trades. Computational biology is huge on _in-silico_ experiments, because the cycle time is >10x faster than real experiments. The Congressional Budget Office is essentially a government-sponsored modeling and forecasting organization, with special insider data agreements with major corporations.

However, _human_ simulations today lack lots of the world’s complexity. You might have a complex physics simulator for dynamics problems, but if you’re simulating people, it’s usually a basic ~linear model dreamt up by the experiment designer.

Language models may let us do better. As they improve, they’ll be able to predict local human interactions with higher & higher realism. Simulated agents could talk to each other, spread information, and interact with mocked interfaces to the world. This could unlock _useful_ simulations for fields that historically have struggled: psychology, economics, etc.

## Simulation & the General LLM Company as a blueprint for reliable agents

Moreover, at least right now, we have human oversight on everything. But autonomous LLM agents are coming, _very_ soon — nothing fundamentally prevents a fine-tuned GPT-4.5 from being good at coherent long-term planning in an agent loop. This begins to upturn the human supervision trees of society.

I suspect that LLM agents will soon be organized into a _General LLM Company_ — a virtual company of LLMs, with each “employee” specialized into a particular task. Consider humans: every human is unreliable (makes mistakes, goes on vacation, gets sick); however, over millennia, we’ve developed logical org structures that improve the reliability & capabilities of the higher-level unit. Similarly, every LLM is unreliable and not particularly capable; but if researchers figure out how to arrange LLMs into a _reliable organizational unit_, that unit becomes usable with extremely minimal oversight. This also seems much easier than using training-time compute to achieve reliability (bigger model, etc.), due to the diminishing returns per dollar to scaling.

For example, imagine a research system that spins up researchers, checkers, and managers in seconds, passing messages and virtual DMs until the “CEO” decides the final response is correct.[^1] Such a system has far higher reliability than any individual LLM agent. Also, it’s _way_ less overhead than a human company; instead of Certificates of Incorporation, hour-long business meetings, Slack, and middle management, the [org chart can be code](https://hci.stanford.edu/publications/2017/flashorgs/flash-orgs-chi-2017.pdf), and LLMs can skip the breaks, hiring, and HR. An LLM company can be spun up and dissolved to provide reliable answers, even for basic tasks.[^2]

LLM companies will massively increase complexity. If you thought a [single &lt;175b parameter model](https://chat.openai.com) replacing your Google algorithm was weird, imagine when it’s a community of 15 procedurally-hired agents. Imagine the leverage, and ensuing complexity, when you give LLM companies the ability to _spin up and oversee their own sub-companies_.

Once we have LLM companies, how do we ensure they’re safe? In the current regime, we regulate companies post-hoc once they do a bad thing. (See: Exxon, airlines, etc.) Due to the high stakes though, it’d be nice to predict errors in advance. And given the weaknesses of corporate sociology on _human_ companies & psychology on individual humans, I think empirical simulation is the only way we can avoid forced errors here.

## LLM simulation is useful today

An incomplete list of use cases:

- **Online trust & safety**. Can we simulate the effects of policy changes on social media platforms, along with how people will try to abuse them?
- **Community notes for everything.** Can automated AI teams produce clarifications on social media posts that most people would agree on? Essentially automating Community Notes/Polis for _every post_ anyone makes.
- **Empirical sociology.** Can we understand information diffusion, disinformation, etc. all in silicon? Could we A/B test org charts, democratic structures, and voting systems?
- **Econ & psychology**. Can we simulate surveys 1000x faster than real time, allowing for fast wording / design iterations? Can we simulate psychological effects in-silico in silico?
- **A time travel murder mystery video game.** Ok, imagine this one. Go back in time to before you were murdered and talk to a virtual cabal of agents. Simulate weeks in seconds, so you can see how your actions affect the future.
- **Automating prediction markets.** [Can GPT-4 debate amongst its peers
  to](https://astralcodexten.substack.com/p/mantic-monday-42423) put a number on
  anything? When prediction markets are free, what becomes possible? Everyone
  gets a human-expert-level prediction market, to make life choices, etc?
- **Deliberative democracy.** Can we simulate deliberative polling among many stakeholders to speed up negotiations?
- **And more**. Talk to me about the dangerous ones.

# How do we get there?

One potential 2030 looks like this. We use LLMs to simulate everything, including scenarios like “What could happen if we give this LLM configuration access to institutional trading APIs,” “What does the attack-defense balance between AI-powered disinformation & verifiers look like on social media,” and “What regulatory paths avert a potential war with China?” The simulations can’t tell us what will happen, but they can say what _might_, including natural language descriptions of key tail outcomes. Summarization systems distill thousands of rollouts into executive summaries and auto-identified quantitative metrics, helping us make more principled and safer decisions.

I have no fifteen-step plan that gets us there. But I’d probably guess that it starts with a niche — a specialized system for trust and safety, economics, or deliberative democracy. An engineer makes a framework to lower the barrier for simulation. Researchers focus on aligning models to _calibrated_ _human likeness_ rather than helpfulness and direct capabilities. Hardware engineers & OSS developers drive the cost of human-aligned inference to zero, so we can make our simulations more complex and realistic with every passing year.

I want to make this happen. If you’re interested or have ideas, [reach out](mailto:liuk@stanford.edu).

# Acknowledgements

Thanks to Tejal Patwardhan, Kunal Sharda, Casey Manning, Julian Quevedo, Colin Megill, and Alexey Guzey for providing insightful feedback and/or inspiration for this post.

# References

- [[2208.04024] Social Simulacra: Creating Populated Prototypes for Social Computing Systems](https://arxiv.org/abs/2208.04024)
- [[2304.03442] Generative Agents: Interactive Simulacra of Human Behavior](https://arxiv.org/abs/2304.03442)
- DeepMind, [Fine-tuning language models to find agreement among humans with diverse preferences](https://www.deepmind.com/publications/fine-tuning-language-models-to-find-agreement-among-humans-with-diverse-preferences)
- Organizations: [Collective Intelligence Project](https://cip.org/) & [Polis](https://pol.is/home)
- Jan Leike (OpenAI), [A proposal for importing society’s values](https://aligned.substack.com/p/a-proposal-for-importing-societys-values)
- Jacob Steinhardt (UC Berkeley), [Complex Systems are Hard to Control](https://bounded-regret.ghost.io/complex-systems-are-hard-to-control/)
- Colin Megill (cofounder at Polis), [tweet thread on AI + deliberative democracy](https://twitter.com/colinmegill/status/1651368105992671232)

<!-- Footnotes themselves at the bottom. -->

[^1]: In this framing, all multi-prompt LM systems (e.g. constitutional AI, revision) are all incremental progress toward emulating the org structures and policies of human companies.
[^2]: I think of this as the dishwasher analogy — just because a human is an integrated system doesn’t mean AGI has to be. It can be more of a “brute force” or structured approach compared to humans.
