---
layout: page
title: Pages
header: Pages
description: List of pages for the website of Michael Baltaks
---
{% include JB/setup %}

<h2>All Pages</h2>
<ul>
{% assign pages_list = site.pages %}
{% include JB/pages_list %}
</ul>
