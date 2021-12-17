+++
title = "How does \"Send all to voicemail\" actually work, anyway?"
date = 2020-08-10T19:56:54-04:00
summary =  "A look into call forwarding and MMI codes. On my cell provider, you can make calls automatically go to voicemail by dialing a single phone number. But how does this all work, anyway?"
draft = false
toc = false
categories = []
tags = ["tech", "retro"]
images = []
+++

_(Disclaimer: I'm not a mobile network engineer. I made this post after some Googling, because it feels like there's a lot of complexity in mobile networks that even most computer people don't talk about!)_

Recently, due to increased robocalls and other spam, I've decided to switch all of my calling to a Google Voice account I own, whose number appears to be on far fewer contact lists than the number given to me by Mint Mobile, my SIM provider. To do this, I wanted to send all calls on my old number to a voicemail box explaining to call me at the other number. At first, I tried to see if my phone could block calls itself, but failing to find anything, I looked for something on the carrier level.

[Google reveals](https://www.reddit.com/r/mintmobile/comments/behwyb/unconditional_call_forwarding/) that two magic phone numbers will accomplish this for me:

> - Send All To Voicemail - `**21*18056377456#`
> - Allow Calls - `##21#`

I dialed the first number, and lo and behold, all my calls go to voicemail. But how does this work, anyway?

## Man-Machine Interface codess

The first thing I noticed is that when I called either of the two numbers above, Android gave me a toast saying "Running MMI code." Eventually, a popup window would show up saying: "Call forwarding [enabled/disabled]."

Further research reveals that MMI codes, or Man-Machine Codes, have actually been established since the 2G mobile specification was created. Here's a list from a [delightfully-old scan by Google Books](https://books.google.com/books?id=uR03kPNyx5UC&pg=PA263&lpg=PA263&dq=mmi+codes&source=bl&ots=5_Xq1--1ii&sig=ACfU3U3fSwls7kaxx5sDWZ3qFaGKNgqBow&hl=en&sa=X&ved=2ahUKEwi17K3n7JHrAhVJmnIEHQciBkEQ6AEwFnoECBIQAQ#v=onepage&q=mmi%20codes&f=false):

![](/images/call-forwarding-and-mmi/table.png)

Essentially, your phone will forward any code it doesn't know about to your mobile provider, who has servers to handle specific numbered functions. It doesn't send the actual number to the network though; instead, it [gets parsed by the phone and sent out as ASN.1](https://berlin.ccc.de/~tobias/mmi-ussd-ss-codes-explained.html). (That link also explains the difference between USSD and MMI codes, which is a big rabbit hole that I don't want to get into.)

"Unconditional call forwarding" is Service Code 21, as visible in the Send All to Voicemail number: `**21*18056377456#`. It looks like the second parameter after the asterisks is the number to forward to, and [1-805-637-7456](https://800notes.com/Phone.aspx/1-805-637-7456?) is T-Mobile's voicemail box.

Mystery solved! "Send to voicemail" just instructs the network to forward all calls to a voicemail box's number. It looks like the Allow Calls one just deletes the call forwarding rule.
