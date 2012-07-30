---
layout: post
title: "Paying the ARC __bridge toll"
date: 2012-07-31 03:35:50
---
After years spent writing Objective-C code and getting completely comfortable with balancing every `alloc`, `retain` and `copy` with a `release` or `autorelease`, [ARC](http://developer.apple.com/documentation/Cocoa/Conceptual/MemoryMgmt/) messed with my brain a bit when I first encountered it. At first I ignored it, because it's optional, but when I discovered that in general it produces faster code, I started reading up on, and then using ARC.

After a while I've gotten comfortable with no longer thinking about object ownership in Objective-C when ARC is enabled. Except of course for occasions where I need to use `(weak)` in property declarations, mostly for delegates.

But one thing that hadn't crossed my path until recently was toll free bridging from Core Foundation to Objective-C, and at first it was also quite confusing. Especially since ARC means that you really don't think about this anymore for Objective-C, having to think again for CF is a bit of a jolt.

The [Transitioning to ARC Release Notes](http://developer.apple.com/library/mac/releasenotes/ObjectiveC/RN-TransitioningToARC/Introduction/Introduction.html) provide this example of equivalent code, first non ARC, then ARC:

	- (void)logFirstNameOfPerson:(ABRecordRef)person
	{
		NSString *name = (NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
		NSLog(@"Person's first name: %@", name);
		[name release];
	}

	- (void)logFirstNameOfPerson:(ABRecordRef)person
	{
		NSString *name = (NSString *)CFBridgingRelease(ABRecordCopyValue(person, kABPersonFirstNameProperty));
		NSLog(@"Person's first name: %@", name);
	}

This is helpful to see one example of how to start using ARC, but when migrating code the compiler actually prompts you to fill in with `__bridge` style cast specifiers, and that seems to be the style that's used a lot. So I had to understand how these differed, and I've come up with two more equivalent bits of ARC code that helped me understand:

	- (void)logFirstNameOfPerson:(ABRecordRef)person
	{
		NSString *name = (__bridge_transfer NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
		NSLog(@"Person's first name: %@", name);
	}

	- (void)logFirstNameOfPerson:(ABRecordRef)person
	{
		CFStringRef nameRef = ABRecordCopyValue(person, kABPersonFirstNameProperty);
		NSString *name = (__bridge NSString *)nameRef;
		NSLog(@"Person's first name: %@", name);
		CFRelease(nameRef); // balance the *Copy*()
	}

There are some things to consider:

- You can't use casts unless there is an Objective-C type to cast to, so sometimes you simple have to use `CFRelease()` anyway.
- You can't pass the Objective-C object out of the current scope unless you transfer ownership to ARC, using either `__bridge_transfer` or `CFBridgingRelease()`.

So, in cases like this one, you actually have to choose between explicitly balancing the `*Copy*()` call with a `*Release()`, or handing over to ARC, using one of two styles. Which of these is preferable? I have no idea. I guess some kind of community consensus will develop over time, if it hasn't already, and we'll all just do it that way.
