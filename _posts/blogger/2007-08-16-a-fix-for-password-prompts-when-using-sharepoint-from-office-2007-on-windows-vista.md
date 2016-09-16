---
layout: post
title: A fix for password prompts when using SharePoint from Office 2007 on Windows Vista
date: 2007-08-16
comments: false
---

If you're using Windows Vista with Office 2007, when you open an Office file from SharePoint you'll see lots of dialog boxes asking for your password. You might notice that you can click cancel (possibly many times) and you'll still get access to the file. You might also notice it's very slow.

The solution is simple, just stop and disable the WebClient service.
