@echo off
echo Uninstalling SQL Server Management Studio 2014...

:: Get the uninstall string from the registry
for /f "usebackq tokens=1,2,*" %%a in (`reg query HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall /s /f "SQL Server Management Studio"`) do (
    if "%%a"=="DisplayName" (
        if "%%c"=="Microsoft SQL Server Management Studio 2014" (
            set uninstall_key=%%b
        )
    )
)

if not defined uninstall_key (
    echo SQL Server Management Studio 2014 not found on this system.
    exit /b 1
)

:: Extract uninstall string
for /f "tokens=2,*" %%a in ('reg query "%uninstall_key%" /v "UninstallString"') do set uninstall_string=%%b

:: Uninstall SQL Server Management Studio 2014
echo Uninstalling...
start "" /wait "%uninstall_string%" /uninstall /quiet /norestart

if %errorlevel% equ 0 (
    echo Uninstallation successful!
    exit /b 0
) else (
    echo Uninstallation failed with error code %errorlevel%.
    exit /b %errorlevel%
)

:: run cmd prompt with administrator privileges
