@echo off

::quit if we are not an admin
net session >nul 2>&1
if NOT %errorLevel% == 0 (
    echo ERROR: Please run this script as admin.
    pause
    exit
)

::turn off particularly annoying Windows settings


::Disable Hybernation
powercfg.exe /hibernate off

::disable UAC
reg.exe ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 0 /f

::show file extensions
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /v HideFileExt /t REG_DWORD /d 0 /f

::show hidden files
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /v Hidden /t REG_DWORD /d 1 /f

::show all icons in notification area tray 
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer /v EnableAutoTray /t REG_DWORD /d 0 /f

::always show "Open CMD Here" option to context menus
reg delete HKEY_CLASSES_ROOT\Directory\shell\cmd /v Extended /f
reg delete HKEY_CLASSES_ROOT\Drive\shell\cmd /v Extended /f
reg delete HKEY_CLASSES_ROOT\Directory\Background\shell\cmd /v Extended /f

::disable useless windows features
Dism /online /disable-feature /NoRestart /FeatureName:"InboxGames"
Dism /online /disable-feature /NoRestart /FeatureName:"MediaPlayback"
Dism /online /disable-feature /NoRestart /FeatureName:"TabletPCOC"
Dism /online /disable-feature /NoRestart /FeatureName:"Printing-Foundation-InternetPrinting-Client"
Dism /online /disable-feature /NoRestart /FeatureName:"FaxServicesClientPackage"
Dism /online /disable-feature /NoRestart /FeatureName:"Xps-Foundation-Xps-Viewer"
Dism /online /disable-feature /NoRestart /FeatureName:"Printing-XPSServices-Features"
Dism /online /disable-feature /NoRestart /FeatureName:"WindowsGadgetPlatform"

::remove Internet Explorer
Dism /online /disable-feature /NoRestart /FeatureName:"Internet-Explorer-Optional-amd64"
Dism /online /disable-feature /NoRestart /FeatureName:"Internet-Explorer-Optional-x86"
Dism /online /disable-feature /NoRestart /FeatureName:"Internet-Explorer-Optional-ia64"
::start /w ocsetup Internet-Explorer-Optional-x86 /uninstall

::Disable Windows Defender
sc stop windefend
sc delete windefend

::Disable "Scan and Fix" for thumb drives
sc stop ShellHWDetection
sc delete ShellHWDetection

::Disable Open File Security Warnings
reg add "HKLM\SOFTWARE\Policies\Microsoft\Internet Explorer\Security" /v DisableSecuritySettingsCheck /t REG_DWORD /d 1 /f

::Disable "Enhance Pointer Precision" to disable mouse accelleration in games
reg add "HKCU\Control Panel\Mouse" /v MouseSpeed /t REG_SZ /d 0 /f
reg add "HKCU\Control Panel\Mouse" /v MouseThreshhold1 /t REG_SZ /d 0 /f
reg add "HKCU\Control Panel\Mouse" /v MouseThreshhold2 /t REG_SZ /d 0 /f

::Install Chocolatey
@powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin

::Use Chocolatey to install software
cinst -y googlechrome geforce-experience steam discord battle.net dropbox teamspeak keepass keepass-keepasshttp googledrive thunderbird vcredist2005 linkshellextension greenshot 7zip.install libreoffice vlc transmission-qt gvim atom audacity putty conemu clover gpmdp gimp ccleaner

::restart
echo The computer will restart when you press a key

pause

shutdown -r -t 5