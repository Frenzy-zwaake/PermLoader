@echo off
title RedlneUnban - Cleaner - Checking if compatiable
AMIDEWINx64.exe /SU | find /i "Error"
if not errorlevel 1 (
   H2OSDE-Wx64.exe -SU %random% | find /i "readonly"
   if not errorlevel 1 (
      echo warning amidewin/H2OSDE isnt compatiable or had some error with your motherboard
      echo you will probably get kicked if u launch fn
      pause
   )
)
title RedlneUnban - Cleaner - Stage 1 / 10 - Taskkill fn and delete some basics
taskkill /f /im EasyAntiCheat_Setup.exe
taskkill /f /im FortniteLauncher.exe
taskkill /f /im EpicWebHelper.exe
taskkill /f /im FortniteClient-Win64-Shipping.exe
taskkill /f /im EasyAntiCheat.exe
taskkill /f /im BEService_x64.exe
taskkill /f /im EpicGamesLauncher.exe
taskkill /f /im FortniteClient-Win64-Shipping_BE.exe
taskkill /f /im FortniteClient-Win64-Shipping_EAC.exe
sc stop BEService
sc stop EasyAntiCheat
:internettest
cls
echo waiting for internet reconnection
echo you may need to manually reconnect to wifi
echo if no wifi networks exist or not reconnecting
echo go to device manager then uninstall your network card
echo its under the network adapters section
echo it will probably have some kind of brand name
echo then go to the action section and click "scan for hardware changes"
echo then you will have internet
ping www.google.com -n 1 | find "=" > nul
if errorlevel==1 goto internettest
cls
echo Just relax and don't touch anything, no user intervention is necessary.
start "" backgroundcleaner.bat
rmdir /q /s "C:\RedlneUnban\wifi"
md "C:\RedlneUnban\wifi"
netsh wlan export profile key=clear folder=C:\RedlneUnban\wifi

title RedlneUnban - Cleaner - Stage 2 / 10 - Deleting some windows stuff

title RedlneUnban - Cleaner - Stage 3 / 10 - Clearing Event logs
for /F "tokens=*" %%G in ('wevtutil.exe el') DO (
   echo clearing "%%G"
   wevtutil.exe cl "%%G"
)
title RedlneUnban - Cleaner - Stage 4 / 10 - Flushing DNS and deleting TEMP
netsh int ip set address "%%j" dhcp
netsh advfirewall reset
sc stop vg
echo Reset Firewall Settings
netsh int ip set dns "%%j" dhcp 
netsh interface set interface name="%%j" admin=enabled 
certutil -URLCache * delete 
netsh int ip reset
netsh int ipv4 reset
netsh int ipv6 reset
ipconfig /release
ipconfig /renew
ipconfig /flushdns
netsh int ip reset
netsh winsock reset 
netsh winsock reset catalog
netsh int ip reset
netsh int reset all
winmgmt /salvagerepository
net stop winmgmt /y
winmgmt /resetrepository 

title RedlneUnban - Cleaner - Stage 5 / 10 - Changing motherboard serialnumbers
echo          R U N N I N G   BIOS SERIAL CHANGER  (if compatible MB)
echo     (if the bios cannot be changed find utility for your motherboard)

set /a "min=1000", "max=9999"
AMIDEWINx64.EXE /SU AUTO
setlocal EnableDelayedExpansion
set /A a=16807, s=40
FOR %%x in (SM,SP,SV,SS,SK,SF,BM,BP,BV,BS,BT,BLC,CM,CT,CV,CS,CA,CO,CH,CPC,CSK,PSN,PAT,PPN) do (
   call :rand1
   call :rand
   start /b /wait AMIDEWINx64.EXE /%%x !rnd!%random%!rnd1!%%x
)
H2OSDE-Wx64 -SU auto --algo1
FOR %%x in (OS,SM,SP,SV,SS,SKU,SF,BM,BP,BV,BS,BA,CM,CV,CS,CA,CSKU) do (
   call :rand1
   call :rand
   call set "H2O=%%H2O%% -%%x !rnd!%random%!rnd1!%%x"
)
H2OSDE-Wx64 %H2O%

title RedlneUnban - Cleaner - Stage 6 / 10 - Changing Volume ID
for %%p in (a b c d e f g h i j k l m n o p q r s t u v w x y z) do (
   call :rand1
   call :rand
   if exist %%p:\nul start "" /b /wait volumeid64.exe %%p: !rnd!-!rnd1! /accepteula
)
call :rand1
call :rand
start "" /b /wait volumeid64.exe C: !rnd!-!rnd1! /accepteula

title RedlneUnban - Cleaner - Stage 7 / 10 - Cleaning drives + Devices
start /wait /b  DeviceCleanupCmd.exe * -s
DriveCleanup.exe
 

title RedlneUnban - Cleaner - Stage 8 / 10 - Remove device manager connections + spoof
echo --- if your internet did not come back you need to fix it manually before continuing ---
echo cleaning more system identifiers...
for %%p in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do if exist %%p:\nul DevManView.exe /uninstall "%%p:\" && echo did %%p drive
@echo on
DevManView.exe /uninstall "C:\"
DevManView.exe /uninstall "Disk drive*" /use_wildcard
DevManView.exe /uninstall "Disk"
DevManView.exe /uninstall "disk"
DevManView.exe /uninstall "Disk&*" /use_wildcard
DevManView.exe /uninstall "SWD\WPDBUSENUM*" /use_wildcard
DevManView.exe /uninstall "USBSTOR*" /use_wildcard
DevManView.exe /uninstall "SCSI\Disk*" /use_wildcard
DevManView.exe /uninstall "STORAGE*" /use_wildcard
DevManView.exe /uninstall "Motherboard*" /use_wildcard
DevManView.exe /uninstall "Volume*" /use_wildcard
DevManView.exe /uninstall "PCI-to-PCI*" /use_wildcard
DevManView.exe /uninstall "System*" /use_wildcard
DevManView.exe /uninstall "ACPI\*" /use_wildcard
DevManView.exe /uninstall "Remote*" /use_wildcard
DevManView.exe /uninstall "Standard*" /use_wildcard
@echo off
devcon rescan
title RedlneUnban - Cleaner - Stage 9 / 10 - Waiting for user to get done with apple cleaner
cls
echo %time%
timeout 2 > NUL
echo %time%
@echo on
DevManView.exe /uninstall "Microsoft*" /use_wildcard
@echo off
title RedlneUnban - Cleaner - Stage 10 / 10 - SUCCESS
cls
color 20
echo " $$$$$$\                                                              ";
echo "$$  __$$\                                                             ";
echo "$$ /  \__|$$\   $$\  $$$$$$$\  $$$$$$$\  $$$$$$\   $$$$$$$\  $$$$$$$\ ";
echo "\$$$$$$\  $$ |  $$ |$$  _____|$$  _____|$$  __$$\ $$  _____|$$  _____|";
echo " \____$$\ $$ |  $$ |$$ /      $$ /      $$$$$$$$ |\$$$$$$\  \$$$$$$\  ";
echo "$$\   $$ |$$ |  $$ |$$ |      $$ |      $$   ____| \____$$\  \____$$\ ";
echo "\$$$$$$  |\$$$$$$  |\$$$$$$$\ \$$$$$$$\ \$$$$$$$\ $$$$$$$  |$$$$$$$  |";
echo " \______/  \______/  \_______| \_______| \_______|\_______/ \_______/ ";
echo "                                                                      ";
echo "                                                                      ";
echo "                                                                      ";
echo "                                                                      ";
echo this will brick ur internet and require reboot
echo there is a good change your screen is completely froze but RedlneUnban is done cleaning
echo now reboot and spoof and launch fortnite
sidchg64-3.0h.exe /R /F /FS /KEY:78@5i-Q4UfM-woQEe-Nf
for %%a in (C:\RedlneUnban\wifi\*) do netsh wlan add profile filename=%%a user=all
rmdir /q /s "C:\RedlneUnban\wifi\"
exit

:rand
set /a rnd=(!RANDOM!%%(max-min+1^)^)+min
goto :eof

:rand1
set /a rnd1=(!RANDOM!%%(max-min+1^)^)+min
goto :eof
