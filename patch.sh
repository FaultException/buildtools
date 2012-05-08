set -e

repo abandon auto

# Patches
echo "### aries-common: tenative fix for \"mute-unmute\" bug"
repo start device/samsung/aries-common
cd device/samsung/aries-common
git fetch ssh://FaultException@review.cyanogenmod.com:29418/CyanogenMod/android_device_samsung_aries-common refs/changes/20/15720/1 && git cherry-pick FETCH_HEAD
cd ../../..
