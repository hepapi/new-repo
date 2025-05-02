#!/bin/bash

export RKE2_VER=v1.31.7
export ARCH=amd64
export DL_BASE=https://github.com/rancher/rke2/releases/download
export RKE2_DL_URL="${DL_BASE}/${RKE2_VER}%2Brke2r1"
export RKE2_ARTIFACT_LIST="
rke2-images.linux-${ARCH}.tar.zst
rke2.linux-${ARCH}.tar.gz
sha256sum-${ARCH}.txt
"

mkdir -p ~/rke2_install/${RKE2_VER}
cd ~/rke2_install/${RKE2_VER}

for ARTIFACT in ${RKE2_ARTIFACT_LIST}; do
  curl -OL ${RKE2_DL_URL}/${ARTIFACT}
done

curl -sfL https://get.rke2.io --output install.sh
chmod +x install.sh