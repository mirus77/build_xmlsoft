@echo off

SET PREFIX=%~dp0\build32
SET PREFIX64=%~dp0\build64
SET OPENSSLDIR=src\openssl-1.0.2l

if %PLATFORM%A==x64A goto DoWin64
rem ==== Win32 ====
cd %OPENSSLDIR%-32

nmake -f ms\ntdll.mak clean
nmake -f ms\nt.mak clean

rem == without NASM ==
rem perl Configure VC-WIN32 no-asm enable-static-engine --prefix=%PREFIX%
rem ms\do_ms.bat

rem == with NASM ==
rem perl Configure VC-WIN32 enable-static-engine --prefix=%PREFIX%
perl Configure VC-WIN32 --prefix=%PREFIX%
call ms\do_nasm.bat
nmake -f ms\nt.mak install
copy /y %PREFIX%\lib\libeay32.lib %PREFIX%\lib\libeay32_a.lib
copy /y %PREFIX%\lib\ssleay32.lib %PREFIX%\lib\ssleay32_a.lib
copy /y %PREFIX%\bin\openssl.exe %PREFIX%\bin\openssl_static.exe
nmake -f ms\nt.mak clean
nmake -f ms\ntdll.mak install
rem editbin.exe /rebase:base=0x11000000 %PREFIX%\bin\libeay32.dll
rem editbin.exe /rebase:base=0x12000000 %PREFIX%\bin\ssleay32.dll

goto doend

:DoWin64
rem ==== Win64 ====
cd %OPENSSLDIR%-64
nmake -f ms\ntdll.mak clean
nmake -f ms\nt.mak clean

rem perl Configure VC-WIN64A enable-static-engine --prefix=%PREFIX64%
perl Configure VC-WIN64A --prefix=%PREFIX64%
call ms\do_win64A.bat
nmake -f ms\nt.mak install
copy /y %PREFIX64%\lib\libeay32.lib %PREFIX64%\lib\libeay32_a.lib
copy /y %PREFIX64%\lib\ssleay32.lib %PREFIX64%\lib\ssleay32_a.lib
copy /y %PREFIX64%\bin\openssl.exe %PREFIX64%\bin\openssl_static.exe
nmake -f ms\nt.mak clean
nmake -f ms\ntdll.mak install
rem editbin.exe /rebase:base=0x11000000 %PREFIX%\bin\libeay32.dll
rem editbin.exe /rebase:base=0x12000000 %PREFIX%\bin\ssleay32.dll

:doend
cd ..\..
