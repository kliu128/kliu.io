+++
title = "Unintuitive conclusions from urban planning"
date = 2021-12-19T22:32:44-05:00
summary =  "Urban planning is weird. Also, cars are bad. Here's why."
draft = false
toc = false
categories = []
tags = ["transit"]
images = []
+++

Cars are weird. Living in a Massachusetts suburb, I didn't realize just how car-dependent my area was[^1] until spending time in the SF Bay Area, which (while certainly not the pinnacle of transit) offers far more accessible bike and transit options.

This realization has made me quite sad about the current state of affairs, and because of this, I've recently fallen into a rabbithole of reading about transit. Here are some rather unintuitive facts about traffic, transit, and urban planning:

## Highways exhibit highly nonlinear congestion

{{< figure
    src="images/Speed_Volume_WSDOT_2018.png"
    alt="Maximum throughput: adapted speed volume curve. Shows a D-curve where highways have a 'sweet spot' that provides maximum throughput, after which speeds and capacity decline greatly."
    caption="Figure provided by WSDOT 2018, from [Strong Towns](https://www.strongtowns.org/journal/2020/4/29/what-covid-19-teaches-us-about-how-to-fix-freeways)" >}}

Let's suppose you're trying to maximize the vehicles-per-hour on a highway. As it turns out, adding more cars only improves this until a threshold, at which point it causes capacity to _plummet_. This phenomenon is shown in the graph above: as you add more cars, you descend the curve. At the middle, you have the maximum vehicles-per-hour. But as you keep going, the average speed of each car drops due to congestion, so even though _more cars are on the highway_ at any one time, the total number of cars passing through declines precipitously.

This effect is so large that in Portland's I-5, the decline in driving from covid slightly reduced the entering traffic volume, which [actually allowed _more cars overall_ to use the highway](https://www.strongtowns.org/journal/2020/4/29/what-covid-19-teaches-us-about-how-to-fix-freeways).

This is part of why some states/countries have [ramp metering](https://mtc.ca.gov/operations/programs-projects/freeways/adaptive-ramp-metering) and why congestion pricing for roads is a really good idea.

## Expanding roads doesn't improve traffic

This one is pretty well-known but bears repeating. Thanks to [induced demand](https://en.wikipedia.org/wiki/Induced_demand), adding more highway capacity causes more people to use the highway, because it's now the most convenient option. Hence, the highway becomes more congested until it returns to the steady-state equilibrium of the maximum sadness people are okay with. This is usually when people start getting annoyed at congestion and push for the highway to be expanded.

There is one counterargument to this: even if congestion didn't get any better, surely we at least were able to transport more people to places they wanted to go? I think the response to this is that while this is true, expanding roads also strengthens the norm that it's ok to travel 10, or 20, or 30 miles for a brief errand. This [alters the pattern of development](https://www.strongtowns.org/journal/2021/8/24/does-induced-demand-apply-to-bike-lanes-and-other-questions) such that people start building destinations further away. If we assume the quality of each destination is the same regardless of theoretical distance, this means we're having people drive further, and experience equivalent levels of traffic, for the same quality of destination.

That seems bad.

## The speed of public transit (may\*) determine the speed of car transportation

This is the [Downs-Thomson Paradox](https://en.wikipedia.org/wiki/Downs%E2%80%93Thomson_paradox). Essentially, if cars were faster than public transit, then people would shift to using cars. Thus (assuming perfect substitutability), people would flock to cars until it becomes slower than transit. Public transit hence acts as a ceiling on car travel times.

This implies, similarly to induced demand, that expanding _car_ infrastructure won't improve car travel times. In fact, you might want to instead expand _transit_ infrastructure -- [if you improve non-car transportation options, people will switch from cars to transit, making cars _and_ transit faster](https://theweek.com/articles/981979/car-supremacy-americas-traffic-paradox).

However, is this paradox actually true in practice? It seems somewhat limited. Empirically, I can observe that it takes 22 minutes to drive from Acton to Lowell in Massachusetts, while transit takes **1 hour, 49 min**. Granted, this is because of design issues on the commuter rail (routes only go into Boston, not radially to other towns), but take another example: Berkeley to Palo Alto. This takes 52 minutes by car and 1 hour, 34 min by train. (Ok, with congestion it takes 1-2 hours by car, which is maybe where the paradox comes in.)

It does seem to be a general trend, though, that [cars are usually faster than transit in America](https://www.visualcapitalist.com/average-commute-u-s-states-cities/). Probably, this is because our transit is so horrendous that the paradox doesn't even apply because nobody uses transit anyway.

## The upshot?

I don't have any particularly strong conclusions for you, beyond that urban planning is _complicated_ and very nonintuitive. However, it does seem like car-centric planning is usually bad, for transit _and_ cars.

Also, I'm not an expert, so if you see anything horrendously wrong please do call it out. Good places to learn more are [Strong Towns](https://strongtowns.org) and the YouTube channel [Not Just Bikes](https://www.youtube.com/c/NotJustBikes/videos).

[^1]: As in, the only road in and out from my house is a single-lane, 40 mph road with no bike route and no sidewalk. The train station (which only has trains every hour) is 5 miles away. Good luck not owning a car here.
