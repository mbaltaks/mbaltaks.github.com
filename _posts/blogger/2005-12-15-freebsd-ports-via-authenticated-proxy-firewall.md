---
layout: post
title: FreeBSD ports via authenticated proxy firewall
date: 2005-12-15
comments: false
---

If you need to use the FreeBSD ports system from behind a proxy, you may have found <a href="http://www.burdell.org/technotes/freebsd/ports_via_proxy.txt">these</a> <a href="http://www.freebsd.org.my/modules.php?name=News&amp;file=article&amp;sid=9">articles</a> outlining how to make <a href="http://www.freebsd.org/cgi/man.cgi?query=fetch&amp;apropos=0&amp;sektion=0&amp;manpath=FreeBSD+4.10-RELEASE+and+Ports&amp;format=html">fetch(1)</a> work over a proxy, and how to replace <a href="http://www.freebsd.org/cgi/man.cgi?query=fetch&amp;apropos=0&amp;sektion=0&amp;manpath=FreeBSD+4.10-RELEASE+and+Ports&amp;format=html">fetch(1)</a> with <a href="http://www.freebsd.org/cgi/man.cgi?query=wget&amp;apropos=0&amp;sektion=0&amp;manpath=FreeBSD+4.10-RELEASE+and+Ports&amp;format=html">wget(1)</a>. What you might be interested in if you are using FreeBSD 4.10 (I think 4.x since 4.7) with an authenticated proxy server (that requires you to give a name and password to access web sites) is that you need to add DISABLE_SIZE=1 to /etc/make.conf under the FETCH_CMD line to make these versions of FreeBSD ports work with wget.

Hope that helps someone.
