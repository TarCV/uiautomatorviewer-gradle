#!/usr/bin/env bash
set -e

pushd "$(dirname "$(readlink -f "$0")")"
./gradlew installDist
./build/install/uiautomatorviewer-gradle/bin/uiautomatorviewer-gradle
popd
