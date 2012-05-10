#!/bin/bash
#
# Build a kernel flashable package.
#

ROOT=`pwd`
BT_ROOT=`readlink -f buildtools`
BKP_TMP=`readlink -f $BT_ROOT/bkp-tmp`
BKP_OUT=`readlink -f $BT_ROOT/out`
BKP_ZIP=tmp-kernel-`date +%Y-%m-%d`.zip
DEVICE=$1

if [ ! -n "$DEVICE" ]; then
    DEVICE=vibrantmtd
fi

. build/envsetup.sh
breakfast cm_${DEVICE}-userdebug

mka out/target/product/$DEVICE/boot.img

cp out/target/product/$DEVICE/boot.img $BKP_TMP/
cp out/target/product/$DEVICE/system/lib/modules/* $BKP_TMP/system/lib/modules/

cd $BKP_TMP
zip -r $BKP_OUT/$BKP_ZIP .
cd $ROOT

echo "Target package: $BKP_ZIP"
