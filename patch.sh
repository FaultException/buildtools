#!/bin/bash
#
# Build tools to automatically apply patches to my
# CM9 folder on the epic build server.
#
# Based on EpicCM/epictools
#

repo abandon auto

# Patches

# Example:
#
# echo "### <review title>"
# repo start auto device/samsung/aries-common
# cd device/samsung/aries-common
# <cherry-pick-line>
# cd ../../..

echo "### aries-common: Jellybean 4.2 bring up"
repo start auto device/samsung/aries-common
pushd device/samsung/aries-common
git fetch http://review.cyanogenmod.org/CyanogenMod/android_device_samsung_aries-common refs/changes/54/26954/5 && git cherry-pick FETCH_HEAD
popd

echo "### bcmdhd: Enable ad-hoc networks"
repo start auto kernel/samsung/tuna
pushd kernel/samsung/tuna
git fetch http://review.cyanogenmod.org/CyanogenMod/android_kernel_samsung_tuna refs/changes/80/16280/1 && git cherry-pick FETCH_HEAD
popd

echo "### vold: mount sdcard with UID root"
repo start auto system/vold
pushd system/vold
git fetch http://review.cyanogenmod.org/CyanogenMod/android_system_vold refs/changes/49/26849/2 && git cherry-pick FETCH_HEAD   
popd

echo "### Camera: Allow a device to request the focus modes at build time"
repo start auto packages/apps/Camera
pushd packages/apps/Camera
git fetch http://review.cyanogenmod.org/CyanogenMod/android_packages_apps_Camera refs/changes/96/27996/1 && git cherry-pick FETCH_HEAD
popd

echo "### Clock: fix layout for 320dp devices"
repo start auto packages/apps/DeskClock
pushd packages/apps/DeskClock
git fetch http://review.cyanogenmod.org/CyanogenMod/android_packages_apps_DeskClock refs/changes/01/28001/3 && git cherry-pick FETCH_HEAD
popd
