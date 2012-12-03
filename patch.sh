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

echo "### PackageManager: fix app lib migration for device with /datadata"
repo start auto frameworks/base
pushd frameworks/base
git fetch http://review.cyanogenmod.org/CyanogenMod/android_frameworks_base refs/changes/59/26859/3 && git cherry-pick FETCH_HEAD
popd

echo "### Allow mounting of multiple volumes via mass storage (framework part)"
repo start auto frameworks/base
pushd frameworks/base
git fetch http://review.cyanogenmod.org/CyanogenMod/android_frameworks_base refs/changes/93/26893/4 && git cherry-pick FETCH_HEAD
popd

echo "### libbt: allow specifying custom config path"
repo start auto device/common
pushd device/common
git fetch http://review.cyanogenmod.org/CyanogenMod/android_device_common refs/changes/53/26953/2 && git cherry-pick FETCH_HEAD
popd

echo "### aries-common: Jellybean 4.2 bring up"
repo start auto device/samsung/aries-common
pushd device/samsung/aries-common
git fetch http://review.cyanogenmod.org/CyanogenMod/android_device_samsung_aries-common refs/changes/54/26954/5 && git cherry-pick FETCH_HEAD
popd

echo "### Trebuchet: remove workspace padding"
repo start auto packages/apps/Trebuchet
pushd packages/apps/Trebuchet
git fetch http://review.cyanogenmod.org/CyanogenMod/android_packages_apps_Trebuchet refs/changes/15/27015/1 && git cherry-pick FETCH_HEAD
popd

echo "### SamsungExynos3RIL: buffer CAT Proactive Command"
repo start auto frameworks/opt/telephony
pushd frameworks/opt/telephony
git fetch http://review.cyanogenmod.org/CyanogenMod/android_frameworks_opt_telephony refs/changes/36/27336/1 && git cherry-pick FETCH_HEAD
popd

echo "### Add Samsung STK support (telephony part)"
repo start auto frameworks/opt/telephony
pushd frameworks/opt/telephony
git fetch http://review.cyanogenmod.org/CyanogenMod/android_frameworks_opt_telephony refs/changes/37/27337/1 && git cherry-pick FETCH_HEAD
popd

echo "### Samsung STK: Add USSD support"
repo start auto frameworks/opt/telephony
pushd frameworks/opt/telephony
git fetch http://review.cyanogenmod.org/CyanogenMod/android_frameworks_opt_telephony refs/changes/38/27338/1 && git cherry-pick FETCH_HEAD
popd

echo "### Samsung STK support (framework/base part)"
repo start auto frameworks/base
pushd frameworks/base
git fetch http://review.cyanogenmod.org/CyanogenMod/android_frameworks_base refs/changes/39/27339/1 && git cherry-pick FETCH_HEAD
popd

echo "### aries: Wi-Fi adjustments"
repo start auto kernel/samsung/aries
pushd kernel/samsung/aries
git fetch http://review.cyanogenmod.org/CyanogenMod/android_kernel_samsung_aries refs/changes/70/27370/2 && git cherry-pick FETCH_HEAD
popd

echo "### vibrantmtd: add bluetooth configuration"
repo start auto device/samsung/vibrantmtd
pushd device/samsung/vibrantmtd
git fetch http://review.cyanogenmod.org/CyanogenMod/android_device_samsung_vibrantmtd refs/changes/78/27178/1 && git cherry-pick FETCH_HEAD
popd
