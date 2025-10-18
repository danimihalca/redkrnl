#!/bin/bash

compile_kernel() {
   export PATH="/toolchain/linux-x86/clang-r383902/bin:${PATH}" 

   cd /builddir/biloba-kernel

   cp /builddir/defconfigs/* /builddir/biloba-kernel/arch/arm64/configs

   make O=out ARCH=arm64 biloba_defconfig redkrnl.config
   make O=out ARCH=arm64 CC=clang CLANG_TRIPLE=aarch64-linux-gnu- CROSS_COMPILE=aarch64-linux-gnu- -j"$(nproc)"
}

generate_bootimg() {
   python3 /toolchain/android_system_tools_mkbootimg/mkbootimg.py --kernel "/builddir/biloba-kernel/out/arch/arm64/boot/Image.gz-dtb" --ramdisk "/builddir/boot_blobs/blobs/initrd.img" --cmdline "bootopt=64S3,32N2,64N2" --header_version "2" --os_version "11" --os_patch_level "2022-03-1" --dtb /builddir/biloba-kernel/out/arch/arm64/boot/dts/mediatek/mt6768.dtb --dtb_offset "0x4bc80000" --base "0x00000000" --kernel_offset "0x40080000" --ramdisk_offset "0x47c80000" --second_offset "0x00000000" --tags_offset "0x4bc80000" -o /builddir/boot.img
}
