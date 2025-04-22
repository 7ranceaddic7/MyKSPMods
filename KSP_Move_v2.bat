REM KSP_Move_v2.bat - Improved Script with Enhancements and Comments

REM Move KSP Configs by a File List

@echo OFF  REM Enable echo off to avoid cluttering the console output.

REM ============================
REM Step 1: File List Input
REM ============================

:FileListSet
CLS

set /p FileList=Enter desired 'File.Lst' to process: 

if exist "%FileList%" (
    echo File "%FileList%" found.
    echo List to process locked to "%FileList%"
    goto :SourceSet
) else (
    echo File "%FileList%" not found. Exiting.
    timeout 3
    exit /b 2  REM Use /b to avoid closing the command prompt window.
)

REM ============================
REM Step 2: Set Source Folder
REM ============================

:SourceSet
CLS

set "Source=C:\Games\Kerbal Space Program\KSPwin64-1.9.1"
echo Source Folder currently set to "%Source%"

if exist "%Source%" (
    echo Source Folder "%Source%" found.
    timeout 3
    goto :TargetSet
) else (
    echo Source Folder "%Source%" not found. Exiting.
    timeout 3
    exit /b 2
)

REM ============================
REM Step 3: Set Target Folder
REM ============================

:TargetSet
CLS

REM Automatically set Target folder based on FileList name.
set "Target=C:\Games\Kerbal Space Program\KSPwin64-1.9.1 [DnD]\RemovedFiles\%FileList:~0,-4%"
echo Target Folder currently set to "%Target%"

if not exist "%Target%" (
    md "%Target%"  REM Create target folder if it doesn't exist.
)

echo Target Folder set to "%Target%"
pause

REM ============================
REM Step 4: Process File List
REM ============================

:Process
FOR /F "delims=" %%a in ('type "%FileList%"') do (
    if exist "%Source%\%%a" (
        move "%Source%\%%a" "%Target%"
        echo Moved file: %%a
    ) else (
        echo File not found in source: %%a
    )
)

echo File move complete.
timeout 5
goto :Bye

REM ============================
REM Exit and Final Message
REM ============================

:Bye
CLS
echo Process complete.
echo Press any key to close this window.
pause > nul
exit /b 0
