---
layout: frontpage
title: Michael Baltaks
tagline: Matters of interest (to me)
description: The website of Michael Baltaks, matters of interest.
---
{% include JB/setup %}

{% for post in site.posts limit:10 %}

<div class="post-content">
	{% if post.link %}
	<h1><a href="{{ post.link | escape }}">{{ post.title }}</a>&nbsp;<a href="{{ post.url | remove :'.html' }}" title="Permanent link to ‘{{ post.title }}’" class="permalink infinitysymbol">∞</a></h1>
	{% else %}
	<h1><a href="{{ post.url | remove :'.html' }}">{{ post.title }}</a></h1>
	{% endif %}

	<div class="date"><span class="post-date">{{ post.date | date_to_long_string }}</span></div>

	<div class="description">
		{{ post.content }}
	</div>
</div>

{% endfor %}

<a href="/archive">More posts</a>
