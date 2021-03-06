---
layout: post
title: Lessons learned in error handling
date: 2005-12-15
comments: false
---

Error messages, user feedback, status reporting, etc.

Can the operator understand this message?
Can they do anything about it?

First, it needs to be determined what the operator must do in this event. Then that instruction needs to be clearly relayed to them, and potentially logged as well, perhaps via email. The message to the operator needs to be unmissable - for the desktop apps we're using in our system the message appears in big red letters in a separate modal box with a warning sound, nothing but deliberately using the mouse to hit the close button will allow things to proceed. The message is worded in clear language and contains no unnecessary software/database/network jargon or error codes.

If there is nothing for the operator to do, the message is logged and send to the engineers, without even notifying (read disrupting) the operator.

This follows on to the next principle: if the software can make an effort at recovery from any given issue, then it should do so.

The desktop apps in our system call COM+ components to do work, and those components call stored procedures in the database that is the heart of the system. Originally the apps just tried to call the component method, and put up a tiny message box if there was an error. The error code and the standard error messages were put first, then maybe some kind of explanation was included, perhaps a general one or an easy explanation.

Thus, quite often the operators would suddenly discover a little box they could not understand and had no idea of what to do with, and would call the engineers. For all kinds of reasons.

I implemented a simple idea - if the call to the COM+ application server failed, try again before bailing. This means that temporary network outages, or application server restarts, etc, have little to no impact on the operators, where once they would bring the factory to a halt.

The system was originally designed in the Microsoft culture of software design - users are stupid, and they should learn how to use this system better. This involves just putting up little boxes with confusing messages whenever something goes wrong.

I've tried to use the Apple culture of software design - users are experts in their field, but not in this software system. This means it is up to the software team to make it easy for the experts to do what they do, and my job to keep the software out of their way.

For comparison, the Unix culture of software development simply does not have users - Unix is designed for programmers, which is why we love it.
