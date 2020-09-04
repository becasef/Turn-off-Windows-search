@echo off
if exist "%SystemRoot%\SysWOW64" path %path%;%windir%\SysNative;%SystemRoot%\SysWOW64;%~dp0
bcdedit >nul
if '%errorlevel%' NEQ '0' (goto UACPrompt) else (goto UACAdmin)
:UACPrompt
%1 start "" mshta vbscript:createobject("shell.application").shellexecute("""%~0""","::",,"runas",1)(window.close)&exit
exit /B
:UACAdmin
title 关闭服务
::停止服务
echo 正在停止WSearch服务
NET STOP "WSearch" >nul 2>nul
::服务禁止
echo 正在将WSearch服务设置为禁用
sc config "WSearch" start=  disabled >nul 2>nul
:jiance
::检测SearchIndexer服务是否在运行并判断是否终止,如果存在，转到kill，如果存在，转到unill
tasklist | find "SearchIndexer" > NUL && goto :kill
goto :unill
:kill
::如果上一步检测到正在运行就关闭SearchIndexer.exe以及相关的子进程
taskkill /f /im SearchIndexer.exe | find "成功" > NUL && goto :UACAdmin
::taskkill /f /t /im SearchIndexer.exe
goto :jiance
:unill
del /f /s /q C:\ProgramData\Microsoft\Search\Data\Applications\Windows\windows.edb >nul 2>nul
dism.exe /online /Disable-Feature /featurename:SearchEngine-Client-Package
cls
echo 所有命令操作成功！
pause>nul
