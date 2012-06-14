---
layout: page
title: ftw for Mac OS X (Darwin) and *BSD
header: ftw implementation for Mac OS X (Darwin)
description: Implementation of ftw for Mac OS X (Darwin)
---
{% include JB/setup %}

This is a port of the OpenBSD code for ftw() and nftw() to Mac OS X (Darwin). It should compile on any Unix like system supporting the fts api. It was developed for inclusion in [fink](http://www.finkproject.org/), to aid in the porting of [uade](http://zakalwe.fi/uade/) to Mac OS X.

Download the source code for [ftw-1.1.tar.gz](ftw-1.1.tar.gz). Install by typing `make; sudo make install`. Alternately, on Mac OS X use fink `fink install libftw`. The fink package info file is [libftw-1.1.info](libftw-1.1.info).

Because this is from OpenBSD, it is available under the following license:

Copyright &copy; 2003 Todd C. Miller &lt;Todd.Miller&#64;courtesan.com&gt;

Permission to use, copy, modify, and distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

Sponsored in part by the Defense Advanced Research Projects
Agency (DARPA) and Air Force Research Laboratory, Air Force
Materiel Command, USAF, under agreement number F39502-99-1-0512.
