::Install Chocolatey
@powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin

::Use Chocolatey to install software
cinst -y googlechrome geforce-experience steam discord battle.net dropbox teamspeak keepass keepass-keepasshttp googledrive thunderbird vcredist2005 linkshellextension greenshot 7zip.install libreoffice vlc transmission-qt gvim atom audacity putty conemu clover gpmdp gimp ccleaner