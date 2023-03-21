# iFit-Wolf2
Experimental iFit Workout Data Capture and Control

### Tested on the NordicTrack Commercial 2950 iFit Embedded Wifi Treadmill (2021 model)

Building on the initial iFit-Wolf repo and code at https://github.com/victorypoint/iFit-Wolf, this update includes ythe capability to control the treadmill speed and incline. Once again it should be noted, I've only tested this on the NT C2950 treadmill. See the noted repo above for technical details on how the treadmill records individual workouts to a local text log in a sequential streaming format. The NT C2950 treadmills embedded iFit console runs Android (currently v9 on my model). 

Building on the previous iFit-Wolf Windows VBscript code, which displays the real-time speed and inclination values, this update includes functions to control the treadmill...

The VBscript assumes an ADB connection has already been established with the treadmill, and proceeds to communicate ... 

I’ve not included documentation here on how to configure the NT C2950 treadmill for ADB communication, but it involves accessing the machines “Privileged Mode”, turning on “Developer Options” in Android settings, and enabling “USB Debugging” mode. Accessing Privileged Mode is well documented on many websites, dependent on the treadmill model, and version of Android and iFit.

Files included:
- adb-connect.bat (commands to initiate an ADB connection with the treadmill – change the IP to that of the treadmill)
- get-speed-incline.vbs (VBscript)
- cscript_get-speed-incline.bat (commands to launch VBscript in CScript window)
- Not included – ADB

ADB stands for Android Debug Bridge used by developers to connect their development computer with an Android device via a USB cable (and over Wifi in this case). If you don't have Android SDK installed on your PC, ADB may not be recognized. It's recommended you download the latest version.
