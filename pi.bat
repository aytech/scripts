@echo off

SET ssh_key=pi_rsa
SET ssh_address=pi@192.168.0.26
SET ssh_port=22

IF "%1"=="login" (
	GOTO :LOGIN
)

IF "%1"=="" (
	GOTO :INFO
)

GOTO :EOF

:LOGIN
ssh -i %userprofile%\.ssh\%ssh_key% %ssh_address% -p %ssh_port%
GOTO :EOF

:INFO
ECHO Provide argument ("login")
GOTO :EOF

REM Change default password requirements:
REM sudo nano /etc/pam.d/common-password
REM change the line "password [success=1 default=ignore] pam_unix.so obscure sha512"
REM to: "password [success=1 default=ignore] pam_unix.so minlen=2 sha512"