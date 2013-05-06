---
layout: post
title: "Is TDD worth it?"
date: 2013-05-06 15:42:33
link: http://www.levelofindirection.com/journal/2012/12/26/tdd-is-it-worth-it.html
---
Phil Nash, commenting on Marco Arment about TDD:

> It's a shame that he appears to have just dismissed what is probably the best tool we have come up with to date for avoiding this ever happening in the first place.

I think that those of us who've written a lot of software before practices like TDD/BDD became well known have trouble changing mindset to work this way. I personally had developed something like CDD, "commit driven development", over the years, where I carefully check each commit as I go, ensuring each change is heading in the right direction. Perhaps this came about from so often working on large pre-existing codebases without any tests.

The basic principle of my home grown approach is similar, in that the focus is on small incremental steps of good quality. But having an automated test suite is crucial, because the test code pushes against the production code, and that tension provides much greater confidence that you actually know what the production code is doing. And this is where writing tests first comes in, because to have confidence in your test code, it has to first fail, so that you can see it change from failing to passing when the production code is in place. But it can be hard to have to keep stopping and working out not only how best to test a particular bit of code, but then also how best to structure and manage tests overall, especially when the code starts appearing in your head and you want to get it down while it's there.

I'm completely sold on the benefits both of having a test suite, and of writing the tests (or specs) first, and I'm now in the stage where I sometimes fall back under pressure to just writing some code on the fly, and then perhaps adding tests afterwards, and sometimes not. It took effort to start making the change, and now that I've started I know I'll slowly tip the balance to having most code written test first.

Because it really is so much nicer to have clear specs that actually demonstrate how the production code behaves, than to not.
