#!/bin/bash

OP=$1
echo "OP-::${OP}"

# 路径
BASEDIR=$(dirname "$0")
cd ${BASEDIR}
BASEDIR=`pwd`

ROOT_DIR=${BASEDIR}/../../
# 加载环境
source ../env.sh

HOST_PSW=lh1992524

ovmf_dbg_dir=${BASEDIR}/_ovmf_dbg
echo "echo lh1992524 | sudo -S mkdir _ovmf_dbg"
echo lh1992524 | sudo -S mkdir _ovmf_dbg
cd _ovmf_dbg
echo lh1992524 | sudo -S cp ${OvmfX64_DEBUG_XCODE5_FV_DIR}/OVMF.fd ./

hda_contents_dir=${ovmf_dbg_dir}/hda-contents

echo lh1992524 | sudo -S mkdir hda-contents
echo lh1992524 | sudo -S cp ${EmulatorX64_DEBUG_XCODE5_X64_DIR}/HelloWorld.* ./hda-contents

QEMU=qemu-system-x86_64
QEMU_OPTION=" -s -pflash OVMF.fd -hda fat:rw:hda-contents/ -net none "
SUDO_QEMU="echo lh1992524 | sudo -S ${QEMU}"

if  ( [[ $OP == "debug" ]] );then
    osascript -e "tell application \"Terminal\" to quit"
    osascript -e "tell application \"Terminal\" to do script \"cd ${hda_contents_dir}\\n lldb HelloWorld.efi \\n gdb-remote localhost:1234\"" \
    -e "tell application \"Terminal\" to activate" \
    -e "tell application \"System Events\" to tell process \"Terminal\" to keystroke \"t\" using command down" \
    -e "tell application \"Terminal\" to set background color of window 1 to {0,0,0,1}" \
    -e "tell application \"Terminal\" to do script \"cd ${ovmf_dbg_dir}\\n sleep 0.3\\n echo lh1992524 | sudo -S ${QEMU} -S ${QEMU_OPTION}\" in window 1"
else
    echo "echo lh1992524 | sudo -S ${QEMU} ${QEMU_OPTION}"
    echo lh1992524 | sudo -S ${QEMU} ${QEMU_OPTION}
fi
