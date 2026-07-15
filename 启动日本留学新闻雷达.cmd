@echo off
chcp 65001 >nul
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0运行新闻雷达.ps1" %*
exit /b %ERRORLEVEL%
