---
layout: post
title: Making Plone work with Apache and Active Directory on Mac OS X
date: 2006-12-18
comments: false
---

I posted a comment at http://plone.org/documentation/how-to/singlesignonwindowsdomains updating the instructions there to work with mod_rewrite, since zope's fastcgi support is on the way out. Here's the post:

As of December 2006, Plone is at 2.5.1, Zope is 2.9.6 and Apache is 2.2.3. Zope 2.9 has depreciated fastcgi altogether, and apache 2.2 won't work nicely with mod_fastcgi (mod_fcgid works, but doesn't support the FastCgiExternalServer needed for zope with fastcgi). So I needed to keep using mod_ntlm, but use it with mod_rewrite rather than fastcgi. And I've made it work!

Assuming a plone site in zope called /plone, here is some apache 2.2 config that works with mod_rewrite, mod_proxy (and mod_proxy_http) and mod_headers.

```apache
<Location /zope/plone>
# Use this line instead (with the lines below) to have plone at the web site root.
#<Location /plone>
AuthName "Active Directory Domain"
AuthType NTLM
NTLMAuth on
NTLMAuthoritative on
NTLMDomain domain
NTLMServer domain-controller-1
NTLMBackup domain-controller-2
require valid-user
</Location>

LoadModule proxy_module modules/mod_proxy.so
LoadModule proxy_http_module modules/mod_proxy_http.so
RewriteEngine On
RewriteCond %{LA-U:REMOTE_USER} (.+)
RewriteRule ^/zope/(.*) \
http://localhost:8080/VirtualHostBase/http/%{SERVER_NAME}:80/VirtualHostRoot/_vh_zope/$1 \
[L,P,E=RU:%1]
# Use these alternatives with the alternative Location above to put plone at the root.
#RewriteRule ^/(.*) \
#http://localhost:8080/VirtualHostBase/http/%{SERVER_NAME}:80/VirtualHostRoot/$1 \
#[L,P,E=RU:%1]
RequestHeader set X_REMOTE_USER %{RU}e
```

To make mod_ntlm work correctly with this reverse proxy config, I had to make some changes, which are now in the trunk of subversion at the source forge project. svn co https://modntlm.svn.sourceforge.net/svnroot/modntlm/trunk - this is the same code as found at http://modntlm.jamiekerwick.co.uk/ with a patch to fix reverse proxy auth.

On the zope/plone side, I had to install apachepas (http://dev.plone.org/collective/browser/PASPlugins/apachepas, svn co http://svn.plone.org/svn/collective/PASPlugins/apachepas) into the products folder and add it to the acl_users folder for the plone instance. Make sure you put the contents of the trunk folder into a folder called "apachepas" in the products folder. I also needed LDAPMultiPlugins (http://www.dataflake.org/software/ldapmultiplugins) which might depend on LDAPUserFolder (http://www.dataflake.org/software/ldapuserfolder) - both just need to be copied into the products folder and then LDAPMultiPlugins added to the acl_users folder in the plone instance. Configuring the LDAPUserFolder within LDAPMultiPlugins is up to you, since it depends on your directory layout. I suggest talking to an (Active, e-, Open) Directory expert, and using an LDAP browser to get the settings right before going to the LDAPUserFolder.

As a starting point, here's the schema I used for Active Directory:

```
LDAP, Friendly name, maps to, multi
-----------------------------------
objectGUID, AD Object GUID, objectGUID, No
cn, Canonical Name, , No
dn, Distinguished Name, dn, No
givenName, First Name, first_name, No
memberOf, Group DNs, memberOf, Yes
sn, Last Name, last_name, No
sAMAccountName, Windows Login Name, windows_login_name, No
mail, Email address, email, No
displayName, Full Name, fullname, No
```

Then make Login Name Attribute and User ID Attribute use sAMAccountName.
Match all the Zope groups with LDAP groups, if required.
Activate all the plugins for all the types (Authentication, Extraction, etc)
Now you can search for users and add them to groups.
That was it.



For reference, I also made the fastcgi method work before I attempted this, using SharkbyteSSOPlugin (http://plone.org/products/single-sign-on-plugin/releases/0.5/sharkbytessoplugin-0-5-tar.gz) in place of apachepas. I had to set SharkbyteSSOPlugin to use REMOTE_USER, rather than X_REMOTE_USER, but all the other setup was the same. This was with Apache 1.3.37 and mod_fastcgi SNAP-0404142202 and my patched mod_ntlm, and patched FCGIServer.py for Zope.

```patch
--- /usr/local/zope/lib/python/ZServer/FCGIServer.py 2006-10-03 01:53:27.000000000 +1000
+++ ./FCGIServer.py 2006-11-22 23:01:19.000000000 +1100
@@ -466,6 +466,11 @@
user_name = '-'
else:
user_name = t[0]
+ if string.lower(http_authorization[:5]) == 'ntlm ':
+ # The user_name is set elsewhere
+ user_name = "ntlm user"
+ else:
+ user_name = "Unsupported HTTP Auth type"
else:
user_name='-'
if self.addr:
```

Save the above to zope-fcgi-ntlm.patch then run:
`patch -p0 $PREFIX/zope/lib/python/ZServer/FCGIServer.py zope-fcgi-ntlm.patch`
