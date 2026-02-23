@echo off
echo Stopping Print Spooler...
net stop spooler
timeout /t 3

echo Deleting all print jobs...
del %systemroot%\System32\spool\PRINTERS\* /Q
timeout /t 2

echo Restarting Print Spooler...
net start spooler
echo Print Spooler restarted successfully.

echo Done!
pause