@echo off

setlocal

if %PLATFORM%A==x64A goto DoWin64
SET PREFIX=%~dp0\build32
goto doit
:DoWin64
SET PREFIX=%~dp0\build64

:doit

cd src\libxslt-1.1.34\Win32
nmake clean

SET LIBXML_INCLUDE=%PREFIX%\include;%PREFIX%\include\libiconv;%PREFIX%\include\libxml2;%MSSDK_INCLUDE%
SET LIBXML_LIB=%PREFIX%\lib;%MSSDK_LIB%
SET LIBXML_OPTIONS=iconv=yes compiler=msvc cruntime=/MT debug=no static=yes

del /F Makefile configure.txt
cscript configure.js prefix=%PREFIX% %LIBXML_OPTIONS% include=%LIBXML_INCLUDE% lib=%LIBXML_LIB% sodir=%PREFIX%\bin

nmake install

cd ..\..\..
