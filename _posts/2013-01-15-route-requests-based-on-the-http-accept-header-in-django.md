---
layout: post
title: "Route requests based on the HTTP Accept header in Django"
date: 2013-01-15 15:01:33
---
I recently had need to route HTTP requests by the Accept header, in order to have versioned calls for an API. I found a [piece of Django middleware](http://effbot.org/zone/django-multihost.htm) that was similar to what I thought I'd need, and I modified it to support Accept header routing. Grab the full [http header routing Django middleware](/files/http_header_routing.py) and use it to your advantage.
