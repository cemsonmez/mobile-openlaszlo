#!/bin/bash

# This is the bash script that you can use, in order to set up the path of Android sdk, 
# start the Android emulator and install an .apk (Android package).
# Note: you have to be root on shell in order to use "setup" option!
# script assumes that you have created avd (Android Virtual Devices) named "avd2.2"

STARTING_MESSAGE="Starting Android bash script..."
echo $STARTING_MESSAGE
command=$1
parameter=$2
start="start"
install="install"
setup="setup"
#echo "Choice : "$command

bashtrap()
{
    echo "CTRL+C Detected !...stopping emulator process!"
}
if [ $command = $start ]; then
    echo "Starting Android emulator..."
    emulator -avd avd2.2
elif [ $command = $install ]; then
    if [$parameter = ""]; then
        echo $'[ERROR] : .apk path is missed\n(example: ./android.sh install path_to_apk/mpapp.apk) ***Be sure that the emulator is running!***'
    else
        echo "Installing apk package..."
        adb install $parameter
    fi
elif [ $command = $setup ]; then
    echo $'Type Android sdk path on the filesystem please\n(example: /usr/local/android-sdk-linux_86/)'
    read android_path
    ln -s "$android_path/tools/emulator" /usr/local/bin/emulator
    ln -s "$android_path/tools/adb" /usr/local/bin/adb
    echo "[INFO] : Setup succeeded. Now you can use the script for starting or installing an .apk package for the emulator"
else
    echo $'[ERROR] : Unsupported option\n***USAGE***';
    echo "Setup android -> './android.sh setup'"
    echo "Start emulator -> './android.sh start'"
    echo "Install an apk package -> './android.sh install path_to_apk/mpapp.apk' "    
fi