@echo Compiled by XionKzn.
@echo Updated on 27/10/2025
@echo This tool is meant to help resolve common Windows 10 and Windows 11 system issues and install essential apps from the Microsoft Store as well as update any supported and outdated software.
@echo This tool also does a CHKDSK of all the disks as well as schedule a full offline scan of C:.
@echo This tool also uses TRIM command for SSD's and cleans Windows temporary files.
@echo This tool also force updates the Group Policy (effective after restart).
@echo This tool also shows the status of Windows Memory Compression, and then enables it.
@echo Please send an email with suggestions or complaints to lapped-chomp-timid@duck.com
@echo Please run this tool as Administrator.
@echo Comment out any command you do not want to run.
@echo off
TIMEOUT /T 10
sc config wuauserv start= demand
sc config LicenseManager start= demand
sc config wlidsvc start= demand
sc config bits start= demand
ipconfig /flushdns
netsh winsock reset
netsh int tcp set global autotuninglevel=normal

@echo off
echo Cleaning system and user temp files...
del /s /f /q %TEMP%\*.* >nul 2>&1
rd /s /q %TEMP% >nul 2>&1
md %TEMP%

del /s /f /q C:\Windows\Temp\*.* >nul 2>&1
rd /s /q C:\Windows\Temp >nul 2>&1
md C:\Windows\Temp

echo Temporary files cleared!

sfc /Scannow
DISM.exe /Online /Cleanup-image /Scanhealth 
Dism /Online /Cleanup-Image /RestoreHealth
Dism /Online /Cleanup-Image /StartComponentCleanup
Dism /Online /Cleanup-Image /StartComponentCleanup /ResetBase
Dism /Online /Cleanup-Image /RestoreHealth
winget upgrade --accept-package-agreements --accept-source-agreements --all
@echo ::  Install MPEG-2 Video Extension
winget install 9n95q1zzpmh4 --accept-source-agreements --accept-package-agreements
@echo ::  Install HEVC Video Extensions
winget install 9nmzlz57r3t7 --accept-source-agreements --accept-package-agreements
@echo ::  Install AV1 Video Extension
winget install 9mvzqvxjbq9v --accept-source-agreements --accept-package-agreements
@echo ::  Install Web Media Extensions
winget install 9n5tdp8vcmhs --accept-source-agreements --accept-package-agreements
@echo ::  Install Raw Image Extension
winget install 9nctdw2w1bh8 --accept-source-agreements --accept-package-agreements
@echo ::  Install HEIF Image Extensions
winget install 9pmmsr1cgpwg --accept-source-agreements --accept-package-agreements
@echo ::  Install VP9 Video Extensions
winget install 9n4d0msmp0pt --accept-source-agreements --accept-package-agreements
@echo ::  Install Webp Image Extensions
winget install 9pg2dk419drg --accept-source-agreements --accept-package-agreements
@echo ::  Install OpenCL™, OpenGL®, and Vulkan® Compatibility Pack
winget install 9nqpsl29bfff --accept-source-agreements --accept-package-agreements
@echo ::  Install Windows Terminal
winget install 9n0dx20hk701 --accept-source-agreements --accept-package-agreements
@echo ::  Install Microsoft Defender
winget install 9p6pmztm93lr --accept-source-agreements --accept-package-agreements
@echo ::  Install Bitwarden
winget install 9pjsdv0vpk04 --accept-source-agreements --accept-package-agreements
@echo ::  Install Mozilla Firefox
winget install 9nzvdkpmr9rd --accept-source-agreements --accept-package-agreements
ipconfig /flushdns
netsh winsock reset
sfc /Scannow
gpupdate /Force
DISM.exe /Online /Cleanup-image /Scanhealth
Dism /Online /Cleanup-Image /StartComponentCleanup
Dism /Online /Cleanup-Image /StartComponentCleanup /ResetBase
Dism /Online /Cleanup-Image /RestoreHealth
ipconfig /flushdns
netsh winsock reset
sfc /Scannow
chkdsk A: /Scan
chkdsk A: /Offlinescanandfix
chkdsk B: /Scan
chkdsk B: /Offlinescanandfix
chkdsk C: /Scan
chkdsk C: /Offlinescanandfix
chkdsk C: /R /F /V
chkdsk D: /Scan
chkdsk D: /Offlinescanandfix
chkdsk E: /Scan
chkdsk E: /Offlinescanandfix
chkdsk F: /Scan
chkdsk F: /Offlinescanandfix
chkdsk G: /Scan
chkdsk G: /Offlinescanandfix
chkdsk H: /Scan
chkdsk H: /Offlinescanandfix
chkdsk I: /Scan
chkdsk I: /Offlinescanandfix
chkdsk J: /Scan
chkdsk J: /Offlinescanandfix
chkdsk K: /Scan
chkdsk K: /Offlinescanandfix
chkdsk L: /Scan
chkdsk L: /Offlinescanandfix
chkdsk M: /Scan
chkdsk M: /Offlinescanandfix
chkdsk N: /Scan
chkdsk N: /Offlinescanandfix
chkdsk O: /Scan
chkdsk O: /Offlinescanandfix
chkdsk P: /Scan
chkdsk P: /Offlinescanandfix
chkdsk Q: /Scan
chkdsk Q: /Offlinescanandfix
chkdsk R: /Scan
chkdsk R: /Offlinescanandfix
chkdsk S: /Scan
chkdsk S: /Offlinescanandfix
chkdsk T: /Scan
chkdsk T: /Offlinescanandfix
chkdsk U: /Scan
chkdsk U: /Offlinescanandfix
chkdsk V: /Scan
chkdsk V: /Offlinescanandfix
chkdsk W: /Scan
chkdsk W: /Offlinescanandfix
chkdsk X: /Scan
chkdsk X: /Offlinescanandfix
chkdsk Y: /Scan
chkdsk Y: /Offlinescanandfix
chkdsk Z: /Scan
chkdsk Z: /Offlinescanandfix

@echo off
echo Cleaning system and user temp files...
del /s /f /q %TEMP%\*.* >nul 2>&1
rd /s /q %TEMP% >nul 2>&1
md %TEMP%

del /s /f /q C:\Windows\Temp\*.* >nul 2>&1
rd /s /q C:\Windows\Temp >nul 2>&1
md C:\Windows\Temp

echo Temporary files cleared!

defrag /AllVolumes /BootOptimize /Optimize

@echo :: Checking status of Windows Memory Compression via PowerShell
powershell -NoProfile -Command "Get-MMAgent"

@echo :: Enabling Memory Compression via PowerShell
powershell -NoProfile -Command "Enable-MMAgent -mc"

pause


