# Copyright (c) 2020 Intel Corporation
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

ifeq ($(USE_IIO_SENSOR_HAL),true)

LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_SRC_FILES := \
    entry.c \
    enumeration.c \
    control.c \
    description.c \
    utils.c \
    transform.c \
    compass-calibration.c \
    matrix-ops.c \
    gyro-calibration.c \
    filtering.c \
    discovery.c \
    accel-calibration.c \

LOCAL_C_INCLUDES += $(LOCAL_PATH)
LOCAL_MODULE := sensors.$(TARGET_PRODUCT)
LOCAL_MODULE_OWNER := intel
LOCAL_MODULE_RELATIVE_PATH := hw
LOCAL_CFLAGS :=\
    -fno-strict-overflow \
    -fwrapv \
    -fvisibility=hidden \
    -D_FORTIFY_SOURCE=2 \
    -fstack-protector-strong \
    -Wno-conversion-null \
    -Wnull-dereference \
    -Wall \
    -Werror \
    -Warray-bounds \
    -Wformat -Wformat-security \
    -Werror=format-security \
    -DLOG_TAG=\"Sensors\"

LOCAL_LDFLAGS := -Wl,--gc-sections
LOCAL_SHARED_LIBRARIES := liblog libcutils libdl libsafestring
LOCAL_HEADER_LIBRARIES += libutils_headers libhardware_headers
LOCAL_PROPRIETARY_MODULE := true
include $(BUILD_SHARED_LIBRARY)

endif
