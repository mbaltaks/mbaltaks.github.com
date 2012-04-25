--- 
layout: post
title: DVCS for Enterprise use
link: ""
---
<p>Eric Sink has an article about <a href=
"http://www.ericsink.com/articles/vcs_trends.html">obstacles to an
enterprise DVCS</a> in which he writes:</p>

<blockquote>
  <i>“Enterprises need a least a little centralization for things
  like user administration. In their eyes, complete
  decentralization without accountability and auditing features is
  a bug.”</i>
</blockquote>

<p>While I think that this is indeed how large companies perceive
the issue, I’m not so sure that this is really true.</p>

<p>The way I see it, there are two main things you want to control
with user access, who can see it, and who can change it.</p>

<p>Open source projects don’t have the issue of controlling who can
see the code, because the code is for everyone to see. But an
Enterprise already has this problem, and since the people who work
with the code must already have access to the code, the same
processes that keep the code safe now would most likely work just
as well with a DVCS. Something like keeping the code on an
encrypted disk image for example.</p>

<p>For the issue of who can change code, it comes down to
understanding that because each repo stands alone, only the owner
can change it. So if the release team keeps a repo that only they
can change, they still get to approve only the changes that they
want in a release, by only pulling those changes in. This work
would already be happening with a centralised system, probably by
having a branch for the release that is locked to allow only
release team members change access.</p>

<p>A DVCS conceptually recognises that code is written by
individual people, and it works in the same way that people work,
with individual changes being moved about between people as they
are needed. If you take another look at your workflow, and think in
terms of the people performing the functions and what actually
needs to take place, I think a DVCS can fit even more naturally
into the workflow you really want.</p>
