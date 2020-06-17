REM Move KSP Configs by a File List

REM @echo OFF

:FileListSet
CLS

set /p FileList=Enter desired 'File.Lst' to process: 

if %1 ==1
(
	set /p FileList=Provide new 'File.Lst' or Enter: 
)

if exist "%FileList%"
(
	echo File "%FileList%" found.
	echo List to process locked to "%FileList%"
	goto :Prompt
) 
else 
(
	echo File "%FileList%" not found. Exiting.
	timeout 3
	exit 2
)


:SourceSet
CLS

set "Source=C:\Games\Kerbal Space Program\KSPwin64-1.9.1"
echo Source Folder currently set to "%Source%"

if %1 ==2
(
	set /p Source=Provide new Source Folder or Enter: 
)

if exist "%Source%"
(
	echo Source Folder "%Source%" found.
	timeout 3
	goto TargetSet
) 
else
(
	echo Source Folder "%Source%" not found. Exiting.
	timeout 3
	exit 2
)
pause


:TargetSet
CLS
set "Target=C:\Games\Kerbal Space Program\KSPwin64-1.9.1 [DnD]\RemovedFiles\%FileList:~0,-4%"
echo Target Folder currently set to "%Target%"

if %1 ==3
(
	set /p Target=Provide new Target Folder or Enter: 
)

if exist "%Target%"
(
	echo Target Folder "%Source%" found.
	timeout 3
	goto Bye
)
else
(
	md "%target%"
)
echo Target Folder set to "%target%"
pause

:Process
FOR /F "delims=" %%a in ('type "%FileList%"') do move "%source%\%%a" "%target%"
echo File move complete.
timeout 5
goto Bye


:LastDance
echo List to process locked to "%FileList%"
echo Press 1 to change
echo
echo Source Folder locked to "%Source%"
echo Press 2 to change
echo
echo Target Folder locked to "%Target%"
echo Press 3 to change
echo
echo

choice /N /C:1234 /M "Pick a number (1, 2, 3, or 4)" %1
if ERRORLEVEL ==4
(

)
if ERRORLEVEL ==3
(
	echo Changing FileList ...
	timeout 3
	goto FileListSet
)
else if ERRORLEVEL ==2 goto SourceSet
(
	echo Changing Source Foler ...
	timeout 3
	goto SourceSet
)
else if ERRORLEVEL ==1 goto FileListSet
(
	echo Changing Target Folder ...
	timeout 3
	goto TargetSet
)

:Prompt
if exist "%SystemRoot%\System32\choice.exe" goto UseChoice

setlocal EnableExtensions EnableDelayedExpansion

:UseSetPrompt
set "UserChoice=N"
set /P "UserChoice=Are you sure [Y/N]?"
set "UserChoice=!UserChoice: =!"
if /I "!UserChoice!" == "N" endlocal & goto :EOF
if /I not "!UserChoice!" == "Y" goto UseSetPrompt
endlocal
goto Continue

:UseChoice
REM | CHOICE /T:N,10 >NUL
REM %SystemRoot%\System32\choice.exe /T 8 /C YN /D Y /M "Are you sure [Y/N]?"
if errorlevel 2 goto Bye

:Continue
echo So, you think you're ready? Okay, let's go ...
goto STset

:Bye
CLS
echo Process complete.
echo Press any key to close this window.
pause > nul
