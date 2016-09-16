---
layout: post
title: Windows 2000 full cpu load issue
date: 2006-01-20
comments: false
---

Compaq Evo D510 SFF with Microsoft Windows 2000 was not working, investigation showed cpu maxed out - all in the System process. <a href="http://www.sysinternals.com/Utilities/ProcessExplorer.html">Process Explorer</a> showed 100% cpu split between System and DPCs, which seemed to indicate a device driver problem. A bit of internet searching led me to try disabling the USB drivers, but in the end I only had to disable "Intel PCI to USB Enhanced Host Controller" in the Device Manager to fix the problem, leaving USB still working.

<a href="http://www.experts-exchange.com/Applications/Q_20776549.html">Initial help</a>

<a href="http://support.microsoft.com/default.aspx?scid=kb;en-us;841382">MS Knowledge base</a> (similar issue)

<a href="http://groups.google.com/group/microsoft.public.windowsxp.general/browse_thread/thread/dc3d5d3ab0bf568a/7de2926fb7f9a72c?lnk=st&q=%22windows+2000%22+dpcs+high+cpu%5C&rnum=1&hl=en#7de2926fb7f9a72c">More help</a>
