/*
 * New code and modifications are Copyright (C) 2019 TarCV
 * Original code is
 * Copyright (C) 2012 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.android.uiautomator;

import com.android.ddmlib.AndroidDebugBridge;
import com.android.ddmlib.IDevice;

import java.io.File;
import java.util.Arrays;
import java.util.List;
import java.util.concurrent.TimeUnit;

public class DebugBridge {
    private static AndroidDebugBridge sDebugBridge;

    private static String getAdbLocation() {
        File sdk;
        String toolsDir = System.getProperty("com.android.uiautomator.bindir"); //$NON-NLS-1$

        if (toolsDir == null) {
            String sdkDir = System.getenv("ANDROID_SDK_ROOT");
            if (sdkDir == null) {
                sdkDir = System.getProperty("sdk.dir");

                if (sdkDir == null) {
                    return null;
                }
            }

            sdk = new File(sdkDir);
        } else {
            sdk = new File(toolsDir).getParentFile();
            toolsDir = new File(sdk, "tools").getAbsolutePath();
        }

        // check if adb is present in platform-tools
        File platformTools = new File(sdk, "platform-tools");
        File adb = findAdbIn(platformTools);
        if (adb != null && adb.exists()) {
            return adb.getAbsolutePath();
        }

        // check if adb is present in the tools directory
        if (toolsDir != null) {
            adb = findAdbIn(new File(toolsDir));
            if (adb != null && adb.exists()) {
                return adb.getAbsolutePath();
            }
        }

        // check if we're in the Android source tree where adb is in $ANDROID_HOST_OUT/bin/adb
        String androidOut = System.getenv("ANDROID_HOST_OUT");
        if (androidOut != null) {
            adb = findAdbIn(new File(androidOut + File.separator + "bin"));
            if (adb != null && adb.exists()) {
                return adb.getAbsolutePath();
            }
        }

        return null;
    }

    private static File findAdbIn(File platformTools) {
        File[] files = platformTools.listFiles((dir, name) -> "adb".equals(name) || name.startsWith("adb."));
        if (files != null && files.length > 0) {
            return files[0];
        } else {
            return null;
        }
    }

    public static void init() {
        String adbLocation = getAdbLocation();
        AndroidDebugBridge.init(false /* debugger support */);
        if (adbLocation != null) {
            sDebugBridge = AndroidDebugBridge.createBridge(adbLocation, false, 15, TimeUnit.SECONDS);
        } else {
            sDebugBridge = AndroidDebugBridge.createBridge(15, TimeUnit.SECONDS);
        }
    }

    public static void terminate() {
        if (sDebugBridge != null) {
            sDebugBridge = null;
            AndroidDebugBridge.terminate();
        }
    }

    public static boolean isInitialized() {
        return sDebugBridge != null;
    }

    public static List<IDevice> getDevices() {
        return Arrays.asList(sDebugBridge.getDevices());
    }
}
