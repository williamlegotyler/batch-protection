@echo off
title batch protection v0.3
setlocal enabledelayedexpansion

echo. > hashes.txt
echo welcome to batch protector v0.3!
echo.

set /p folderpath=Insert the folder path to scan:

for /r %folderPath% %%f in (*) do (
    certutil -hashfile "%%f" SHA256 >> hashes.txt
    echo.
)
timeout 4

set "filePath=%userprofile%\desktop\hashes.txt"
set "virusFound=false"
set "virusCount=0"

for /f %%a in (malwarehashes.txt) do (
    for /f %%b in (%filePath%) do (
        if "%%a"=="%%b" (
            echo Virus found in %folderpath%!
            set /a virusCount+=1
            set "virusFound=true"
        )
    )
)

:endloop

if %virusFound% == true (
    echo %virusCount% viruses found.
) else (
    echo No viruses found.
)

pause