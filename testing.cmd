@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION

SET ACTION=login
SET PORT=22

SET argCount = 0
FOR %%x IN (%*) DO (
	SET /A argCount+=1
	SET "argVec[!argCount!]=%%~x"
)
FOR /L %%i IN (1,1,%argCount%) DO (
	ECHO: %%~i+1
	IF "!argVec[%%i]!"=="--port" (
		SET /A index=%%~i+1
		ECHO: %index%
		ECHO: %%i - "!argVec[%%i]!"
		REM SET /A valueIndex=%%i+1
		REM ECHO: Index: %valueIndex%
		REM REM ECHO: %%i - "!argVec[%%i + 1]!"
	)
)

IF "%1"=="login" (
	CALL :RUN_COMMAND
)
GOTO :EOF

:SET_VAR
ECHO: Setting: %~1 %~2
REM IF "%~1"=="--port" (
	REM ECHO: First: %~1
	REM ECHO: Second: %~2
	REM IF NOT "%~2"=="" (
		REM ECHO: Two: %~2
		REM SET /A PORT=%~2
		REM ECHO: Two: !PORT!
	REM )
REM )

:RUN_COMMAND
ECHO: Port: %PORT%
GOTO :EOF

REM Substitution of batch parameters (%n) has been enhanced:
REM
REM    %~1         - expands %1 removing any surrounding quotes (")
REM    %~f1        - expands %1 to a fully qualified path name
REM    %~d1        - expands %1 to a drive letter only
REM    %~p1        - expands %1 to a path only
REM    %~n1        - expands %1 to a file name only
REM    %~x1        - expands %1 to a file extension only
REM    %~s1        - expanded path contains short names only
REM    %~a1        - expands %1 to file attributes
REM    %~t1        - expands %1 to date/time of file
REM    %~z1        - expands %1 to size of file
REM    %~$PATH:1   - searches the directories listed in the PATH
REM                   environment variable and expands %1 to the fully
REM                   qualified name of the first one found.  If the
REM                   environment variable name is not defined or the
REM                   file is not found by the search, then this
REM                   modifier expands to the empty string
REM
REM The modifiers can be combined to get compound results:
REM
REM    %~dp1       - expands %1 to a drive letter and path only
REM    %~nx1       - expands %1 to a file name and extension only
REM    %~dp$PATH:1 - searches the directories listed in the PATH
REM                   environment variable for %1 and expands to the
REM                   drive letter and path of the first one found.
REM    %~ftza1     - expands %1 to a DIR like output line