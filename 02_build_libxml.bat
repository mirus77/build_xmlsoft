@echo off

setlocal

if %PLATFORM%A==x64A goto DoWin64
SET PREFIX=%~dp0\build32
goto doit
:DoWin64
SET PREFIX=%~dp0\build64
:doit

cd src\libxml2-2.9.4\Win32
nmake clean

SET LIBXML_INCLUDE=%PREFIX%\include;%PREFIX%\include\libiconv;%MSSDK_INCLUDE%
SET LIBXML_LIB=%PREFIX%\lib;%MSSDK_LIB%
SET LIBXML_OPTIONS=iconv=yes compiler=msvc cruntime=/MD debug=no static=yes vcmanifest=yes

del /F Makefile configure.txt
cscript configure.js prefix=%PREFIX% %LIBXML_OPTIONS% include=%LIBXML_INCLUDE% lib=%LIBXML_LIB%

nmake install

cd ..\..\..
