# Copyright (C) 2010 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#
# This file is the build configuration for a full Android
# build for grouper hardware. This cleanly combines a set of
# device-specific aspects (drivers) with a device-agnostic
# product configuration (apps).
#

$(call inherit-product, $(SRC_TARGET_DIR)/product/product_launched_with_p.mk)

VENDOR_EXCEPTION_PATHS := omni \
    motorola \
    gapps \
    microg

# Sample: This is where we'd set a backup provider if we had one
# $(call inherit-product, device/sample/products/backup_overlay.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)

# Get the prebuilt list of APNs
$(call inherit-product, vendor/aosp/config/gsm.mk)

# Inherit from the common Open Source product configuration
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base_telephony.mk)

BOARD_BUILD_SYSTEM_ROOT_IMAGE := true

# must be before including omni part
TARGET_BOOTANIMATION_SIZE := 1080p
AB_OTA_UPDATER := true

DEVICE_PACKAGE_OVERLAYS += device/motorola/doha/overlay/device
DEVICE_PACKAGE_OVERLAYS += vendor/aosp/overlay/CarrierConfig

# Inherit from our custom product configuration
$(call inherit-product, vendor/aosp/config/common.mk)

# get the rest of aosp stuff after ours
# $(call inherit-product, $(SRC_TARGET_DIR)/product/mainline_system_arm64.mk)

# Inherit from hardware-specific part of the product configuration
$(call inherit-product, device/motorola/doha/device.mk)

# Discard inherited values and use our own instead.
PRODUCT_NAME := aosp_doha
PRODUCT_DEVICE := doha
PRODUCT_BRAND := motorola
PRODUCT_MANUFACTURER := motorola
PRODUCT_MODEL := moto g8 plus

TARGET_DEVICE := Moto G8 Plus
PRODUCT_SYSTEM_NAME := Moto G8 Plus

VENDOR_RELEASE := 9/PPIS29.65-24-2/dc7f7b:user/release-keys
BUILD_FINGERPRINT := motorola/doha_retail/doha:$(VENDOR_RELEASE)
OMNI_BUILD_FINGERPRINT := motorola/doha_retail/doha:$(VENDOR_RELEASE)
OMNI_PRIVATE_BUILD_DESC := "'doha_retail-user 10 PPIS29.65-24-2 dc7f7b release-keys'"

#PLATFORM_SECURITY_PATCH_OVERRIDE := 2019-11-01

TARGET_VENDOR := motorola

$(call inherit-product, vendor/motorola/doha/doha-vendor.mk)

ifeq ($(WITH_GAPPS),true)
# https://gitlab.com/darkobas/android_vendor_gapps
$(call inherit-product, vendor/gapps/config.mk)
endif

ifeq ($(WITH_MICROG),true)
# https://github.com/boulzordev/android_prebuilts_prebuiltapks
$(call inherit-product, vendor/microg/microg.mk)
endif

#Architecture Gapps
TARGET_GAPPS_ARCH := arm64
