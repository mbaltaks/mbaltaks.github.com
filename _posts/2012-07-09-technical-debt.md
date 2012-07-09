---
layout: post
title: "Technical Debt"
date: 2012-07-09 23:42:23
---
I've been reading and thinking a lot about the process of building software lately, and came across this nice article about [Tech Debt](http://markdrago.com/blog/2012/04/23/a-pragmatic-exploration-of-tech-debt/) by Mark Drago. He takes a good look at why and how the debt arises, and when it makes sense to allow some debt, and when it makes sense to start repaying. The one thing I'd add is to the definition of technical debt, I'd say "technical debt is when changing the source code is risky". All of the examples he gives are about this risk, if you think about it. This is why it often makes sense to accrue some debt in the early stage of a project, because the business risk of not shipping might well be the greater risk. Once the business risk is dealt with, then it might be time to pay back some technical debt. Of course, if you're never going to change the source code, you never need to pay back the debt. But rarely does the code sit still, it's far more likely that there will be changes needed.

How do you know when the debt is paid? Well, there are some good ideas about what well designed software looks like at the [software patterns wiki](http://c2.com/cgi/wiki?XpSimplicityRules).

There is also one specific case of technical debt that Mark doesn't directly address, but which Chris Wenham writes about, the [mixing of infrastructure code with business logic](http://www.yacoset.com/Home/every-line-of-code-is-a-user-interface):

> When you are writing your own code you must think about which lines are directly manifesting the program's purpose, and which lines are only there to provide what wasn't already in the framework, language or operating system. Some code must be written to be independent of the program's function and some code must be written to be independent of the program's form.

Mixing the important parts of your codebase with the infrastructure parts means you can't take advantage of platform improvements without major work, and at the same time ties you very firmly to that platform, doubly reducing your ability to move quickly, and this is why I think it is one type of technical debt that is almost always a mistake.
