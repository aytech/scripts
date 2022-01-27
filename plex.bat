@echo off

SET ssh_key=plex_rsa
SET ssh_address=oleg@192.168.1.11
REM SET ssh_address=oleg@192.168.0.10
SET ssh_port=22
SET plex_download_path=/home/oleg/Downloads

IF "%1"=="copy" (
	GOTO :TRANSFER
)

IF "%1"=="login" (
	GOTO :LOGIN
)

IF "%1"=="" (
	GOTO :INFO
)

GOTO :EOF

:TRANSFER
scp -i %ssh_key% "%2" %ssh_address%:%plex_download_path%
GOTO :EOF

:LOGIN
ssh -i %userprofile%\.ssh\%ssh_key% %ssh_address% -p %ssh_port%
GOTO :EOF

:INFO
ECHO Provide argument ("copy <file path>", "login")
GOTO :EOF

REM mount ext drive: 
REM 1. Get drive letter: sudo fdisk -l
REM 2. Mount: sudo mount -t ntfs-3g /dev/sdb1 /media/external
