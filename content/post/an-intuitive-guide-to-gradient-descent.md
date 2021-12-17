+++
title = "Writing down what I know about gradient descent"
date = 2020-08-08T17:29:22-04:00
summary =  "CHANGEME"
draft = true
toc = false
categories = []
tags = []
images = []
+++

I've recently been doing a lot of machine learning studying! One of the very basic things that you learn is gradient descent and how to optimize the loss function. While learning, there were a few "aha" moments that I had, and I'm hoping that I can share some of those with you today.

[Prerequisites: Calculus I.]

## What is the goal of a model?

A machine learning model is a black box. You give it features (your input data, generally a vector), and it processes those features into an output.

To do this, a model typically has **weights and biases**, which are parameters you can tweak to improve accuracy. There's a lot more to understand about those (along with neurons, model architecture, etc.), but for the purposes of gradient descent alone, the details aren't too important.

You measure the accuracy of a model with a **loss function**, which basically tells you how bad your model is. Higher numbers are worse.

The real trick of _training a model_ (making it better) is to find the perfect combination of weights and biases that gets it to maximum accuracy on whatever data you give it. On a very basic level, you can imagine graphing the loss of a model with a single weight like so:

![A basic loss graph. Shows a typical x-y graph with a low point in the middle.](/images/an-intuitive-guide-to-gradient-descent/simple-loss.png)

Obviously, to minimize the loss, you should put the weight about in the middle. But how does a computer know that? More broadly, how does a computer know how to do that not just for one weight, but for 15,000? (It's pretty hard to make a 15,000-dimensional graph.)

## Gradients, explained

Thankfully, as always, Calculus provides the answer. If you start at a random point on this 2D loss graph, you can find the direction you should go in to reach the minimum by calculating the negative derivative with respect to our weight:

$$-\frac{d}{dw_1} Loss(w_1) = \text{(some number that tells you which way to adjust } w_1 \text{)}$$

(I'm going to skip over the learning rate here, but that's also important.)

If you have multiple weights, you can take a _partial derivative_ (just a derivative holding every other variable constant) of the loss function with respect to each weight:

$$-\frac{\delta}{\delta w_1} Loss(w_1, w_2) = \text{how to adjust w1}$$
$$-\frac{\delta}{\delta w_2} Loss(w_1, w_2) = \text{how to adjust w2}$$
$$...$$

In math, you can put all these partial derivatives into what's known as a **Jacobian vector**.
