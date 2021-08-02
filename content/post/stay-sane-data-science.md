+++
title = "Staying Sane in ML: Fixing Your Terrible Data Science Tools to Improve the Research Experience"
date = 2021-07-27T12:44:56-07:00
description = "While machine learning research has made incredible theoretical advances, the day-to-day tools most researchers use are... poorly optimized, to say the least. And much knowledge is locked up in people's private .bashrc files or wikis. This post aims to shed light on some very useful tools for beginning researchers."
draft = false
toc = false
categories = []
tags = []
images = []
+++

While machine learning research has made incredible theoretical advances, the day-to-day tools most researchers use are... poorly optimized, to say the least. And much knowledge is locked up in people's private .bashrc files or wikis. This post aims to shed light on some very useful tools for beginning researchers.

Expected audience: people, likely undergraduates, who are starting to do CS research that is vaguely in the "AI/ML" space. You have joined a Slack and gotten authentication credentials for this thing called a "cluster," and are probably using Python with Jupyter Notebook.

# Goals

When optimizing a development setup, I usually go for convenience and iteration speed. Long build times are [known](https://engineering.linkedin.com/blog/2018/07/how-we-improved-build-time-by-400-percent) to be a productivity issue in industry; waiting tens of minutes for Conda to install is similar.

Therefore, most of my recommendations will be geared toward changes that make you work _faster_ or _smarter_ (e.g. with more intellisense, or better keybinds).

# Hardware

## Google Colab: not even once

Google Colab is _terrible_ for large-scale projects. It's great for single-notebook prototyping, but the moment you have to edit an external Python file using the _Google Drive file interface_, you've lost.

Also, Colab's limits are terrible: constantly getting disconnected and resetting your runtime state are both irritating and a major context loss as you spend time re-running all your cells. A better setup is to run your own GPU computer -- be it on [Google Cloud](https://course.fast.ai/start_gcp), [AWS](https://course.fast.ai/start_aws), a computer lying around in your basement, or on your local compute cluster.

## Be aware of the speed of your storage

If you're using a cluster, it will likely have different *tiers of storage* -- some will be local on the specific server you're working on, others will be network storage (NFS, often called something like "dfs"). Before getting started on a project, you should read up on your cluster's storage and use **the fastest one that can fit your data**. This sometimes can save many minutes waiting for Conda to install as it thrashes a hard drive on the other side of the computer room over the network.

## Make sure your storage is backed up

You *really* don't want to lose modified code or datasets. Ensure your cluster has a backup policy, or else upload your data to a second location periodically.

# Software

## Stop using Conda

We've all seen it.

```bash
(base) ~$ conda install -c conda-forge boost
Collecting package metadata (current_repodata.json): done
Solving environment: failed with initial frozen solve. Retrying with flexible solve.
Solving environment: failed with repodata from current_repodata.json, will retry with next repodata source.
Collecting package metadata (repodata.json): done
Solving environment: failed with initial frozen solve. Retrying with flexible solve.
Solving environment: \
Found conflicts! Looking for incompatible packages.
This can take several minutes.  Press CTRL-C to abort.

(3 hours pass, your sanity declines by the minute)
```

Conda is _slow_. In a large environment, every time you want to install a new package, it can take _multiple minutes_ just for it to give you a conflict screen. This kills flow states and is unacceptable for productivity.

It also fails in a few other key aspects:

- **Reproducibility**. If you're using Conda, you have to go to special lengths to save your environment and every package's exact version, in case someone else wants to work on the same project later.
- **Top-level vs. transitive dependencies**: There's this thing in package management called _not recording every transitive dependency as if it's top level_. That is, if you install `pytorch`, it should not list all of Pytorch's dependencies as if you installed them personally. Unfortunately, Conda didn't get the memo.

### Use Pipenv/Poetry instead

Thankfully, the regular Python ecosystem has mostly transcended such limitations. A popular modern package manager is [Pipenv](https://pipenv.pypa.io/en/latest/), which satisfies both the issues above. A similar tool is [Poetry](https://python-poetry.org/), which does the same but often has [slightly better performance](https://johnfraney.ca/posts/2019/03/06/pipenv-poetry-benchmarks-ergonomics/) for interactive use.

With this approach, instead of doing `conda install numpy`, you replace it with `pipenv install numpy`.

### Or, if you must, use mamba + conda-lock

Granted, you might not want to use a Python-specific package manager. One of Conda's key benefits is that it can also install *system dependencies* for the packages you want, e.g. installing `cudatoolkit` along with `pytorch`.

If you find this functionality essential, you should really use **[Mamba](https://github.com/mamba-org/mamba)**. Basically, it's Conda, but with a 10x faster dependency solver written in C++.

Another useful tool is [conda-lock](https://github.com/conda-incubator/conda-lock), which can generate fully reproducible lock files that work on all platforms. This is useful to ensure your Conda environments are reproducible (recommended workflow [here](https://pythonspeed.com/articles/conda-dependency-management/)).

## Stop using Jupyter Notebook

If you use Jupyter Notebook (not Lab), you should feel bad. It's simple to set up, but the UI is extremely barebones, making it difficult to jump around different files. Two options are:

### Use Jupyter Lab

[Jupyter Lab](https://jupyterlab.readthedocs.io/en/stable/) is basically a slightly fancier Jupyter Notebook. It's a traditional notebook interface, with tabs and a convenient file tree on the side.

Another thing you should do is to [read the docs](https://jupyterlab.readthedocs.io/en/stable/user/interface.html) -- Jupyter Lab has a lot of features that I didn't know about. Like [Vim emulation](https://jupyterlab.readthedocs.io/en/stable/user/interface.html#keyboard-shortcuts). And [real-time collaboration](https://jupyterlab.readthedocs.io/en/stable/user/rtc.html). It's definitely worth your time.

### Use Visual Studio Code

Visual Studio Code is a _surprisingly_ good replacement for the Jupyter stack. With the Remote Development Pack, Jupyter, and Pylance extensions, you get a native notebook experience on a remote server while also getting all the benefits of VSCode autocompletion and suggestions.

However, it's not all sunshine and roses. The Remote-SSH extension is pretty finicky, often spamming reconnection popups whenever you lose network access, and it doesn't support special cluster logins like SLURM. The Jupyter extension is also going through teething pains, so expect issues like annoying scrolling, cells hanging occasionally, and frozen interfaces.

Still, though, it might all be worth it for that sweet sweet intellisense.

## Use git well

[Enough said](https://chris.beams.io/posts/git-commit/). As with any form of software engineering, you should follow the best practices of version control, committing legibly, and committing often.

## Use static types as much as you can

Quick! What's the shape of `src_frames` in this function?

```python
def convert_padding_direction(
    src_frames, src_lengths, right_to_left=False, left_to_right=False,
):
    assert right_to_left ^ left_to_right
    assert src_frames.size(0) == src_lengths.size(0)
    max_len = src_frames.size(1)
    if not src_lengths.eq(max_len).any():
        # no padding, return early
        return src_frames
    range = utils.buffered_arange(max_len).unsqueeze(-1).expand_as(src_frames)
    num_pads = (max_len - src_lengths.type_as(range)).unsqueeze(-1).unsqueeze(-1)
    if right_to_left:
        index = torch.remainder(range - num_pads, max_len)
    else:
        index = torch.remainder(range + num_pads, max_len)
    return src_frames.gather(1, index)
```

[^1]

It's pretty hard to say. Maybe go pass in some test inputs, or trace the rest of the program whenever it uses this function? This debugging process turns a two-minute modification into a twenty-minute one, as you struggle to reverse engineer what the code expects.

[^1]: Sourced from https://github.com/freewym/espresso/blob/master/espresso/tools/utils.py and modified for pedagogical purposes.

That's why you need something like [torchtyping](https://github.com/patrick-kidger/torchtyping) or [TensorAnnotations](https://github.com/deepmind/tensor_annotations). With it, you can write your code like `def analyze_image(img: TensorType["batch", 3, 224, 224])` and make it much easier for someone else to use the function later. It'll take 2 seconds of effort upfront and save 2 hours of debugging later.

## Write documentation

Similar to the above, when dealing with complex tensor functions or domain-specific operations, it's very hard to tell what a function does from its name. *Write doc comments* that describe the purpose of the function in laymen's words, and describe all important inputs/outputs (with tensor shapes, if you aren't using a typing library).

## Write tests, for crying out loud

There's nothing worse than having a massive, amorphous blob of Python code and circular imports. Any touch is likely to break something deep within a long-forgotten notebook or manual script.

To have at least a modicum of confidence, you should write tests (at least smoke tests) to make sure your code works as expected and _keeps working as expected_. One good testing library is [pytest](https://pytest.org/); there are also ways to [embed tests in Jupyter notebooks](https://stackoverflow.com/questions/40172281/unit-tests-for-functions-in-a-jupyter-notebook).

### Automate as much as you can

This one's pretty short, but: ever notice you're doing a manual task over and over, like smoke-testing a new data item or running the same analysis on a model over and over? Put it in a function! Automate it, so you can stop copy-pasting and waiting for cells to execute.

That's all for now. Hopefully at least a few of those were helpful, and happy data-sciencing.