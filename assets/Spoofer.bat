@echo off
title Redline Unban - Spoofer (EAC)
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
cd "%~dp0"
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

DevManView.exe /uninstall "SWD\MS*" /use_wildcard

start /wait /b  DeviceCleanupCmd.exe * -s
DriveCleanup.exe
echo just wait... 
del "C:\Users\%username%\AppData\Local\Temp.*"
mkdir "C:\Windows\temp"
mkdir "C:\Users\%username%\AppData\Local\Temp"
set try=1

echo usually this takes 1-4 tries
:retry
echo attempting spoof try#%try%
set /A try=%try%+1
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
DevManView.exe /uninstall "Microsoft*" /use_wildcard
DevManView.exe /uninstall "System*" /use_wildcard
DevManView.exe /uninstall "ACPI\*" /use_wildcard
DevManView.exe /uninstall "Remote*" /use_wildcard
DevManView.exe /uninstall "Standard*" /use_wildcard
AMIDEWINx64.EXE /SU AUTO 

AMIDEWINx64.EXE /BS %RaNdOm%%RaNdOm%%RaNdOm%%RaNdOm%

AMIDEWINx64.EXE /CS %RaNdOm%%RaNdOm%%RaNdOm%%RaNdOm%

AMIDEWINx64.EXE /SS %RaNdOm%%RaNdOm%%RaNdOm%%RaNdOm%

AMIDEWINx64.EXE /PSN %RaNdOm%%RaNdOm%%RaNdOm%%RaNdOm%

AMIDEWINx64.EXE /IVN %RaNdOm%%RaNdOm%%RaNdOm%%RaNdOm%

AMIDEWINx64.EXE /IV %RaNdOm%%RaNdOm%%RaNdOm%%RaNdOm%
TASKKILL /F /IM WmiPrvSE.exe
TASKKILL /F /IM WmiPrvSE.exe

@echo off

echo wait....
PING localhost -n 15 >NUL


del output.txt /f1>nul 2>nul
wmic diskdrive get serialnumber >output.txt
for /f %%i in ("output.txt") do set size=%%~zi
if %size% gtr 6 goto retry

del output.txt /f1>nul 2>nul
devcon rescan
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
echo scanning for hardware changes
#devcon rescan
echo starting MAC changer
start "" /min "MAC_change.bat"
echo spoofed
exit