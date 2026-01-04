@echo off
chcp 936 >nul 2>&1
set "PYTHONIOENCODING=gbk"

set "scriptdir=%~dp0"
pushd "%scriptdir%" || exit /b 1

for %%I in ("..\server\read_config") do set "READ_CONFIG_DIR=%%~fI"
if not exist "%READ_CONFIG_DIR%" mkdir "%READ_CONFIG_DIR%"

for %%I in ("..\client\config") do set "CLIENT_CONFIG_DIR=%%~fI"
if not exist "%CLIENT_CONFIG_DIR%" mkdir "%CLIENT_CONFIG_DIR%"

echo Exporting Excel files to %CLIENT_CONFIG_DIR%...

for /f "delims=" %%a in ('dir /b /a-d "excel\*.xlsx" 2^>nul ^| findstr /v /c:"~$"') do (
  python export_file.py -r ./excel/%%a -f l -t "%READ_CONFIG_DIR%" -o s
  python export_file.py -r ./excel/%%a -f j -t "%CLIENT_CONFIG_DIR%" -o c
)

echo Export completed.
popd
pause

