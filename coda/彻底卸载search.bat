dism.exe /online /Disable-Feature /featurename:NetFX3
dism.exe /online /Get-Features
::值为SearchEngine-Client-Package


dism.exe /online /Disable-Feature /featurename:SearchEngine-Client-Package