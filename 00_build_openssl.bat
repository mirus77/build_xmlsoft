@echo off

pushd.

SET PREFIX=%~dp0\build32
SET PREFIX64=%~dp0\build64
SET OPENSSLDIR=src\openssl-3.2.0
rem SET PATH=%LOCALAPPDATA%\ActiveState\cache\bin;%PATH%
SET PATH=%ProgramFiles%\NASM;%PATH%

if %PLATFORM%A==x64A goto DoWin64
rem ==== Win32 ====
if not exist "%OPENSSLDIR%-32" goto error1

cd %OPENSSLDIR%-32

nmake clean
perl Configure --release VC-WIN32 enable-static-engine no-shared --prefix=%PREFIX% --openssldir="%PREFIX%\SSL"
nmake
nmake install

copy /y %PREFIX%\lib\libcrypto.lib %PREFIX%\lib\libcrypto_a.lib
copy /y %PREFIX%\lib\libssl.lib %PREFIX%\lib\libssl_a.lib
copy /y %PREFIX%\bin\openssl.exe %PREFIX%\bin\openssl_static.exe

nmake clean
perl Configure --release VC-WIN32 enable-static-engine shared --prefix=%PREFIX% --openssldir="%PREFIX%\SSL"
nmake
nmake install

goto doend

:DoWin64
rem ==== Win64 ====
if not exist "%OPENSSLDIR%-64" goto error2
cd %OPENSSLDIR%-64

nmake clean
perl Configure no-asm --release VC-WIN64A enable-static-engine no-shared --prefix=%PREFIX64% --openssldir="%PREFIX64%\SSL"
nmake
nmake install

copy /y %PREFIX64%\lib\libcrypto.lib %PREFIX64%\lib\libcrypto_a.lib
copy /y %PREFIX64%\lib\libssl.lib %PREFIX64%\lib\libssl_a.lib
copy /y %PREFIX64%\bin\openssl.exe %PREFIX64%\bin\openssl_static.exe

nmake clean
perl Configure no-asm --release VC-WIN64A enable-static-engine shared --prefix=%PREFIX64% --openssldir="%PREFIX64%\SSL"
nmake
nmake install

goto doend

:error1
echo !!!
echo !!! Source directory "%OPENSSLDIR%-32" not exists !!!
echo !!!
goto doend

:error2
echo !!!
echo !!! Source directory "%OPENSSLDIR%-64" not exists !!!
echo !!!
goto doend

:doend
popd

