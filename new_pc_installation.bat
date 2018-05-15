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
echo Disabling Hybernation...
powercfg.exe /hibernate off

::disable UAC
echo Disabling UAC...
reg.exe ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 0 /f

::show file extensions
echo Turning on Always Show File Extensions...
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /v HideFileExt /t REG_DWORD /d 0 /f

::show hidden files
echo Turning on Always Show Hidden Files...
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /v Hidden /t REG_DWORD /d 1 /f

::show all icons in notification area tray 
echo Turning on Show All Icons in Notification Area Tray...
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer /v EnableAutoTray /t REG_DWORD /d 0 /f

::always show "Open CMD Here" option to context menus
echo Adding "Open CMD Here" to context menus...
reg delete HKEY_CLASSES_ROOT\Directory\shell\cmd /v Extended /f
reg delete HKEY_CLASSES_ROOT\Drive\shell\cmd /v Extended /f
reg delete HKEY_CLASSES_ROOT\Directory\Background\shell\cmd /v Extended /f

::disable useless windows features
echo Disabling Windows Games...
Dism /online /disable-feature /NoRestart /quiet /FeatureName:"InboxGames"
echo Disabling Media Playback (media player, media center, etc)...
Dism /online /disable-feature /NoRestart /quiet /FeatureName:"MediaPlayback"
echo Disabling Tablet Feeatures...
Dism /online /disable-feature /NoRestart /quiet /FeatureName:"TabletPCOC"
echo Disabling Internet Printing Client...
Dism /online /disable-feature /NoRestart /quiet /FeatureName:"Printing-Foundation-InternetPrinting-Client"
echo Disabling Fax Services Client...
Dism /online /disable-feature /NoRestart /quiet /FeatureName:"FaxServicesClientPackage"
echo Disabling XPS Viewer and XPS Printing...
Dism /online /disable-feature /NoRestart /quiet /FeatureName:"Xps-Foundation-Xps-Viewer"
Dism /online /disable-feature /NoRestart /quiet /FeatureName:"Printing-XPSServices-Features"
echo Disabling Windows Gadget Platform...
Dism /online /disable-feature /NoRestart /quiet /FeatureName:"WindowsGadgetPlatform"

::remove Internet Explorer
echo Disabling Internet Explorer...
Dism /online /disable-feature /NoRestart /quiet /FeatureName:"Internet-Explorer-Optional-amd64"
Dism /online /disable-feature /NoRestart /quiet /FeatureName:"Internet-Explorer-Optional-x86"
Dism /online /disable-feature /NoRestart /quiet /FeatureName:"Internet-Explorer-Optional-ia64"
::start /w ocsetup Internet-Explorer-Optional-x86 /uninstall

::Disable Windows Defender
echo Disabling Windows Defender...
sc stop windefend
sc delete windefend

::Disable "Scan and Fix" for thumb drives
echo Disabling "Scan and Fix" for thumb drives...
sc stop ShellHWDetection
sc delete ShellHWDetection

::Disable Open File Security Warnings
echo Disabling Open File Security Warnings...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Internet Explorer\Security" /v DisableSecuritySettingsCheck /t REG_DWORD /d 1 /f

::Disable "Enhance Pointer Precision" to disable mouse accelleration in games
echo Turning off "Enhanced Pointer Precision"...
reg add "HKCU\Control Panel\Mouse" /v MouseSpeed /t REG_SZ /d 0 /f
reg add "HKCU\Control Panel\Mouse" /v MouseThreshhold1 /t REG_SZ /d 0 /f
reg add "HKCU\Control Panel\Mouse" /v MouseThreshhold2 /t REG_SZ /d 0 /f

::restart
echo The computer will restart when you press a key

pause

shutdown -r -t 5