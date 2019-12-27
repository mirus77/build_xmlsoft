@echo off

SET PREFIX=%~dp0\build32
SET PREFIX64=%~dp0\build64
SET OPENSSLDIR=src\openssl-1.1.1d

if %PLATFORM%A==x64A goto DoWin64
rem ==== Win32 ====
cd %OPENSSLDIR%-32

nmake clean
perl Configure VC-WIN32 enable-static-engine no-shared --prefix=%PREFIX% --openssldir="%PREFIX%\SSL"
nmake install
copy /y %PREFIX%\lib\libcrypto.lib %PREFIX%\lib\libcrypto_a.lib
copy /y %PREFIX%\lib\libssl.lib %PREFIX%\lib\libssl_a.lib
copy /y %PREFIX%\bin\openssl.exe %PREFIX%\bin\openssl_static.exe

nmake clean
perl Configure VC-WIN32 enable-static-engine shared --prefix=%PREFIX% --openssldir="%PREFIX%\SSL"
nmake install

goto doend

:DoWin64
rem ==== Win64 ====
cd %OPENSSLDIR%-64

nmake clean
perl Configure VC-WIN64A enable-static-engine  no-shared --prefix=%PREFIX64%  --openssldir="%PREFIX64%\SSL"
nmake install
copy /y %PREFIX64%\lib\libcrypto.lib %PREFIX64%\lib\libcrypto_a.lib
copy /y %PREFIX64%\lib\libssl.lib %PREFIX64%\lib\libssl_a.lib
copy /y %PREFIX64%\bin\openssl.exe %PREFIX64%\bin\openssl_static.exe

nmake clean
perl Configure VC-WIN64A enable-static-engine shared --prefix=%PREFIX64%  --openssldir="%PREFIX64%\SSL"
nmake install

:doend
cd ..\..
