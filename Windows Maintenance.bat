@echo Compiled by XionKzn.
@echo Updated on 10/11/2026
@echo For the latest version, please visit https://github.com/XionKzn/PiHole-Lists
@echo This tool is meant to help resolve common Windows 10 and Windows 11 system issues and install essential apps from the Microsoft Store as well as update any supported and outdated software.
@echo This tool also does a CHKDSK of all the disks as well as schedule a full offline scan of C:.
@echo This tool also Optimises drives and cleans Windows temporary files.
@echo This tool also force updates the Group Policy (effective after restart).
@echo This tool also shows the status of Windows Memory Compression, and then enables it.
@echo Please send an email with suggestions or complaints to lapped-chomp-timid@duck.com
@echo For the latest version of this file: https://github.com/XionKzn/PiHole-Lists/Windows Maintenance.bat
@echo Please run this tool as Administrator.
@echo Triggers Windows Update checks.
@echo Launches Microsoft Store updates.
@echo Comment out any command you do not want to run.
@echo off
TIMEOUT /T 10
sc config wuauserv start= demand
sc config LicenseManager start= demand
sc config wlidsvc start= demand
sc config bits start= demand

ipconfig /flushdns

@echo Restoring Windows Auto-Tuning feature to default (normal)
netsh int tcp set global autotuninglevel=normal

@echo off
@echo Cleaning system and user temp files...
powershell -NoProfile -Command "Get-ChildItem -LiteralPath $env:TEMP -Force -ErrorAction SilentlyContinue | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue"
powershell -NoProfile -Command "Get-ChildItem -LiteralPath 'C:\Windows\Temp' -Force -ErrorAction SilentlyContinue | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue"
@echo Temporary files cleared!

chkdsk C: /Scan

Dism /Online /Cleanup-Image /RestoreHealth
Dism /Online /Cleanup-Image /StartComponentCleanup
sfc /Scannow

@echo ::  Install MPEG-2 Video Extension
winget install 9n95q1zzpmh4 --exact --source msstore --accept-source-agreements --accept-package-agreements
@echo ::  Install HEVC Video Extensions
winget install 9nmzlz57r3t7 --exact --source msstore --accept-source-agreements --accept-package-agreements
@echo ::  Install AV1 Video Extension
winget install 9mvzqvxjbq9v --exact --source msstore --accept-source-agreements --accept-package-agreements
@echo ::  Install Web Media Extensions
winget install 9n5tdp8vcmhs --exact --source msstore --accept-source-agreements --accept-package-agreements
@echo ::  Install Raw Image Extension
winget install 9nctdw2w1bh8 --exact --source msstore --accept-source-agreements --accept-package-agreements
@echo ::  Install HEIF Image Extensions
winget install 9pmmsr1cgpwg --exact --source msstore --accept-source-agreements --accept-package-agreements
@echo ::  Install VP9 Video Extensions
winget install 9n4d0msmp0pt --exact --source msstore --accept-source-agreements --accept-package-agreements
@echo ::  Install Webp Image Extensions
winget install 9pg2dk419drg --exact --source msstore --accept-source-agreements --accept-package-agreements
@echo ::  Install OpenCL™, OpenGL®, and Vulkan® Compatibility Pack
winget install 9nqpsl29bfff --exact --source msstore --accept-source-agreements --accept-package-agreements
@echo ::  Install Windows Terminal
winget install 9n0dx20hk701 --exact --source msstore --accept-source-agreements --accept-package-agreements
@echo :: Installing or upgrading Bitwarden
winget install --id 9pjsdv0vpk04 --exact --source msstore --accept-source-agreements --accept-package-agreements
@echo ::  Install Mozilla Firefox
winget install 9nzvdkpmr9rd --exact --source msstore --accept-source-agreements --accept-package-agreements
winget upgrade --accept-package-agreements --accept-source-agreements --all --include-unknown --force

gpupdate /Force

chkdsk A: /Scan
chkdsk A: /Offlinescanandfix
chkdsk B: /Scan
chkdsk B: /Offlinescanandfix
chkdsk C: /Scan
chkdsk C: /Offlinescanandfix
chkdsk C: /R /V
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
powershell -NoProfile -Command "Get-ChildItem -LiteralPath $env:TEMP -Force -ErrorAction SilentlyContinue | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue"
powershell -NoProfile -Command "Get-ChildItem -LiteralPath 'C:\Windows\Temp' -Force -ErrorAction SilentlyContinue | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue"

@echo Temporary files cleared!

defrag /c /o

@echo :: Checking status of Windows Memory Compression via PowerShell
powershell -NoProfile -Command "Get-MMAgent"

@echo :: Enabling Memory Compression via PowerShell
powershell -NoProfile -Command "Enable-MMAgent -mc"

@echo :: Checking status of Windows Memory Compression via PowerShell
powershell -NoProfile -Command "Get-MMAgent"


@echo :: Triggering Windows Update check. 
UsoClient StartInteractiveScan
UsoClient StartScan
@echo off
TIMEOUT /T 30

@echo :: Install package for more automated Windows Update.
@echo :: Select Y when prompted or N to skip.
powershell -NoProfile -Command "Install-Module PSWindowsUpdate -Force; Import-Module PSWindowsUpdate; Get-WindowsUpdate -AcceptAll -Install"
@echo off

@echo :: Opening Microsoft Store CLI (you may install/update apps here if desired, if not; it's safe to close)
store updates

ipconfig /flushdns
netsh winsock reset
:: netsh int ip reset

@echo You should reboot your computer now.
pause
