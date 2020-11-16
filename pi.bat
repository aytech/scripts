@echo off

SET ssh_key=C:\Users\oyapparov\.ssh\pi_rsa
SET ssh_address=pi@192.168.0.26

IF "%1"=="login" (
	GOTO :LOGIN
)

IF "%1"=="" (
	GOTO :INFO
)

GOTO :EOF

:LOGIN
ssh -i %ssh_key% %ssh_address%
GOTO :EOF

:INFO
ECHO Provide argument ("login")
GOTO :EOF

REM Change default password requirements:
REM sudo nano /etc/pam.d/common-password
REM change the line "password [success=1 default=ignore] pam_unix.so obscure sha512"
REM to: "password [success=1 default=ignore] pam_unix.so minlen=2 sha512"