@ECHO OFF

IF "%1"=="" (
	CALL :INFO
	GOTO :EOF
)

SET /A B=(%1*1024*1024)
fsutil file createnew test.jpg %B%
GOTO :EOF

:INFO
ECHO: Usage:
ECHO: *** file ^<size in MB^> ***