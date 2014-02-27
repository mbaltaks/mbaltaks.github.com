---
layout: post
title: "A Whine About NSDate"
date: 2014-02-27 16:40:09
---
I really wish NSDate was not named NSDate.

NSTimestamp would be best, NSDateTime also fine; even NSMoment would work. But NSDate just causes confusion, because a lot of people think of a date as meaning something like "the first of November". That's a date in the calendar (some calendars), but the group of timestamps that make up that calendar date depends on what timezone you're talking about. So you can't even know what date an NSDate refers to without adding a timezone. If you think that sounds confusing, you're right.

So, if you have a product on sale for the month of November, when does that time begin? The first of November, right? But the first second of the first day of November is a different timestamp depending on your timezone, so does the price begin at the same time everywhere in the world all at once, or does it begin when November begins where you are at that moment? And if you've opted for the beginning of November where you are, how do you store that? You can't just use NSDate alone, because that is a specific moment which is only the beginning of November in one timezone.

To describe "the first day of November" you have to add to NSDate, perhaps by having a clear convention, like using midnight in UTC on that date. In this case a few category methods on NSDate can be a great help.

In any case, having a class named NSDate only adds to the confusion, where another name, in my opinion, might help make things clear.

And that's all I really wish for.
