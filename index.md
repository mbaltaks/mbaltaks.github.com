---
layout: frontpage
title: Michael Baltaks
tagline: Matters of interest (to me)
---
{% include JB/setup %}

<div class="content">
{% for post in site.posts limit:10 %}



<div class="post">

    <div class="post_header">
        {% if post.link %}
        <h2><a href="{{ post.link }}">{{ post.title }}</a></h2> <a href="{{ post.url | remove :'.html' }}">∞</a>
        {% else %}
        <h2><a href="{{ post.url | remove :'.html' }}">{{ post.title }}</a></h2>
        {% endif %}
        <p>{{ post.date | date_to_string }}</p>
    </div>

    <div class="post_body">
        {{ post.content }}
    </div>
  </div>



{% endfor %}

</div>
