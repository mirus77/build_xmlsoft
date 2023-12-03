# Build xmlsoft libs
---
Scripts for building binary windows DLLs and static of:

* OpenSSL 3.2.0 (http://www.openssl.org)
* LibXML 2.11.5 (http://xmlsoft.org)
* LibXSLT 1.1.39 (http://xmlsoft.org/XSLT
* XMLSec 1.3.2(http://http://www.aleksey.com/xmlsec/)

This scripts is published under the MIT Licence see the LICENCE file.

author of build scripts : Miroslav Kundela &lt;mail(at)mirus.cz&gt;

Usage
---

Install Visual Studio 2013 Update 5 Community. (successfully tested with VS 2019)

Clone into build directory (example C:\build)

Unpack zip files from src directory inside. Skip existings files in source folder.

Install Perl (strawberry-perl) for build OpenSSL

Install NASM for build OpenSSL 3.2.x Win32

Can be used original tars archive from orig websites, then adapt path to source in build scripts.

Run _buildtools.bat or _buildtoolsx64.bat (calling Visual Studio 2019 rsvars cmd prompt)

comands inside buildtools prompt:

	00_build_openssl.bat
	01_build_libiconv.bat
	02_build_libxml.bat
	03_build_libxslt.bat
	04_build_xmlsec.bat

Troubleshooting
---

* when building xmlsec 1.1.29 extension xmlsec-openssl from original source with error link: libcrypto.lib not found.

	Do replace strings libcrypto.lib in xmlsec1-*/win32/Makefile.msvc
	```
	# openssl 1.1.x
	XMLSEC_OPENSSL_SOLIBS   = libcrypto.lib wsock32.lib kernel32.lib ws2_32.lib .....
	XMLSEC_OPENSSL_ALIBS    = libcrypto_a.lib wsock32.lib kernel32.lib ws2_32.lib .....
	```
	to
	```
	# openssl 1.0.x
	XMLSEC_OPENSSL_SOLIBS   = libeay32.lib wsock32.lib kernel32.lib ......
	XMLSEC_OPENSSL_ALIBS    = libeay32_a.lib wsock32.lib kernel32.lib .....
	```
