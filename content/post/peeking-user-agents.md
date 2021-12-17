+++
title = "Peeking at user agents for fun and profit"
date = 2020-08-01T11:52:23-04:00
summary =  "Don't ignore webserver logs! Even a cursory glance can reveal some really interesting things about the internet."
draft = false
toc = false
categories = []
tags = ["tech", "blog"]
images = []
+++

HTTP [user agents](https://en.wikipedia.org/wiki/User_agent) provide a glimpse into the great variety of the internet. I have a slightly embarrassing habit of staring at my webserver access logs in the minutes (or hours) after I publish a post, just to see how much traffic it gets, but in the process I've noticed a few interesting things.

## Exploring Hacker News reposters

As it turns out, posting on [Hacker News](https://news.ycombinator.com) nets your website a lot of hits just from bots reposting new Hacker News content around the internet, even if nobody actually reads your post.

Here's a sample from yesterday's [Tailscale post](/post/tailscale-pretty-cool/):

```
[01/Aug/2020:15:51:49 +0000] "Mozilla/5.0 (linux) AppleWebKit/537.36 (KHTML, like Gecko) jsdom/16.2.2"
[01/Aug/2020:15:51:50 +0000] "Go-http-client/2.0"
[01/Aug/2020:15:51:52 +0000] "Mozilla/5.0 (compatible; Discordbot/2.0; +https://discordapp.com)"
[01/Aug/2020:15:51:54 +0000] "TelegramBot (like TwitterBot)"
[01/Aug/2020:15:52:01 +0000] "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/538.1 (KHTML, like Gecko) wkhtmltoimage Safari/538.1"
```

Just from these few lines, we can infer that:

- Someone has built a Node.js daemon to scrape new HN posts using [jsdom](https://github.com/jsdom/jsdom);
- There's a go bot crawling every post;
- Somewhere out there, there's a Discord server with a bot posting HN (thus triggering Discord's preview bot);
- There's a Telegram group crawling HN as well.

This isn't terribly practical, but I find it fascinating to see just how interconnected the Internet is, and how one action (my post on Hacker News) immediately spurs a flurry of bot activity from people all over the world.

## Finding out how many people are reading

RSS readers also make requests, of course, to check for new posts. (Self-plug: if you're interested, please subscribe via RSS.) It turns out, though, that many readers also report the _number of subscribers_ in their user agent, as remarked upon by [Julia Evans](https://jvns.ca/blog/2018/02/20/measuring-blog-success/).

A snippet of my logs:

```
[03/Aug/2020:18:47:00 +0000] "GET /index.xml HTTP/1.1" 304 0 "-" "Liferea/1.12.6 (Linux; https://lzone.de/liferea/) AppleWebKit (KHTML, like Gecko)"
[03/Aug/2020:18:58:31 +0000] "HEAD /index.xml HTTP/1.1" 200 0 "-" "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36"
[03/Aug/2020:19:54:24 +0000] "GET /index.xml HTTP/1.1" 304 0 "-" "Feedly/1.0 (+http://www.feedly.com/fetcher.html; 5 subscribers; like FeedFetcher-Google)"
[03/Aug/2020:20:01:51 +0000] "GET /index.xml HTTP/1.1" 304 0 "-" "Tiny Tiny RSS/20.08-2b50aaed6 (http://tt-rss.org/)"
[03/Aug/2020:20:06:03 +0000] "GET /index.xml HTTP/1.1" 200 15148 "-" "Krzana bot"
[03/Aug/2020:20:19:03 +0000] "GET /index.xml HTTP/1.1" 304 0 "-" "Feedbin feed-id:1637164 - 1 subscribers"
```

From this, we can tell:

- Someone's using Liferea as an RSS reader! Pretty cool.
- 5 people are subscribed on Feedly! Hi! And 1 subscriber on Feedbin.
- There are also some other readers, like TinyTinyRSS (which I only recognize because of [Chris Siebenmann's post about it](https://utcc.utoronto.ca/~cks/space/blog/web/MyIfModifiedSinceHack)).

This seems like a good way to monitor how the blog is doing over time! I'm honestly surprised that anyone at all is interested enough in this site to subscribe, so I'm happy.

Now, if you'll excuse me, I'm going to go stare at some more user agents.

_This post is 3/100 in my goal to write 100 blog posts in a year._
