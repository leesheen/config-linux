#!/bin/bash

adb disconnect $1
adb connect $1
sleep 1
adb root
sleep 1
adb connect $1
adb shell
