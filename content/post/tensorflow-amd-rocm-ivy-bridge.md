+++
title = "Building Tensorflow + AMD Radeon Open Compute for Ivy Bridge: The Rabbit Hole of CPU Flags and PCIe Features"
date = 2019-04-21T10:31:43-04:00
summary =  "The story of [issue 217](https://github.com/ROCmSoftwarePlatform/tensorflow-upstream/issues/217) – getting Tensorflow for AMD GPUs to work on an aging Ivy Bridge processor."
draft = false
toc = false
categories = []
tags = ["tech"]
images = []
+++

I tried to install Tensorflow to learn machine learning, but ended up learning a lot more about hardware and the inner workings of AMD's ROCm stack.

So, Tensorflow: it's the premiere machine learning library, but unfortunately it only supports NVIDIA GPUs natively. This was problematic for me, as I own an RX 580. Thankfully, AMD has developed [a port](https://github.com/ROCmSoftwarePlatform/tensorflow-upstream) running on their own Radeon Open Compute (ROCm) architecture. They even have a docker image!

So I `docker run`'d it, passing through the GPU as directed[^1], and:

```sh
root@2a2a4a430b33:/root# python3
Python 3.5.2 (default, Nov 23 2017, 16:37:01)
[GCC 5.4.0 20160609] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import tensorflow
2018-10-21 14:20:43.079860: F tensorflow/core/platform/cpu_feature_guard.cc:37] The TensorFlow library was compiled to use AVX2 instructions, but these aren't available on your machine.
Aborted (core dumped)
root@2a2a4a430b33:/root#
```

Hm.

Initially, this error seemed inscrutable to me. I actually spent a long time looking through the `cpu_feature_guard.cc` file for where the error was located to see if it was a bug, but then I _actually read the error_. To reiterate:

> The TensorFlow library was compiled to use AVX2 instructions, but these aren't available on your machine.

[Thanks to the power of Wikipedia](https://en.wikipedia.org/wiki/Advanced_Vector_Extensions#Advanced_Vector_Extensions_2), I realized that AVX2 is a CPU extension only introduced in Intel's Haswell processors in 2013. And my computer has an i7-4820k, an Ivy Bridge processor. The question then became: Why would AMD compile a generic Docker image only for newer Intel CPUs?

However, looking closer on ROCm's [Getting Started page](https://rocm.github.io/ROCmInstall.html#supported-cpus) reveals that it requires not just a supported GPU, but a supported _CPU_:

> GFX8 GPUs require PCIe 3.0 with PCIe atomics in order to run ROCm. In particular, the CPU and every active PCIe point between the CPU and GPU require support for PCIe 3.0 and PCIe atomics.
>
> If you attempt to run ROCm on a system without proper PCIe atomic support, you may see an error in the kernel log (dmesg):
>
> `kfd: skipped device 1002:7300, PCI rejects atomics`

(PCIe atomics, by the way, are used by ROCm as a way of ordering/synchronizing memory operations. You really [can't run ROCm without them](https://github.com/RadeonOpenCompute/ROCm/issues/157).)

My heart sunk. The getting started page, at the time, only listed Intel Haswells and above as supporting PCIe atomics. That's probably why the Tensorflow image was only compiled for Haswell and up. I checked `dmesg | grep kfd` to see the bad news and

```
kfd kfd: Initialized module
kfd kfd: Allocated 3969056 bytes on gart
kfd kfd: added device 1002:67df
```

_Oh_. That did not seem like an error due to a lack of PCIe atomics. I went to Intel's [datasheet](https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/4th-gen-core-i7-lga2011-datasheet-vol-1.pdf) for the 4820k, where I saw (p. 11):

![Intel datasheet showing PCIe atomic support on Ivy Bridge](/images/2019-04-21-pcie-atomics.png)

🤔 So clearly my CPU _did_ support atomics. Time for a [bug report](https://github.com/ROCmSoftwarePlatform/tensorflow-upstream/issues/217) (which ultimately resulted in [AMD updating its documentation](https://github.com/RadeonOpenCompute/ROCm/commit/23beff10b8916c5302ff0df6750c3585e01ea517) about supported CPUs).

A few months passed, and `sunway513` (an AMD employee? probably?) suggested I try to build Tensorflow, from source, using the dev Docker image. So I tried that, but then I saw that the build tools were _also_ compiled using invalid (Haswell) instructions. Eventually, I managed to build Tensorflow starting from a clean `ubuntu:16.04` image, installing ROCm manually, and then building Tensorflow as usual (with `-march=native`).

```
Python 3.5.2 (default, Nov 12 2018, 13:43:14)
[GCC 5.4.0 20160609] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import tensorflow as tf
>>>
```

Victory!

(PS: After this whole ordeal, I tried AMD's Docker image again. And, surprise, it Just Works now. So maybe they changed their build system in some way to stop compiling for Haswell. And yes, this makes this whole expedition pointless, but at least it was a learning experience!)

[^1]: `--device=/dev/kfd --device=/dev/dri --group-add video --cap-add=SYS_PTRACE --security-opt seccomp=unconfined`
