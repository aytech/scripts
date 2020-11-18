@ECHO OFF

REM Usage:
REM 1. Generate SSH keys: 
REM 	- ssh-keygen -t rsa -b 4096 -C "oleg@127.0.0.1" (name the file ubuntu_rsa, passphrase empty)
REM 2. Make sure the machine is running 
REM 	- ubuntu login Server 2222
REM 3. Copy the public key to the server: ssh-copy-id -i ubuntu_rsa.pub -p 2222 oleg@127.0.01

SET /A port=22
SET VM=Ubuntu Focal Fossa

IF "%1"=="login" (
	CALL :LOGIN %2 %3
)

IF "%1"=="stop" (
	CALL :STOP %2
)

IF "%1"=="status" (
	GOTO :STATUS
)

IF "%1"=="list" (
	GOTO :LIST
)

IF "%1"=="" (
	GOTO :INFO
)

GOTO :EOF

:LOGIN
IF NOT "%1" == "" (
	SET VM=%1
)
IF NOT "%2" == "" (
	SET /A port=%2
)
vboxmanage list vms | findstr /r /c:"%VM%" > tmp.txt
SET /p vm = < tmp.txt
IF %ERRORLEVEL% == 0 (
	CALL :RUN
) ELSE (
	ECHO VM with name "%VM%" not found, please select from the list:
	CALL :LIST
)
DEL tmp.txt
GOTO :EOF

:RUN
vboxmanage showvminfo "%VM%" | findstr /r /c:"State:[ ]*running" > tmp.txt
SET /p state = < tmp.txt
IF %ERRORLEVEL% == 0 (
	ECHO Machine already running, logging in...
	CALL :SSH
) ELSE (
	ECHO Machine not running, starting...
	REM CALL :START %1 %2
)
DEL tmp.txt
GOTO :EOF

:START
vboxmanage startvm "%1" --type headless
ECHO Waiting for machine to boot
timeout /t 30 /nobreak
CALL :SSH %2
GOTO :EOF

:SSH 
ssh -i %userprofile%\.ssh\ubuntu_rsa oleg@127.0.0.1 -p %port%
GOTO :EOF

:STOP
IF NOT "%1" == "" (
	SET VM=%1
)
vboxmanage controlvm "%VM%" poweroff
GOTO :EOF

:STATUS
REM vboxmanage showvminfo "Ubuntu Focal Fossa" | findstr State
ECHO Not implemented
GOTO :EOF

:LIST
vboxmanage list vms
GOTO :EOF

:INFO
ECHO Provide argument ("login <name of VM> <SSH port>", "stop", "status" or "list")
GOTO :EOF