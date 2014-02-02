---
layout: post
title: "Make One And Pass It On"
date: 2014-02-02 20:54:28
---
I used to have a bad habit, and I sometimes slip back into it without thinking. This bad habit makes my code really hard, maybe even impossible, to test, which is a bit of a problem when I want to know that it works correctly.

What is this habit? It's using an object right where I've made it. That might not sound too bad, in fact for some people that might sound completely normal, just like it always did to me. But in using the object in the same method where it's been created, you've coupled together the creation and use, and so now how can you possibly test just the use on it's own? Not very easily.

In Objective-C:

```objc
- (void)untestable
{
	SomeClass *obj = [[SomeClass alloc] init]; // make an object
	[obj doSomeWork]; // Oh no, we've used it here, making this hard to test
}
```

The simple solution to this problem is to decouple the creating from the using of objects, by having an object passed in to the method where it's used. That method can then very easily have a mock injected at test time, making testing very straightforward.

```objc
- (void)callMeInProduction
{
	SomeClass *obj = [[SomeClass alloc] init]; // make an object
	[self easyToTestWithSomeClass:obj]; // tell the doing code about it
}

- (void)easyToTestWithSomeClass:(SomeClass *)obj
{
	[obj doSomeWork]; // in a test this can be a mock
}
```

That's great, but I have to remember to do that, so I thought of a phrase to help me just at the point where I'm creating an object so I won't accidentally use it right there. "Make one and pass it on". Just a simple reminder to pass it on as soon as I've made it. It's not difficult, and it makes testing my code much easier when I can just pass in mock objects and isolate the code under test.

Sometimes it's simple things that are the most effective.
