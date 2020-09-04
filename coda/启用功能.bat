@echo off
if exist "%SystemRoot%\SysWOW64" path %path%;%windir%\SysNative;%SystemRoot%\SysWOW64;%~dp0
bcdedit >nul
if '%errorlevel%' NEQ '0' (goto UACPrompt) else (goto UACAdmin)
:UACPrompt
%1 start "" mshta vbscript:createobject("shell.application").shellexecute("""%~0""","::",,"runas",1)(window.close)&exit
exit /B
:UACAdmin
dism.exe /online /Enable-Feature /featurename:SearchEngine-Client-Package
NET start "WSearch"
sc config "WSearch" start=  demand
pause
http://blog.sina.com.cn/s/blog_962c93040102z2es.html