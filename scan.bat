@echo off

setlocal enabledelayedexpansion

echo.
echo welcome to batch protector v0.1!

set /p folderpath=insert the folder path to scan

for /r %folderPath% %%f in (*) do (
    certutil -hashfile "%%f" SHA256 >> hashes.txt
    echo.
)
timeout 5

set "filePath=%userprofile%\desktop\hashes.txt"
set "virusFound=false"

for /f %%a in (malwarehashes.txt) do (
    for /f %%b in (%filePath%) do (
        if "%%a"=="%%b" (
            echo Virus found in %%f!
            set "virusFound=true"
            goto :endloop
        )
    )
)

:endloop

if not %virusFound% == true (
    echo No virus found.
)

pause