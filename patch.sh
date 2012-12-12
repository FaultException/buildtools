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

echo "### vold: mount sdcard with UID root"
repo start auto system/vold
pushd system/vold
git fetch http://review.cyanogenmod.org/CyanogenMod/android_system_vold refs/changes/49/26849/2 && git cherry-pick FETCH_HEAD   
popd

echo "### Camera: Allow a device to request the focus modes at build time"
repo start auto packages/apps/Camera
pushd packages/apps/Camera
git fetch http://review.cyanogenmod.org/CyanogenMod/android_packages_apps_Camera refs/changes/96/27996/2 && git cherry-pick FETCH_HEAD
popd

echo "### Clock: fix layout for 320dp devices"
repo start auto packages/apps/DeskClock
pushd packages/apps/DeskClock
git fetch http://review.cyanogenmod.org/CyanogenMod/android_packages_apps_DeskClock refs/changes/01/28001/3 && git cherry-pick FETCH_HEAD
popd

echo "### build: Update domain name"
repo start auto build
pushd build
git fetch http://review.cyanogenmod.org/CyanogenMod/android_build refs/changes/58/28058/1 && git cherry-pick FETCH_HEAD
popd

echo "### Set ANDROID_PROPERTY_WORKSPACE in exec."
repo start auto system/core
pushd system/core
git fetch http://review.cyanogenmod.org/CyanogenMod/android_system_core refs/changes/61/28061/1 && git cherry-pick FETCH_HEAD
popd
