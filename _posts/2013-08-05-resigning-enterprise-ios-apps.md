---
layout: post
title: "Re-signing Enterprise iOS apps"
date: 2013-08-05 20:02:59
---
If you have ever supported In-House Enterprise iOS apps, you'll know that every so often the certificate expires and you need to re-sign the app with a new provisioning profile.

This is something a lot of people who make iOS apps have to do, so of course when the need arose for me, I went looking for solutions that other people had already found.

But while the first script I tried looked like it worked, it failed to change the embedded provisioning profile. And then when I tried another set of manual steps, the package was missing the entitlements, meaning the app couldn't access the iOS keychain.

So, after a few hours of work, I've built my own [ipa resigning script](https://github.com/mbaltaks/vomitorium/blob/master/resign-ipa), which I've successfully used to re-sign an existing ipa, one with an expired profile.

With this script, all you need is your expired ipa and a new provisioning profile using all the same details, and it'll build you a new ipa that will be able to access the keychain data from the existing install.
