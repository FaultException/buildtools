#!/bin/bash
#
# Build a kernel flashable package (from CM10).
#

# STATIC COLORS
RESET=$(tput sgr0)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
CYAN=$(tput setaf 6)

ROOT=`pwd`
BT_ROOT=`readlink -f buildtools`
BKP_TMP=`readlink -f $BT_ROOT/bkp-tmp`
BKP_COMMON=`readlink -f $BT_ROOT/bkp-common`
BKP_OUT=`readlink -f $BT_ROOT/out`
DEVICE=$1
if [ ! -z "$2" ]; then
    BKP_ZIP=$2.zip
    echo "${BLUE}Package will be named $BKP_ZIP${RESET}"
    echo
fi

if [ ! -d "buildtools" ]; then
    echo "buildtools must be placed inside of the CM10 root folder,"
    echo "and ran from there."
    echo
    echo "Example: ./buildtools/bkp.sh <device> <outname>"
    exit 1
fi

if [ ! -n "$DEVICE" ]; then
    DEVICE=vibrantmtd
fi

BKP_DEVICE=`readlink -f $BT_ROOT/bkp-${DEVICE}`

if [ ! -e $BKP_DEVICE ]; then
    echo "${RED}Device not supported!${RESET}"
    exit 1
fi

BKP_ZIP_BASE=tmp_kernel_${DEVICE}_
BKP_ZIP=$BKP_ZIP_BASE`date +%Y-%m-%d`.zip

. build/envsetup.sh
breakfast ${DEVICE}

BUILD_OUT=$ANDROID_PRODUCT_OUT

echo "${CYAN}Cleaning up...${RESET}"
rm -f $BUILD_OUT/boot.img
rm -rf $BUILD_OUT/obj/KERNEL_OBJ
rm -rf $BUILD_OUT/ramdisk*
rm -f $BUILD_OUT/system/lib/modules/*

if ! mka $BUILD_OUT/boot.img; then
    echo "${RED}Build failed! Please correct the errors above.${RESET}"
    exit 1
fi

if [ ! -e $BUILD_OUT/boot.img ]; then
    echo "${RED}Build succeeded but no build.img was produced!${RESET}"
    exit 1
fi

echo "${GREEN}Build succeeded!${RESET}"

rm -rf $BKP_TMP
cp -r $BKP_COMMON $BKP_TMP
cp -r $BKP_DEVICE/* $BKP_TMP

cp $BUILD_OUT/boot.img $BKP_TMP/

if [ ! -d $BKP_TMP/system/lib/modules ]; then
    mkdir -p $BKP_TMP/system/lib/modules
fi
cp $BUILD_OUT/system/lib/modules/* $BKP_TMP/system/lib/modules/

# Flush out previous zips for this device
rm -rf $BKP_OUT/$BKP_ZIP_BASE*

cd $BKP_TMP
zip -r $BKP_OUT/$BKP_ZIP .
cd $ROOT

echo "${GREEN}Target package: $BKP_ZIP${RESET}"
