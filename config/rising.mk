# Media
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    media.recorder.show_manufacturer_and_model=true

# Common GMS properties
PRODUCT_PRODUCT_PROPERTIES += \
    persist.rcs.supported=1 \
    ro.opa.eligible_device=true \
    ro.com.google.ime.theme_id=5 \
    ro.com.google.ime.bs_theme=true \
    ro.com.google.ime.system_lm_dir=/product/usr/share/ime/google/d3_lms \
    ro.product.locale=en-US \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.product.needs_model_edit=false \
    ro.support_one_handed_mode=true \
    persist.sys.storage_picker_enabled=true \
    debug.photos.p_editr.eraser=1 \
    debug.photos.force_pixel_eol=1 \
    debug.photos.eraser_camo=1 \
    debug.photos.eraser_suggestion=1 \
    ro.support_hide_display_cutout=true

# RisingOS properties - used by firmware version
PRODUCT_PRODUCT_PROPERTIES += \
    ro.rising.maintainer=$(RISING_MAINTAINER) \
    ro.rising.code=$(RISING_CODENAME) \
    ro.rising.packagetype=$(RISING_PACKAGE_TYPE) \
    ro.rising.releasetype=$(RISING_BUILDTYPE) \
    ro.rising.version?=$(RISING_VERSION) \
    ro.rising.chipset?=$(RISING_CHIPSET) \
    ro.rising.build.version=$(LINEAGE_VERSION) \
    ro.rising.display.version?=$(LINEAGE_DISPLAY_VERSION) \
    ro.rising.platform_release_codename=$(RISING_FLAVOR)

TARGET_ENABLE_PRIVAPP_ENFORCEMENT ?= true
ifeq ($(TARGET_ENABLE_PRIVAPP_ENFORCEMENT), true)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.control_privapp_permissions=enforce
else 
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.control_privapp_permissions=log
endif

# Disable touch video heatmap to reduce latency, motion jitter, and CPU usage
# on supported devices with Deep Press input classifier HALs and models
PRODUCT_PRODUCT_PROPERTIES += \
    ro.input.video_enabled=false

# Speed profile services and wifi-service to reduce RAM and storage
PRODUCT_SYSTEM_SERVER_COMPILER_FILTER := speed-profile
PRODUCT_USE_PROFILE_FOR_BOOT_IMAGE := true
PRODUCT_DEX_PREOPT_BOOT_IMAGE_PROFILE_LOCATION := art/build/boot/boot-image-profile.txt

# Face Unlock
TARGET_FACE_UNLOCK_SUPPORTED ?= true
ifeq ($(TARGET_FACE_UNLOCK_SUPPORTED),true)
$(call inherit-product-if-exists, external/faceunlock/config.mk)
endif

# Blurs
ifeq ($(TARGET_ENABLE_BLUR), true)
PRODUCT_PRODUCT_PROPERTIES += \
    ro.sf.blurs_are_expensive=1 \
    ro.surface_flinger.supports_background_blur=1
else
PRODUCT_PRODUCT_PROPERTIES += \
    ro.launcher.blur.appLaunch=0
endif

# Default boosting durations 
PRODUCT_PRODUCT_PROPERTIES += \
    persist.sys.powerhal.interaction.max=64 \
    persist.sys.powerhal.interaction.max_default=64 \
    persist.sys.powerhal.interaction.max_boost=500

# DesktopMode
PRODUCT_PACKAGES += \
    DesktopMode

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.freeform_window_management.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/android.software.freeform_window_management.xml

# Prebuilt packages
PRODUCT_PACKAGES += \
    GameSpace \
    OmniJaws \
    ParallelSpace \
    Updater

ifeq ($(TARGET_USE_PIXEL_FINGERPRINT), true)
BUILD_FINGERPRINT := "google/cheetah/cheetah:13/TQ2A.230405.003.E1/9802792:user/release-keys"

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="cheetah-user 13 TQ2A.230405.003.E1 9802792 release-keys"

endif

