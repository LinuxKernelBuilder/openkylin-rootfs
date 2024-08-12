#!/bin/bash

set -e -u

sudo apt update

# 不进行交互安装
export DEBIAN_FRONTEND=noninteractive
ROOTFS=`mktemp -d`
dist_version="nile"
dist_name="openkylin"
readarray -t REPOS < ./config/apt/sources.list
PACKAGES=`cat ./config/packages.list/packages.list | grep -v "^-" | xargs | sed -e 's/ /,/g'`
OUT_DIR=$(dirname "$(realpath "$0")")/rootfs

mkdir -p $OUT_DIR
sudo apt install -y curl git mmdebstrap qemu-user-static usrmerge usr-is-merged binfmt-support systemd-container
# 开启异架构支持
sudo systemctl start systemd-binfmt

# 安装软件包签名公钥
curl http://archive.build.openkylin.top/openkylin/pool/main/o/openkylin-keyring/openkylin-keyring_2022.05.12-ok1_all.deb --output openkylin-keyring.deb
sudo apt install ./openkylin-keyring.deb && rm ./openkylin-keyring.deb

curl http://archive.build.openkylin.top/openkylin/pool/main/o/openkylin-archive-anything/openkylin-archive-anything_2023.02.06-ok4_all.deb --output openkylin-archive-anything.deb
sudo apt install ./openkylin-archive-anything.deb && rm ./openkylin-archive-anything.deb

for arch in amd64 arm64; do
    sudo mmdebstrap \
        --hook-dir=/usr/share/mmdebstrap/hooks/merged-usr \
        --include=$PACKAGES \
        --components="main,cross,pty" \
        --variant=minbase \
        --architectures=${arch} \
        --customize=./config/hooks.chroot/second-stage \
        $dist_version \
        $ROOTFS \
        "${REPOS[@]}"

    # 生成压缩包
    pushd $OUT_DIR
    rm -rf $dist_name-rootfs-$arch.tar.gz
    sudo tar -zcf $dist_name-rootfs-$arch.tar.gz -C $ROOTFS .
    # 删除临时文件夹
    sudo rm -rf  $ROOTFS
    popd
done
