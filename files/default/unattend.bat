@reg add HKLM\Software\Microsoft\DevDiv\0b3d680166a14e50a8c8e2ed060d8d90 /v Elevated /t REG_DWORD /d 1 /f > nul 2>&1
@if /i "%errorlevel%"=="1" echo Error: elevation required. &exit /b 740
@reg delete HKLM\Software\Microsoft\DevDiv\0b3d680166a14e50a8c8e2ed060d8d90 /va /f > nul 2>&1

"%~dp0setup\setup.exe" /q /norestart /unattendfile "%~dp0unattend.ini"
@if /i "%errorlevel%"=="3010" (echo Returned 3010: Need to reboot when setup is complete.) else (
if /i "%errorlevel%"=="3015" (echo Returned 3015: Need to reboot and restart setup. &exit /b %errorlevel%) else (
if /i "%errorlevel%"=="0" (echo Returned 0: Install completed succeeded.) else (
echo Returned %errorlevel%: Install failed. &exit /b %errorlevel%)))

"%ProgramFiles%\Microsoft Help Viewer\v1.0\HelpLibManager.exe" /silent /product VS /version 100 /locale en-US /content "%ProgramData%\Microsoft\HelpLibrary" /sourceMedia "%~dp0ProductDocumentation\HelpContentSetup.msha"
@if /i "%errorlevel%"=="3010" (echo Returned 3010: Need to reboot when setup is complete.) else (
if /i "%errorlevel%"=="3015" (echo Returned 3015: Need to reboot and restart setup. &exit /b %errorlevel%) else (
if /i "%errorlevel%"=="0" (echo Returned 0: Install completed succeeded.) else (
echo Returned %errorlevel%: Install failed. &exit /b %errorlevel%)))

"%~dp0SP1\setup.exe" /q
@if /i "%errorlevel%"=="3010" (echo Returned 3010: Need to reboot when setup is complete.) else (
if /i "%errorlevel%"=="3015" (echo Returned 3015: Need to reboot and restart setup. &exit /b %errorlevel%) else (
if /i "%errorlevel%"=="0" (echo Returned 0: Install completed succeeded.) else (
echo Returned %errorlevel%: Install failed. &exit /b %errorlevel%)))