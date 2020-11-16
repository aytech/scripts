@echo off

IF "%1"=="login" (
	GOTO :LOGIN
)

IF "%1"=="stop" (
	GOTO :STOP
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

GOTO :INFO

:LOGIN
vboxmanage showvminfo "Ubuntu Focal Fossa" | findstr /r /c:"State:[ ]*running" > tmp.txt
SET /p state= < tmp.txt
IF %ERRORLEVEL% == 0 (
	ECHO Machine already running, logging in...
	DEL tmp.txt
	GOTO :SSH
) ELSE (
	ECHO Machine not running, starting...
	DEL tmp.txt
	GOTO :START
)

:START
vboxmanage startvm "Ubuntu Focal Fossa" --type headless
ECHO Waiting for machine to boot
timeout /t 30 /nobreak
GOTO :SSH

REM For this to work without password, generate SSH keys:
REM ssh-keygen -t rsa -b 4096 -C "oleg@127.0.0.1"
REM Copy the public key to the server: ssh-copy-id -i <public key file> oleg@127.0.01
REM ssh oleg@127.0.0.1
:SSH
ssh oleg@127.0.0.1
GOTO :EOF

:STOP
vboxmanage controlvm "Ubuntu Focal Fossa" poweroff
GOTO :EOF

:STATUS
vboxmanage showvminfo "Ubuntu Focal Fossa" | findstr State
GOTO :EOF

:LIST
vboxmanage list vms
GOTO :EOF

:INFO
ECHO Provide argument ("login", "stop", "status" or "list")
GOTO :EOF