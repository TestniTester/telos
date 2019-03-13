@echo off
setlocal
set runState=user
whoami /groups | findstr /b /c:"Mandatory Label\High Mandatory Level" > nul && set runState=admin
whoami /groups | findstr /b /c:"Mandatory Label\System Mandatory Level" > nul && set runState=system
echo Running in state: "%runState%"
if not "%runState%"=="user" goto notUser
  echo You need to run this script as Administrator!
  goto end
:notUser
if not "%runState%"=="admin" goto notAdmin
  REM disable interface
  echo Disabling/enabling local ethernet adapter, wait for 30 seconds...
  netsh interface set interface "Ethernet" admin=disable
  timeout 30
  REM enable interface
  netsh interface set interface "Ethernet" admin=Enable
  echo DONE!
  goto end
:notAdmin
if not "%runState%"=="system" goto notSystem
REM  echo Do admin stuff...
  goto end
:notSystem
REM echo Do common stuff...
:end


echo Script created by TheBoss, if you get any value from it please donate
echo donation TELOS address: GTvVmn5Yvuzg9CyyiYRmJ57mMVDG21PUnt
echo .
echo .
echo .

pause
