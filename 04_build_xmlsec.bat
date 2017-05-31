@echo off

setlocal


if %PLATFORM%A==x64A goto DoWin64
SET PREFIX=%~dp0\build32
goto doit
:DoWin64
SET PREFIX=%~dp0\build64

:doit

cd src\xmlsec1-1.2.24\Win32
nmake clean

SET XMLSEC_INCLUDE=%PREFIX%\include;%PREFIX%\include\libxml2;%PREFIX%\include\libiconv;%PREFIX%\include\mozilla;%PREFIX%\include\mozilla\nspr;%PREFIX%\include\mozilla\nss;%MSSDK_INCLUDE%
SET XMLSEC_LIB=%PREFIX%\lib;%MSSDK_LIB%
SET XMLSEC_OPTIONS=static=yes iconv=yes debug=no xslt=yes crypto=openssl,mscrypto unicode=yes with-dl=yes

del /F Makefile configure.txt
cscript configure.js prefix=%PREFIX% %XMLSEC_OPTIONS% include=%XMLSEC_INCLUDE% lib=%XMLSEC_LIB% sodir=%PREFIX%\bin
nmake install

cd ..\..\..
