#!/bin/bash

source build_functions.sh

build_image redkrnl-biloba-build

if [ ! -d "biloba-kernel" ]
then
   git clone --depth 1 -b halium-11 "https://gitlab.com/biloba-ut/biloba-kernel.git"
fi

run_command_in_container "source /builddir/krnl_buildtools/source.sh && compile_kernel && generate_bootimg"
