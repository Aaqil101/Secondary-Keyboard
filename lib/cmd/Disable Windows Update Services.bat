@echo off

REM Change to directory where the batch file is located.
cd C:\Users\User\Documents\AHK - Scripting\Secondary Keyboard Into A Macroboard\AHK Codes\lib\cmd


REM Check to see if this batch file is being run as Administrator

openfiles > NUL 2>&1 
if NOT %ERRORLEVEL% EQU 0 goto NotAdmin 
goto IsAdmin

   :NotAdmin

REM The batch file was not run as admin. Launch a new copy of the batch file as admin and close the current instance.

powershell.exe start-process '%~f0' -verb runas
exit

   :IsAdmin

REM End Routine to check if being run as Admin


REM Stop the macrium service

net stop BITS /y
sc config BITS start= disabled
net stop wuauserv /y
sc config wuauserv start= disabled
pause

REM End program
   :END