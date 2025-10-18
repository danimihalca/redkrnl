FROM ubuntu:22.04


RUN apt update && \
    apt upgrade -y && \
    apt install -y --no-install-recommends python3 bc bison build-essential ca-certificates cpio curl fakeroot flex git kmod libssl-dev libtinfo5 sudo unzip wget xz-utils img2simg jq crossbuild-essential-arm64

RUN mkdir /toolchain && \
    git clone https://android.googlesource.com/platform/prebuilts/clang/host/linux-x86 -b android11-gsi /toolchain/linux-x86 --depth 1 --recursive && \
    git clone --depth 1 -b lineage-20.0 https://github.com/LineageOS/android_system_tools_mkbootimg /toolchain/android_system_tools_mkbootimg && \
    mv /toolchain/linux-x86/clang-r383902 /toolchain/linux-x86/safe-dir && \
    mv /toolchain/linux-x86/clang-stable /toolchain/linux-x86/safe-dir-stable && \
    rm -rdf /toolchain/linux-x86/.git /toolchain/linux-x86/clang-* && \
    mv /toolchain/linux-x86/safe-dir /toolchain/linux-x86/clang-r383902 && \
    mv /toolchain/linux-x86/safe-dir-stable /toolchain/linux-x86/clang-stable
