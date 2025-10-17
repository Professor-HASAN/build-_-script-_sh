#! /bin/bash

rm -rf .repo/local_manifests
repo init -u https://github.com/CherishOS/android_manifest.git -b sixteen --git-lfs
rm -rf prebuilts/clang/host/linux-x86

echo "==> Syncing sources..."
/opt/crave/resync.sh

echo "==> Cleaning old outputs and device/vendor/hardware trees..."
dirs_to_remove=(
    out/target/product/munch
    device/xiaomi/munch
    kernel/xiaomi/munch
    vendor/xiaomi/munch
    vendor/xiaomi/munch-firmware
    hardware/xiaomi
    hardware/dolby
    vendor/xiaomi/miuicamera
    packages/resources/devicesettings
)
rm -rf "${dirs_to_remove[@]}"

echo "=== Cloning device trees ==="
git clone https://github.com/Professor-HASAN/android_device_xiaomi_munch -b cherish device/xiaomi/munch
git clone https://github.com/Professor-HASAN/android_vendor_xiaomi_munch -b 16 vendor/xiaomi/munch
git clone https://github.com/SenseiiX/fusionX_sm8250 -b wip-next kernel/xiaomi/munch
git clone https://github.com/Professor-HASAN/android_hardware_xiaomi hardware/xiaomi
git clone https://codeberg.org/munch-devs/android_vendor_xiaomi_munch-firmware vendor/xiaomi/munch-firmware
git clone https://github.com/munch-devs/android_hardware_dolby hardware/dolby
git clone https://github.com/PocoF3Releases/packages_resources_devicesettings -b aosp-16 packages/resources/devicesettings
git clone https://codeberg.org/munch-devs/android_vendor_xiaomi_miuicamera vendor/xiaomi/miuicamera

# GAPPS
echo "=== Building GAPPS ==="
. build/envsetup.sh
lunch lineage_munch-user
m bacon
