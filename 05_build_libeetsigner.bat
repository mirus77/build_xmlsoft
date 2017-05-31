@echo off
REM
REM This is my personal configuration file.
REM I am lazy to type all this crap again and again
REM You are welcome to customize this file for your
REM needs but do not check it into the GitHub, please.
REM
REM Mirus <mail@mirus.cz>
REM
REM ussage : mycfg [debug]

set local

if %PLATFORM%A==x64A goto DoWin64
SET PREFIX=%~dp0\build32
goto doit
:DoWin64
SET PREFIX=%~dp0\build64

:doit
cd src\libeetsigner\Win32
nmake clean

SET LIBEET_INCLUDE=%PREFIX%\include;%PREFIX%\include\libiconv;%PREFIX%\include\libxml2;%MSSDK_INCLUDE%
SET LIBEET_LIB=%PREFIX%\lib;%MSSDK_LIB%
SET LIBEET_OPTIONS=static=yes debug=no unicode=yes

del /F Makefile configure.txt version32.rc
cscript configure.js prefix="%PREFIX%" %LIBEET_OPTIONS% include="%LIBEET_INCLUDE%" lib="%LIBEET_LIB%" sodir="%PREFIX%\bin"

nmake install

cd ..\..\..
