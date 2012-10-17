---
layout: post
title: "Air Play is not Air Work"
date: 2012-10-18 10:05:49
---
I just spent about twenty minutes puzzling over and reducing a crash in some iOS code running in the simulator until I got back to completely unmodified older code that I knew worked fine. The code was crashing on trying to play an audio file, a file that existed and loaded just fine, but caused EXC_BAD_ACCESS when attempting to play. Something about trying code that I **knew** worked fine triggered me to think a bit differently, and realise that the thing I'm doing different today is playing music from my computer over AirPlay to a new sound system.

It seems the iOS Simulator crashes when it hits audio code if your system audio is pointed at an AirPlay output. Just making a note of this in case it's useful for anyone else (or me later!).
