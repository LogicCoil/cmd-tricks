@echo off
title Privet Folder Locker
color 0A

:: Define the target folder name
set "FOLDER_NAME=privet"

:: 1. If the folder does not exist at all, create it
if not exist "%FOLDER_NAME%" (
    if not exist "Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}" (
        mkdir "%FOLDER_NAME%"
        echo [SUCCESS] Created folder '%FOLDER_NAME%'.
        echo Place your files inside '%FOLDER_NAME%' and run this script again to lock it.
        pause
        exit /b
    )
)

:: 2. If the locked state exists, prompt to unlock
if exist "Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}" goto UNLOCK

:: 3. If the unlocked folder exists, prompt to lock
if exist "%FOLDER_NAME%" goto CONFIRM

:CONFIRM
echo Are you sure you want to lock and hide '%FOLDER_NAME%'? (Y/N)
set /p "cho=> "
if /i "%cho%"=="Y" goto LOCK
if /i "%cho%"=="N" goto END
echo Invalid choice.
goto CONFIRM

:LOCK
:: Rename and apply deep hidden system attributes
ren "%FOLDER_NAME%" "Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}"
attrib +h +s "Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}"
echo.
echo [SUCCESS] Folder '%FOLDER_NAME%' is now hidden and locked!
pause
goto END

:UNLOCK
echo ====================================
echo      UNLOCK PRIVET FOLDER
echo ====================================
echo.
set /p "pass=Enter password to unlock: "

:: CHANGE "your_password_here" BELOW TO YOUR DESIRED PASSWORD
if NOT "%pass%"=="your_password_here" goto FAIL

:: Strip attributes and restore original folder name
attrib -h -s "Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}"
ren "Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}" "%FOLDER_NAME%"
echo.
echo [SUCCESS] Password correct! Folder '%FOLDER_NAME%' is now visible.
pause
goto END

:FAIL
echo.
echo [ERROR] Invalid password! Access denied.
pause
goto END

:END
