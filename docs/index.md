---
title: Table of contents
---

# {{ page.title }}

This is mostly a collection of `gists` I noted from my own experience
and many others that I collected over the years and still collecting.

{% for topic in site.topics %}
* [{{topic.title}}]({{topic.url|relative_url}}) 
{% endfor %}