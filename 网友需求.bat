@echo off
if exist "%SystemRoot%\SysWOW64" path %path%;%windir%\SysNative;%SystemRoot%\SysWOW64;%~dp0
bcdedit >nul
if '%errorlevel%' NEQ '0' (goto UACPrompt) else (goto UACAdmin)
:UACPrompt
%1 start "" mshta vbscript:createobject("shell.application").shellexecute("""%~0""","::",,"runas",1)(window.close)&exit
exit /B
:UACAdmin
title �رշ���
::ֹͣ����
echo ����ֹͣWSearch����
NET STOP "WSearch" >nul 2>nul
::�����ֹ
echo ���ڽ�WSearch��������Ϊ����
sc config "WSearch" start=  disabled >nul 2>nul
:jiance
::���SearchIndexer�����Ƿ������в��ж��Ƿ���ֹ,������ڣ�ת��kill��������ڣ�ת��unill
tasklist | find "SearchIndexer" > NUL && goto :kill
goto :unill
:kill
::�����һ����⵽�������о͹ر�SearchIndexer.exe�Լ���ص��ӽ���
taskkill /f /im SearchIndexer.exe | find "�ɹ�" > NUL && goto :UACAdmin
::taskkill /f /t /im SearchIndexer.exe
goto :jiance
:unill
del /f /s /q C:\ProgramData\Microsoft\Search\Data\Applications\Windows\windows.edb >nul 2>nul
dism.exe /online /Disable-Feature /featurename:SearchEngine-Client-Package
cls
echo ������������ɹ���
pause>nul
