@ECHO OFF
CLS
powercfg -list > "%cd%\priorpowerprofile.txt"
IF %errorlevel% NEQ 0 (
	ECHO Error listing the power profiles.
	PAUSE
	EXIT /B 1
)
powercfg -import "%cd%\AlwaysOn.pow" cc843c4f-61f2-4223-8116-927ad88f4aff
IF %errorlevel% NEQ 0 (
	ECHO Error importing the always-on power profile.
	ECHO %errorlevel%
	PAUSE
	EXIT /B 1
)
powercfg -setactive cc843c4f-61f2-4223-8116-927ad88f4aff
IF %errorlevel% NEQ 0 (
	ECHO Error setting the active power profile.
	PAUSE
	EXIT /B 1
)
EXIT /B 0
