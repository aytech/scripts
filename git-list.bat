@ECHO OFF

IF "%1"=="--local" (
	CALL :LOCAL
	GOTO :EOF
)
IF "%1"=="-l" (
	CALL :LOCAL
	GOTO :EOF
)
IF "%1"=="--remote" (
	CALL :REMOTE
	GOTO :EOF
)
IF "%1"=="-r" (
	CALL :REMOTE
	GOTO :EOF
)
GOTO :INFO

:LOCAL
ECHO:
git for-each-ref --sort="-committerdate:iso8601" --format="%%(committerdate:iso8601)%%09%%(refname)" refs/heads
GOTO :EOF

:REMOTE
ECHO:
git for-each-ref --sort="-committerdate:iso8601" --format="%%(committerdate:iso8601)%%09%%(refname)" refs/remotes
GOTO :EOF

:INFO
ECHO:
ECHO: Usage: git-list ^<command^>
ECHO:
ECHO: Command:
ECHO:
ECHO: -l
ECHO: --local		List local branches, formatted
ECHO:
ECHO: -r
ECHO: --remote		List remote branches, formatted
GOTO :EOF