---
layout: post
title: "Defining the term Unit Test"
date: 2013-11-27 15:59:05
---
When you're writing software, how can you know if some test code is a "unit test"?

The "test" part of the term is obvious, so let's look at "unit". What is the smallest unit of software? Perhaps a single line of code? Well, if you do want to run a single line of code, you'll have to have some way of referring to it, like perhaps a name, and at that point what you have is a function or method.

So if a method is the smallest unit of software, then **I define a unit test as a test where only a single method of production code is run**.

Now it's easy, just look at your tests, and if there's only one production method being called, it's a unit test. If there is more production code, then it's some kind of integration test.

But why does this even matter? Well, I find it's hard to go wrong with unit tests, because they are so focussed, and they are not likely to make the codebase harder to change later, because you'll only have to change a few unit tests if you change a method, and it won't affect any other code. Integration tests, on the other hand, are more complex, and you have to be careful that you're creating worthwhile integration tests that add value rather than just make the codebase harder to change. It's easy to accidentally couple different parts of the code together via these tests, and make things worse rather than better.

This is what I've found with my work anyway, let me know if you disagree.
