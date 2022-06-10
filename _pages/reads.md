---
layout: page
title: reads
nav_order: 1
permalink: "/reads"
redirect:
nav: true
---

I read things! Somewhat more frequently than I write.

## reviews

<ul>
{% for item in site.categories.book %}

<li>
  <strong>
    {{ item.date | date: "%b %-d, %Y" }}
  </strong> &mdash;
  <span>
    {% if item.inline -%} {{ item.content | remove: '
    <p>' | remove: '</p>
    ' | emojify }} {%- else -%}
    <a class="news-title" href="{{ item.url | relative_url }}"
      >{{ item.title }}</a
    >
    {%- endif %}
  </span>
</li>
{%- endfor %}

</ul>

## live feed

[Follow me on GoodReads](https://www.goodreads.com/user/show/145367305-kevin-liu).

<iframe sandbox id="the_iframe" src="" width="100%" height="330" frameborder="0"></iframe>

<script module>
  const el = document.getElementById('the_iframe');
  const src = "https://goodreads.com/widgets/user_update_widget?height=400&num_updates=7&user=145367305&width=";

  // Returns a function, that, when invoked, will only be triggered at most once
  // during a given window of time. Normally, the throttled function will run
  // as much as it can, without ever going more than once per `wait` duration;
  // but if you'd like to disable the execution on the leading edge, pass
  // `{leading: false}`. To disable execution on the trailing edge, ditto.
  function throttle(func, wait, options) {
    var context, args, result;
    var timeout = null;
    var previous = 0;
    if (!options) options = {};
    var later = function() {
      previous = options.leading === false ? 0 : Date.now();
      timeout = null;
      result = func.apply(context, args);
      if (!timeout) context = args = null;
    };
    return function() {
      var now = Date.now();
      if (!previous && options.leading === false) previous = now;
      var remaining = wait - (now - previous);
      context = this;
      args = arguments;
      if (remaining <= 0 || remaining > wait) {
        if (timeout) {
          clearTimeout(timeout);
          timeout = null;
        }
        previous = now;
        result = func.apply(context, args);
        if (!timeout) context = args = null;
      } else if (!timeout && options.trailing !== false) {
        timeout = setTimeout(later, remaining);
      }
      return result;
    };
  };

  new ResizeObserver(throttle(([obs]) => {
    console.log(obs.contentRect.width);
    el.src = src + obs.contentRect.width; 
  }, 200)).observe(el);
</script>
