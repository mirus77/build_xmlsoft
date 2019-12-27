@echo off
title Build x64
rem Visual Stdion 2013
rem %comspec% /k ""C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\vcvarsall.bat"" x86_amd64
rem Visual Stdion 2017
rem %comspec% /k ""C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build\vcvarsamd64_x86.bat"" x86_amd64
rem Visual Stdion 2019
%comspec% /k ""C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvarsamd64_x86.bat"" x86_amd64
