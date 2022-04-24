---
layout: post
comments: true
title: Scenarios and Warning Signs for Ajeya's Aggressive, Conservative, and Best Guess AI Timelines
date: 2021-03-28
description: A summary and rephrasal of three plausible scenarios for AI timelines. Most of this post is unoriginal. Cross-posted to LessWrong, and may contain more jargon than usual.
tags: [tech, ai-safety]
---

_This post is [cross-posted](https://www.lesswrong.com/posts/kQt3LsNAqxCh8qkaN/scenarios-and-warning-signs-for-ajeya-s-aggressive) to LessWrong, a rationality and AI safety community. May contain more jargon than usual._

Epistemic status: mild confidence that this provides interesting discussion and debate.

Credits to (in no particular order) Mark Xu, Sydney Von Arx, Jack Ryan, Sidney Hough, Kuhan Jeyapragasan, and Pranay Mittal for resources and feedback. Credits to Ajeya (obviously), Daniel Kokotajlo, Gwern, Robin Hanson, and many others for perspectives on timeline cruxes. This post was written as part of a 10-week AI Safety Fellowship run by Mark. All errors my own.

## Summary

Most of this post is unoriginal. It is intended primarily to summarize and rephrase the core distinctions between three plausible scenarios for AI development, which Ajeya lays out in her [draft report on AI timelines](https://docs.google.com/document/d/1IJ6Sr-gPeXdSJugFulwIpvavc0atjHGM82QjIfUSBGQ/edit#). It also contains summaries and links to other related content.

As a secondary goal, it attempts to lay out concrete and hopefully plausible predictions for what would occur in each of these three worlds.

## Glossary (from Ajeya's report)

This post will assume familiarity with basic terminology regarding neural networks and supervised learning.

Before reading this post, it's probably good to read at least a summary of Ajeya's report (e.g. [Rohin Shah's](https://www.lesswrong.com/posts/KrJfoZzpSDpnrv9va/draft-report-on-ai-timelines?commentId=7d4q79ntst6ryaxWD)). Some timeline-specific terminology that is helpful to know is also listed below:

- **Transformative AI (TAI)**: A computer program that is as transformative as the Industrial Revolution was to the world's trajectory.[^tai-defn]
- **Effective horizon length (EHL)**: the "length of the task"; more precisely, Ajeya defines it as the amount of data measured in subjective seconds of experience (~how long a human would take to do it) to tell whether a model has performed a task better or worse than it did previously. For some things (e.g. predict next word in the sentence), the length is quite low; for others (e.g. run a corporation that maximizes profit), the length may be quite high.
- **Anchor**: A concept on which to base the estimated number of FLOPS (floating-point operations/second) required to **train** a transformative AI. For example, you might use an Evolution Anchor, which is roughly the compute performed over all of evolution; or a Short Horizon Neural Network (NN) Anchor, which is the extrapolated compute expected for a neural network that is trained on a short horizon length. Key anchors are:
  - **Lifetime anchor**: the amount of compute performed by "one human brain over one lifetime."
  - **Short/medium/long-horizon NN**: the compute required to train a NN of a size anchored to the human brain on short, medium, or long-horizon tasks, respectively.
  - **Evolution anchor**: the amount of compute performed over all of evolution.

[^tai-defn]: See https://docs.google.com/document/d/1IJ6Sr-gPeXdSJugFulwIpvavc0atjHGM82QjIfUSBGQ/edit#heading=h.6t4rel10jbcj

## Scenario One

If you believe...

### Short-horizon NN has a fair chance of succeeding (e.g. 40%)[^hypotheses-caveat]

You might believe this if you think there's a good chance it is sufficient to fine-tune a large language model like GPT-N for TAI, and there's no need to train models directly on tasks that take a long time to judge (e.g. "writing a twist ending to a story", as opposed to "predict next word"). Concrete things you might expect to happen soon would thus be:

1. GPT-4+ can be fine-tuned to perform longer-horizon tasks, such as writing long and coherent stories, with less compute cost than the original pretraining.
2. This capability to generalize improves as the pre-training process improves (e.g. GPT-5 is much better at fine-tuning than GPT-4, which is much better than GPT-3). [The scaling laws of model generalization](https://www.alignmentforum.org/posts/pqkdsqd6s6w2HtT9g/intermittent-distillations-1#Scaling_Laws_for_Transfer__Danny_Hernandez_) perhaps hold up for much larger models.
3. By 2030, short-horizon models have achieved at least partial meta-learning. For example, an RL model can learn to play novel video games as well as a human can after a few hours of practice. (This criterion comes from a Q&A with Ajeya, although the timeline estimate is my own.)

For more reading, see [Ajeya on downstream skills](https://docs.google.com/document/d/1PaYOh_9BAYEm3RfpeX0G-cvs5JxGns98IsVK061jqRQ/edit#heading=h.f8rh9g7pqv91).

[^hypotheses-caveat]: This crux simplifies Ajeya's [range of estimates for hypothesis probabilities](https://docs.google.com/document/d/1cCJjzZaJ7ATbq8N2fvhmsDOUWdm7t3uSSXv6bD0E_GM/edit#) considerably. For each scenario, I've used the most probable anchor as the "central crux", as it seems to me that if you believe short-horizon NN is 40% likely to work, then the other hypotheses are also fairly sensible.

### Algorithms halve compute requirements every ~2 years for short-horizon NNs, or every ~1 year for a medium/long-horizon NN.

You might expect this if you think there is a lot of "low-hanging fruit" in algorithms, such as if you think relatively little work has gone into optimizing training regimes or architectures for large NNs. (For context, OpenAI's [AI & Efficiency](https://openai.com/blog/ai-and-efficiency/) suggests a halving time of ~16 months for ImageNet models.) Consequences you might expect are:

1. An increase in companies working to improve massive (>100bn parameter) language models. For example, you might expect at least 5 large tech companies working on algorithms by 2025, as opposed to "mostly only OpenAI & [Google](https://arxiv.org/abs/2101.03961) in 2020".[^gwern-is-cool] Some evidence possibly in favor of this is that Alibaba + Tsinghua University recently released (Feb 2021) [M6: A Chinese Multimodal Pretrainer](https://arxiv.org/pdf/2103.00823.pdf) with 100 billion parameters (although this uses a Mixture of Experts model whose efficacy I am unfamiliar with).
2. Multiple significant (e.g. 4x+) speedups targeted specifically toward training large language models by 2030. (This implies that there is significant low-hanging fruit being taken.)

[^gwern-is-cool]: This is reminiscent of Gwern's [earlier post](https://www.lesswrong.com/posts/N6vZEnCn6A95Xn39p/are-we-in-an-ai-overhang?commentId=jbD8siv7GMWxRro43) from "Are we in an AI overhang?"

### Moore's Law returns, resulting in ~1.5 year doubling times for FLOPs/$ to train a model.

For context, Moore's law described transistor progress well until the mid-2000s, when the regime shifted to a doubling time of ~3-4 years[^moore]. One possible story for a return to ~1.5-year doubling times is that the number of chip producers increases, with players perhaps aided by AI-assisted chip manufacturing. Moore's Law is rather hard to predict, but concrete things that _might_ allow this are:

1. **Arms race**: [The European Union makes a competitive semiconductor manufacturing factory](https://www.bloomberg.com/news/articles/2021-02-11/europe-weighs-semiconductor-foundry-to-fix-supply-chain-risk). Semiconductor manufacturing becomes more politicized, encouraging an "arms race" of sorts. One reason this might happen is if [China invades Taiwan](https://www.theguardian.com/world/2021/mar/10/china-could-invade-taiwan-in-next-six-years-top-us-admiral-warns), possibly taking over major semiconductor manufacturing company TSMC.
2. **Competition**: [Intel](https://seekingalpha.com/article/4392173-tsmc-to-fall-behind-intel-samsung-2024) and [Samsung](https://www.bloomberg.com/news/articles/2020-11-17/samsung-intensifies-chip-wars-with-bet-it-can-catch-tsmc-by-2022) catch up with TSMC for chip manufacturing. There are several chip manufacturers in direct competition at the cutting edge by 2025.
3. **AI-assisted chip fabrication**: E.g. a 10x decrease in cost by 2030 due to ML systems that make various parts of production more efficient. Current examples include [listening for defects in production](https://arstechnica.com/information-technology/2019/06/manufacturing-memory-means-scribing-silicon-in-a-sea-of-sensors/?comments=1), [chip placement with RL](https://ai.googleblog.com/2020/04/chip-design-with-deep-reinforcement.html), [optimizing chip architectures for a given model](https://ai.googleblog.com/2021/02/machine-learning-for-computer.html), or [electronic design automation](https://www.edn.com/machine-learning-in-eda-accelerates-the-design-cycle/).

### AI companies are rapidly willing to spend 2% of GDP to train a transformative model.

This looks like AI companies rapidly realizing the immense value of training bigger AI, so they rapidly scale up until they are limited by capital-on-hand in 2030. From that point on, they are willing to spend 2% of GDP on training a model. You might expect this if:

1. AI shows concrete economic benefits in the short term. Commercialization of GPT models earns $>1bn in revenue by 2025[^hansonbet], with customers willing to pay for the outputs of fine-tuned models or more polished AI-assisted GPT products.
2. Big tech companies like Google realize the profit opportunity and begin to quickly scale up models (and pricing models) of their own. One concrete example is "Google makes DeepMind build a GPT-N competitor, which it contracts to governments or other institutions."
3. By 2025, the US or similar national government experiments with training a large language model. (This implies government involvement in AI, which could dramatically increase funding.)

[^hansonbet]: Credits to Robin Hanson's bet here: https://twitter.com/robinhanson/status/1297325331158913025

**Given the above, you should expect a median timeline of 2036, shaded up by Ajeya to 2040.**

[^moore]: Sourced from https://docs.google.com/document/d/1cCJjzZaJ7ATbq8N2fvhmsDOUWdm7t3uSSXv6bD0E_GM/edit#heading=h.96w8mskhfp5l

## Scenario Two

### NNs likely require some medium- to long-horizon training.

You might believe this if you think scaling up GPT-3 doesn't quite lead to TAI. It gets you a good bit of the way there, but turns out you need a more complex environment to learn _how to learn_ new tasks. This might look like:

1. **Fine-tuning hits a wall**: By 2025, it's clear that massive fine-tuned language models _underperform_ in comparison to smaller models that use supervised learning directly on the question at hand (e.g. large-scale code generation). Concretely, a possible scenario is that GPT-5-CodeCompletionXL performs worse than a new TransformerCodeM model, which was trained directly on sets of code completion questions rather than unsupervised learning like GPT.

   This implies that new advances will be required to reach scalable TAI.

   ([Ajeya mentions](https://docs.google.com/document/d/1PaYOh_9BAYEm3RfpeX0G-cvs5JxGns98IsVK061jqRQ/edit#heading=h.f8rh9g7pqv91) some reasons why you might expect a from-scratch supervised model to outperform a fine-tuned language model, but whether it would do so in reality is an open question.)

2. **Training on long horizons becomes popular**: By 2030, there exist 2+ models achieving state-of-the-art performance in a specific field that use training on long horizons (greater than few minutes). For example, a novel-writing AI that receives feedback only after finishing a novel, or an RL agent that plays long and complex games.

### Algorithmic progress is a bit slower than it was in the past, halving compute every 3 years for short-horizon NNs, 2 years for medium & long-horizon NNs.

You might believe this if you think most of the low-hanging fruit has been picked. Architectural advancements slow down, with each one representing mostly incremental progress.

(For further reading and intuitions, AI Impacts has a page with [many examples of past algorithmic progress](https://aiimpacts.org/trends-in-algorithmic-progress/). See also the posts mentioned in Ajeya's paper: [Measuring the Algorithmic Efficacy of Neural Networks (2020)](https://arxiv.org/pdf/2005.04305.pdf) and [Algorithmic Progress in Six Domains (2013)](https://intelligence.org/files/AlgorithmicProgress.pdf).)

Things you may expect are:

1. By 2025, the number of companies working on large language models has plateaued or even declined. E.g. [Google Brain and DeepMind still refuse to buy into the scaling hypothesis](https://www.gwern.net/newsletter/2020/05#gpt-3); large language model startups (e.g. [Cohere](https://cohere.ai/mlrs)) have flopped.
2. By 2025, the large size and training time of models becomes a bottleneck to experimentation. For example, if it takes weeks and significant compute resources to run an experiment to improve efficiency, then testing out new improvements becomes much slower. We see some hints of this in the training of [OpenAI Five ("surgery")](https://arxiv.org/pdf/1912.06680.pdf), although it's unclear to me how much of a time penalty this adds, or if this problem can be avoided by using smaller models to experiment with improvements rather than bigger ones.

### Moore's Law slows a bit. FLOPS/$ doubles every 2.5 years.

By 2025, the general consensus is that Moore's Law is dead. TSMC, Intel, and Samsung hit manufacturing delays in new nodes, and it is projected that doubling time will increase. There is a solid path for further growth, but the path forward is hard, and chip designers focus more on optimizing preexisting nodes much like Intel does today.

Things you might expect are:

1. By 2025, Intel, Samsung, and TSMC all [fall behind on their cadences](https://seekingalpha.com/article/4392173-tsmc-to-fall-behind-intel-samsung-2024). Delays, like those that have [plagued Intel](https://www.bbc.com/news/technology-53525710), spread to the entire industry.
2. Competition remains slim. For example, current export restrictions on semiconductors[^more-than-you-wanted-to-know-about-semiconductors] are successful at limiting China's semiconductor fabrication _without triggering an arms race_, preventing additional competition from arising.

[^more-than-you-wanted-to-know-about-semiconductors]: The US has recently [prevented Chinese companies such as SMIC](https://www.tomshardware.com/news/smic-import-restrictions) from getting high-end manufacturing equipment. It also has [worked with the Dutch](https://www.brookings.edu/techstream/the-chip-making-machine-at-the-center-of-chinese-dual-use-concerns/) to deny ASML, a machine manufacturing company, from delivering high-quality EUV chip machines to China. Quick research seems to suggest that [building a manufacturing plant without US equipment](https://semiwiki.com/semiconductor-services/semiconductor-advisors/281384-asml-euv-china-chip-equip-risk/) is extremely hard, at least for now.

### AI companies are willing to spend $1bn in 2025, with that figure doubling every 2 years.

Ajeya considers this a plausible level of spending on a "business as usual" trajectory, given the current market cap and cash on hand of major tech companies. See [here](https://docs.google.com/document/d/1qjgBkoHO_kDuUYqy_Vws0fpf-dG5pTU4b8Uej6ff2Fg/edit#) for more details.

**Given the above, you should expect a median timeline of ~2052.**

## Scenario Three

### Transformative NNs likely depend highly on long-horizon training, perhaps requiring FLOPs on the order of evolutionary computation.

This looks like GPT & supervised learning hitting a dead-end for meta-learning (learning new, complex tasks). No matter how hard we try, we can't get neural networks to learn complex skills over short training timeframes. One of the options left to us is something like [RL + transparency tools](https://www.lesswrong.com/posts/fRsjBseRuvRhMPPE5/an-overview-of-11-proposals-for-building-safe-advanced-ai#1__Reinforcement_learning___transparency_tools) or supervised learning with feedback that is given only after long subjective time elapsed, which are both highly compute-intensive ways of training an agent.

Things you might expect are:

1. By 2030, spending on massive LMs plateaus such that there is <1 doubling in 3 years. The general consensus is that large language models are powerful, but yield diminishing returns, and are significantly limited at tasks that take a human more than 5 minutes to consider.
2. "AI winter;" qualitatively, advances comparable to significant advances of the past five years (e.g. AlphaGo, GPT-2, GPT-3) are much fewer and further between as low-hanging fruit is already picked. This period may last for 10+ years.

### Algorithms halve compute every 4 years for short-horizon, 3 years for medium and long horizon.

This looks a lot like Scenario Two, but is quantitatively a bit slower. Realistically, the biggest sign of this is probably just a slowing trend in 2025's "algorithmic progress" chart, but other things you might expect are:

1. A decline in discoveries of new neural network architectures and techniques for efficiency. If you were to plot the major discoveries of a field such as NLP on a graph, you would see a flurry of discoveries in the 2010s, but by the end of the 2020s progress has significantly slowed.

### Moore's law slows significantly, doubling FLOPS/$ every 3.5 years.

This might occur if [silicon process costs keep rising](https://www.extremetech.com/computing/272096-3nm-process-node), eventually becoming uneconomical even for large players. There are incremental further advancements (e.g. optimizing 3nm+++), but overall stagnation continues.

Things you might expect are:

1. By 2030, all major chip producers (e.g. Intel, AMD, Apple, NVIDIA) have significantly increased their timelines for moving to new nodes. For example, if on 3nm, they plan to move to 1nm in 3+ years.
2. More unlikely: a [state-sponsored effort to slow down chip fabrication](https://www.gwern.net/Slowing-Moores-Law), perhaps due to global war and instability.

### AI companies will have to wait for the entire economy to grow sufficiently to finance TAI.[^caveat-spending]

This follows from the slowing of Moore's Law and the need for expensive, long-horizon training. This world seems like one where advanced AI is not terribly profitable and requires resources on the scale of a 2090s [megaproject](https://en.wikipedia.org/wiki/Megaproject).

Things you might expect are:

1. Efforts to commercialize large language models are not profitable. OpenAI shuts down the GPT-3 API by 2025, opting for a different business model. Further endeavors reach only limited profitability due to limited use cases.
2. "AI winter," as discussed in the first section, causes a lack of investment in AI companies. One possible world is that spending in AI [plateaus for several decades](https://docs.google.com/document/d/1cCJjzZaJ7ATbq8N2fvhmsDOUWdm7t3uSSXv6bD0E_GM/edit#heading=h.x0pkk2mc19ey), before experiencing another period of exponential growth as a new paradigm is discovered in the late 21st century.

**Given the above, you should expect a median timeline of **2100**, shaded down to 2090 by Ajeya.**

[^caveat-spending]: This is derived from Ajeya's assumption that spending will start at 300 million dollars in 2025 and grow every 3 years, reaching a max of 100bn by 2055, at which point it is bounded at 0.5% of GDP. However, since TAI isn't projected until 2100 in this scenario anyway, in practice this means that only the upper bound really matters.

# Epistemic Notes

The above predictions are obviously rough. Even in a world that satisfies a particular timeline (e.g. AI by 2052), I expect the specifics of more than half of them to probably be wrong. However, the hope is that these predictions can be used as a sort of barometer, so that five years down the line, we can look back and ask, "how many of these came true?" The answer may help us figure out when we predict TAI to eventually arrive.

I also hope these predictions can be used today to clarify researchers' own timelines. If you believe most of the predictions in Scenario 1 are plausible, for example, you may want to update toward shorter timelines, and likewise if you think Scenario 3 is plausible, you should probably update toward later timelines.

# Other Scenarios and Open Questions

In the process of writing this and further understanding Ajeya's assumptions, I had a few ideas for other scenarios that I would enjoy seeing fleshed out.

- What happens if government spending gets involved? What are reasonable estimates for spending?
- How likely is it that tasks such as meta-learning can be solved via "secret sauce" waiting to be discovered, rather than pure algorithmic brute force?
- How do you make better predictions about Moore's Law?
- [[via Gwern]](https://www.gwern.net/newsletter/2020/05#fn19): How will a 1T-parameter language model behave? 10T? 100T?
- How will multimodal models with natural language supervision (e.g. [CLIP](https://openai.com/blog/clip/), [M6](https://arxiv.org/pdf/2103.00823.pdf)) affect algorithmic progress? Could multimodal models open a "greenfield" of low-hanging algorithmic fruit?
- What do "counterarguments to each scenario" look like? What compelling current or future evidence would cause you to reject a scenario?

# Further Reading & Related Work

Here are some of the documents I found useful while writing this post.

- [Ajeya's comments on the types of disagreements with AI timelines](https://forum.effectivealtruism.org/posts/QAqghTmp7FSMcJ4ch/ama-ajeya-cotra-researcher-at-open-phil?commentId=KnidjKuibKyrDunbZ#KnidjKuibKyrDunbZ)
- [Semiconductors and Federal Policy](https://fas.org/sgp/crs/misc/R46581.pdf)
- For context on how quickly we expect AI to gain economic value, I found [Ajeya and Gwern's discussion on the "neglectedness" of AI solutions](https://forum.effectivealtruism.org/posts/QAqghTmp7FSMcJ4ch/ama-ajeya-cotra-researcher-at-open-phil?commentId=HGu4qZx5E93JbuFDb#KnidjKuibKyrDunbZ) insightful.
- Daniel Kokotajlo's [Fun with +12 OOMs of Compute](https://www.lesswrong.com/posts/rzqACeBGycZtqCfaX) describes a thought experiment explaining how you might envision using $10^{35}$ FLOPs of compute.
