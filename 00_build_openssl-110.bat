@echo off

SET PREFIX=%~dp0\build32
SET PREFIX64=%~dp0\build64
SET OPENSSLDIR=src\openssl-1.1.0f

if %PLATFORM%A==x64A goto DoWin64
rem ==== Win32 ====
cd %OPENSSLDIR%-32

nmake clean
perl Configure VC-WIN32 enable-static-engine --prefix=%PREFIX%
nmake install
rem mv -f %PREFIX%\bin\openssl.exe %PREFIX%\bin\openssl_static.exe

goto doend

:DoWin64
rem ==== Win64 ====
cd %OPENSSLDIR%-64

nmake clean
perl Configure VC-WIN64A enable-static-engine --prefix=%PREFIX64%
nmake install
rem mv -f %PREFIX64%\bin\openssl.exe %PREFIX64%\bin\openssl_static.exe

:doend
cd ..\..
