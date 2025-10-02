@echo off
chcp 65001 >nul
title 删除 Debugger 值

:: 如果无管理员权限则自提权
fltmc >nul 2>&1 || (
    powershell -NoP -Command "Start-Process -FilePath '%ComSpec%' -ArgumentList '/c \"%~f0\"' -Verb RunAs"
    exit /b
)

:: 真正删除 Debugger 值
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\minigameapp.exe" /v Debugger /f >nul 2>&1
if %errorlevel%==0 (
    powershell -Command "Add-Type -AssemblyName PresentationFramework;[System.Windows.MessageBox]::Show('Debugger 值已成功删除！')"
) else (
    powershell -Command "Add-Type -AssemblyName PresentationFramework;[System.Windows.MessageBox]::Show('Debugger 值不存在或删除失败。')"
)