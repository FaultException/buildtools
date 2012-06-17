#!/bin/bash
#
# Build a kernel flashable package (from CM9).
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
BKP_OUT=`readlink -f $BT_ROOT/out`
BKP_ZIP=tmp-kernel-`date +%Y-%m-%d`.zip
DEVICE=$1
if [ ! -z "$2" ]; then
    BKP_OUT=$2.zip
    echo "${BLUE}Package will be named $BKP_OUT${RESET}"
    echo
fi

if [ ! -d "buildtools" ]; then
    echo "buildtools must be placed inside of the CM9 root folder,"
    echo "and ran from there."
    echo
    echo "Example: ./buildtools/bkp.sh <device> <outname>"
    exit 1
fi

if [ ! -n "$DEVICE" ]; then
    DEVICE=vibrantmtd
fi
BUILD_OUT=out/target/product/$DEVICE

. build/envsetup.sh
breakfast cm_${DEVICE}-userdebug

if [ -e $BUILD_OUT/boot.img ]; then
    echo "${CYAN}Cleaning up...${RESET}"
    rm $BUILD_OUT/boot.img
    rm -rf $BUILD_OUT/obj/KERNEL_OBJ
    rm -rf $BUILD_OUT/ramdisk*
    rm $BUILD_OUT/system/lib/modules/*
fi

mka $BUILD_OUT/boot.img

if [ ! -e $BUILD_OUT/boot.img ]; then
    echo "${RED}Build failed! Please correct the errors above.${RESET}"
    exit 1
fi

echo "${GREEN}Build succeeded!${RESET}"

cp $BUILD_OUT/boot.img $BKP_TMP/

if [ ! -d $BKP_TMP/system/lib/modules ]; then
    mkdir -p $BKP_TMP/system/lib/modules
fi
cp $BUILD_OUT/system/lib/modules/* $BKP_TMP/system/lib/modules/

cd $BKP_TMP
zip -r $BKP_OUT/$BKP_ZIP .
cd $ROOT

echo "${GREEN}Target package: $BKP_ZIP${RESET}"
