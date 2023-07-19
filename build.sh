#!/bin/bash

set -e

apt update

export DEBIAN_FRONTEND=noninteractive

apt install multistrap -y

multistrap -f yangtze.multistrap

cp sources.list /yangtze-rootfs/etc/apt/sources.list
cp openkylin-anything.list /yangtze-rootfs/etc/apt/sources.list.d/openkylin-anything.list
