---
layout: post
title: "Signing code"
date: 2012-07-15 12:34:31
---
Code signing is one of those things that is great for users but pretty annoying for developers. For users, it provides a mechanism for finding the originator of that bucket of bits you're about to entrust to run on your device, which means now you can begin to build trust in developers. For developers, especially in the early days of the iPhone App Store, it meant a fiddly and error prone process to add to your normal build process, with the added kick in the pants that the build you tested was not the one you shipped to your users.

But time moves on, and the Apple dev tools were improved, and that last problem is no more. But the tools are still sometimes buggy, and the process can still be fiddly and error prone, as [demonstrated recently by Jamie Zawinski](http://www.jwz.org/blog/2012/07/how-do-i-install-an-xcode-archive-build-on-my-device/). I don't know about code signing for desktop platforms, but for Android the process is a lot more simple than for iOS, which just adds to the frustration. So as part of my Big Upgrade To Mac OS X Lion And Xcode 4, I looked into whether this could be improved.

There is a lot of information out there, and so I gleaned what I could and came up with a [script](/files/make-packages) that I now use in iOS projects, which builds one package, and signs with both an AdHoc profile, and an App Store profile. Because this stuff is hard to test and verify, I set the project settings (the few that are in the Xcode project, most of my project settings go into xcconfig files to reduce duplication) to the App Store settings, that way if the build script failed somehow the resulting package would not install on a test device and I'd know straight away. I've also got a [second script](/files/tag-release) that tags a specific package as released when a build does get released to users. Both scripts rely on an [app specific config file](/files/app.config), containing the app name and profile IDs.

These scripts could really be improved, there is some dependance on having a packages folder sitting next to all the project repo folders. But it works fine, and fails safe.

Now when I create a new app, all I have to do is create an app ID, and both provisioning profiles, and put those details into the app.config file, all of which I've not yet automated. From that point I can get on with building a great app, rather than thinking about code signing.
