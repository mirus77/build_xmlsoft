@echo off

setlocal

pushd .

if %PLATFORM%A==x64A goto DoWin64
SET PREFIX=%~dp0build32
goto doit
:DoWin64
SET PREFIX=%~dp0build64

:doit

cd src\xmlsec-xmlsec_1_3_2\Win32

nmake clean

SET XMLSEC_INCLUDE=%PREFIX%\include;%PREFIX%\include\libxml2;%PREFIX%\include\libiconv;%PREFIX%\include\mozilla;%PREFIX%\include\mozilla\nspr;%PREFIX%\include\mozilla\nss;%MSSDK_INCLUDE%
SET XMLSEC_LIB=%PREFIX%\lib;%MSSDK_LIB%
SET XMLSEC_OPTIONS=static=yes iconv=no debug=no crypto=openssl-300,mscrypto,mscng cruntime=/MT unicode=yes with-dl=yes with-openssl3-engines=yes

del /Q /F Makefile configure.txt
cscript configure.js prefix=%PREFIX% %XMLSEC_OPTIONS% include=%XMLSEC_INCLUDE% lib=%XMLSEC_LIB% sodir=%PREFIX%\bin
nmake install

:doend
popd
