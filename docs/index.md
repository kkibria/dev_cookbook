---
title: Software Development Cookbook
---

# {{ page.title }}

> This site is retired and no longer maintained, I migrated my contenets to a `mdbook` based site, <https://kkibria.github.io/my_cookbook>.

This is mostly a collection of **gists** I noted from my own experience
and many others that I collected over the years and still collecting.
## Table of contents

{% for topic in site.topics %}
* [{{topic.title}}]({{topic.url|relative_url}}) 
{% endfor %}