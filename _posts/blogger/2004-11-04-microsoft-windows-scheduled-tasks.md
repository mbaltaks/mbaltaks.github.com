---
layout: post
title: Microsoft Windows Scheduled Tasks
date: 2004-11-04
comments: false
---

Give me cron!

Windows Scheduled Tasks are a pain, and I think the worst part is trying to get useful error messages out when things go wrong. Windows scheduler calls the return codes "Last Result" and displays in hexadecimal form, like `0x3`. I found that you can try `C:\net helpmsg 3` at the command prompt to get some idea of the error codes, but this won't work for all codes.
