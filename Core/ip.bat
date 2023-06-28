FOR /F "tokens=2" %%G IN ('adb -s 4200349cce57438b shell ip addr show wlan0 ^|find "inet "') DO set ipfull=%%G
FOR /F "tokens=1 delims=/" %%G in ("%ipfull%") DO set ip=%%G
echo %ip%|clip