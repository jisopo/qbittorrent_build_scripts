@echo off
cd /d %~dp0

rem Specify YOUR necessary extra parameters here
set PARAMS_MORE=

rem Uncomment next line to force NOT to download anything from internet
set PARAMS_MORE=%PARAMS_MORE% --noWeb

rem Do not chache all installer files on system disk (or comment next line if necessary)
set PARAMS_MORE=%PARAMS_MORE% --nocache

rem Configuration from .vsconfig
set PARAMS_MORE=%PARAMS_MORE% --config %~dp0\.vsconfig

call "%CD%\More\VisualStudioSetup.cmd" Enterprise 0
