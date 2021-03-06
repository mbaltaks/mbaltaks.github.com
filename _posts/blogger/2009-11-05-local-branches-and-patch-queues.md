---
layout: post
title: Local branches and patch queues
date: 2009-11-05
comments: false
---
A colleague just showed me stacked git, which I understand is similar to patch queues in mercurial. At first I was struggling to understand why this was even created, but then I think the answer became clear.

It seems to me that patch queues are like having just one local git branch, that always rebases against the original branch. Or coming from the other way, if you've only used patch queues, git provides an arbitrary number of named "patch queues" that you can merge between, which naturally provides more flexibility and power.

Update: we've now had a look at <a href="http://repo.or.cz/w/topgit.git">topgit</a>, which seems to be a small set of metadata on top of git, managed by a simple tool, that manages dependancies of branches. This means you have a normal git branch for each patch, and you work with git in the usual way and keep full history for each patch, but topgit makes it very easy to apply the final result of each of those branches, in the correct order, as a single commit per branch on top of the base branch. So it's like a very well managed patch queue that retains full history for each patch. Very nice.
