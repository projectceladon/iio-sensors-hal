/*
// Copyright (c) 2015 Intel Corporation
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
*/

#ifndef __PLUGIN_H__
#define __PLUGIN_H__

#include <hardware/sensors.h>

typedef struct {
    void* handle;

    /**
     * Initialize the vendor plugin.
     *
     * @param[in]	dev	The sensor device
     * @return		0 on success, negative errno code otherwise.
     */
    int (*open)(int dev);
    /**
     * Release the resources allocated by vendor plugin
     * internally.
     *
     * @param[in]	dev	The sensor device
     * @return		0 on success, negative errno code otherwise.
     */
    int (*close)(int dev);
    /**
     * Preprocess the sensor data before passing it to HAL.
     *
     * @param[in,out] data	The sensor data to be preprocessed
     * @return		0 on success, negative errno code otherwise.
     */
    int (*preprocess)(sensors_event_t* data);
    /**
     * Postprocess the sensor data once it has been handled
     * by HAL and before passing it to Android framework.
     *
     * @param[in,out] data	The sensor data to be postprocessed
     * @return		0 on success, negative errno code otherwise.
     */
    int (*postprocess)(sensors_event_t* data);
} sensor_plugin_t;

/**
 * Prototype for create_plugin() function.
 *
 * A standalone sensor plugin library must define the following
 * function that will be used by HAL to instantiate it:
 *
 *     sensor_plugin_t* create_plugin();
 */
typedef sensor_plugin_t* (*create_plugin_t)();

#endif
