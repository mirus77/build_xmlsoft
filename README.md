# Build xmlsoft libs
---
Scripts for building binary windows DLLs of:

* OpenSSL (http://www.openssl.org)
* LibXML (http://xmlsoft.org)
* LibXSLT (http://xmlsoft.org/XSLT
* XMLSec (http://http://www.aleksey.com/xmlsec/)

This scripts is published under the MIT Licence see the LICENCE file.

author of build scripts : Miroslav Kundela &lt;mail(at)mirus.cz&gt;

Usage
---

Clone into build directory (example C:\build)
Unpack zip files from src directory inside.

Can be used original tars archive from orig websites, then adapt path to source in build scripts.

Run _buildtools.bat or _buildtoolsx64.bat (calling Visual Studio 2017 rsvars.cmd)

comands inside buildtools prompt:

00_build_openssl.bat
01_build_libiconv.bat
02_build_libxml.bat
03_build_libxslt.bat
04_build_xmlsec.bat

Troubleshooting
---

* when build xmlsec extension xmlsec-openssl from original source with error link: libcrypto.lib not found.

	Do replace strings libcrypto.lib in xmlsec1-*/win32/Makefile.msvc
	```
	# openssl 1.1.x
	XMLSEC_OPENSSL_SOLIBS   = libcrypto.lib wsock32.lib kernel32.lib .....
	XMLSEC_OPENSSL_ALIBS    = libcrypto.lib wsock32.lib kernel32.lib .....
	```
	to
	```
	# openssl 1.0.x
	XMLSEC_OPENSSL_SOLIBS   = libeay32.lib wsock32.lib kernel32.lib ......
	XMLSEC_OPENSSL_ALIBS    = libeay32_a.lib wsock32.lib kernel32.lib .....
	```

