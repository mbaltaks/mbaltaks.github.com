---
layout: post
title: "Balance Your NSNotification Observers"
date: 2014-05-02 13:54:52
link: http://www.cocoabuilder.com/archive/cocoa/230712-nsnotificationcenter-multiple-messages-sent-to-the-same-observer.html#230756
---
One aspect of using NSNotifications I hadn't encountered before, is that you can add the same observer for a particular notification multiple times, which will result in that observer having it's method called multiple times.

I tend to balance out my own calls, which might explain why I've not seen it before, but in examining other code I came across this and I didn't actually know about this behaviour.
