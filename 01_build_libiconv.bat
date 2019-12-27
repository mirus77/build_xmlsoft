@echo off
setlocal

if %PLATFORM%A==x64A goto DoWin64
SET PREFIX=%~dp0\build32
goto doit
:DoWin64
SET PREFIX=%~dp0\build64
:doit

cd src\libiconv-1.16_VC\Win32
nmake clean

SET LIBICONV_INCLUDE=%PREFIX%\include;%MSSDK_INCLUDE%
SET LIBICONV_LIB=%PREFIX%\lib;%MSSDK_LIB%
SET LIBICONV_OPTIONS=static=yes cruntime=/MT debug=no unicode=yes

del /F Makefile configure.txt
cscript configure.js prefix="%PREFIX%" %LIBICONV_OPTIONS% include="%LIBICONV_INCLUDE%" lib="%LIBICONV_LIB%" sodir="%PREFIX%\bin"
nmake install

copy /y %PREFIX%\lib\libiconv.lib %PREFIX%\lib\iconv.lib
copy /y %PREFIX%\lib\libiconv_a.lib %PREFIX%\lib\iconv_a.lib

cd ..\..\..
