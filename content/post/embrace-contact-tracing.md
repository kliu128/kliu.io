+++
title = "We Need to Embrace Exposure Notifications"
date = 2020-05-16T11:54:14-04:00
description = "Google and Apple's exposure notification technology privacy-preserving, safe, and necessary. We need to embrace it."
draft = false
toc = false
categories = []
tags = []
images = []
+++

To reopen the world, we need effective contact tracing. [According to the CDC](https://www.cdc.gov/coronavirus/2019-ncov/php/principles-contact-tracing.html):

> Contact tracing, a core disease control measure employed by local and state health department personnel for decades, is a key strategy for preventing further spread of COVID-19.

And our smartphones will be the key. With [Apple and Google's Exposure Notifications protocol](https://www.google.com/covid19/exposurenotifications/), we can get automated and effective contact tracing. And we don't have to lose our privacy while we're at it.

## Clearing Up Some Misconceptions

### Myth: Exposure Notifications Send Your Data to Google/Apple/the Government.

It doesn't. [Google and Apple won't receive any user identifiers or location data](https://covid19-static.cdn-apple.com/applications/covid19/current/static/contact-tracing/pdf/ExposureNotification-FAQv1.1.pdf). In fact, location data is expressly prohibited. Instead, your phone emits a Bluetooth ping to other phones with a random and variable identifier, and if you test positive with COVID-19, your identifiers get added to a list of Known Infected Identifiers provided by a public health authority. **Your name and other information aren't included**, so you can't be identified.

### Myth: It Will Let the Government Surveil Us All

Not really. As seen above, Google/Apple's system doesn't send any information to a central authority unless you've been infected, and even if you are, the central authority doesn't know anything about you (your name, etc.).

It's also opt-in: users have to **explicitly turn it on** in order for this whole system to activate.

### Myth: It Won't Help Fight the Spread of the Coronavirus

Hopefully false, if we can get the technology in the hands of enough people.

In order to be effective, you don't need 100% uptake. ["Just" 60% of people need to opt in](https://www.wsj.com/articles/apps-to-track-the-new-coronavirus-have-an-old-problem-getting-the-downloads-11588115728) for the system to work well. I say "just" because, considering that (1) you'll need to download a public health authority app; (2) [half of Americans don't trust contact tracing](https://arstechnica.com/tech-policy/2020/04/half-of-americans-wont-trust-contact-tracing-apps-new-poll-finds/); and (3) [2 billion phones are too old to use it](https://arstechnica.com/tech-policy/2020/04/2-billion-phones-cannot-use-google-and-apple-contract-tracing-tech/), 60% uptake is going to be a nightmare. That's why, if you're technically-minded, you need to **tell your friends and family to enable Exposure Notifications and download your local app** when it comes out.

Even if we don't get to 60%, an [Oxford study still found that lower levels of use can make a difference](https://www.fastcompany.com/90497860/contact-tracing-apps-are-on-the-way-will-they-help-us-get-back-to-normal). In the context of minimizing cases and flattening the curve, it can still be helpful.

### The Reality

There are some legitimate problems with Apple and Google's technology.

Although Google's final plan is to introduce Exposure Notifications as an OS update, it is initially [being bundled into Google Play services](https://www.forbes.com/sites/davidphelan/2020/05/07/apple-google-exposure-notification-latest-news--will-britains-nhs-u-turn/#37293f17849a), closed-source and proprietary software running on most (but not all) Android phones. This is because [Android updates are notoriously slow to reach end-user devices](https://www.theverge.com/2019/9/4/20847758/google-android-update-problem-pie-q-treble-mainline) (only 8.2% of phones have Google's latest update, Android 10).

However, starting in Google Play services means the initial code won't be open source, preventing external audits for vulnerabilities or privacy concerns. ([Hardcore open-source purists also won't get the technology.](https://github.com/microg/android_packages_apps_GmsCore/issues/1057)) Apple's implementation will similarly be closed-source, although that's less surprising given that much of iOS is entirely closed source.

There's also the issue of reliability: after all, just because two phones can talk to each other doesn't mean their owners really are in close physical contact.

Still, given the potential, I think it's going to be at least somewhat helpful. We should embrace it and push for greater transparency as we go.

## What About Alternative Frameworks? (NHS, etc.)

The [UK's National Health Service](https://www.theguardian.com/technology/2020/apr/16/nhs-in-standoff-with-apple-and-google-over-coronavirus-tracing) has publicly rejected Google and Apple's protocol because it _doesn't_ create a centralized list of contacts. Although a centralized approach also has benefits, if you're looking for privacy, Google & Apple's protocol is the way to go.

## What We Need to Do

1. Follow the news on contact tracing and make sure your phone is up to date with the latest software.
2. When Exposure Notifications is out, **turn it on** and tell your friends to do the same. Download your local public health authority's app and help get to that magical 60% number.
3. Be mindful of the privacy and surveillance concerns around Exposure Notifications, but push back on them when they are simply untrue.

## See Also

- 3Blue1Brown's [video on Contact Tracing](https://www.youtube.com/watch?v=D__UaR5MQao), via Nicky Case.
- [The EFF's Questions & Answers](https://www.eff.org/deeplinks/2020/04/apple-and-googles-covid-19-exposure-notification-api-questions-and-answers) on the Exposure Notification API.
- NPR: [Apple, Google In Conflict With States Over Contact-Tracing Tech](https://www.npr.org/2020/05/13/855096163/apple-and-googles-contact-tracing-technology-raises-privacy-concerns)