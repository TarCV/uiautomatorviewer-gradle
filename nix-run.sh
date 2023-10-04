#!/usr/bin/env bash
set -e

pushd "$(dirname "$(readlink -f "$0")")"
./gradlew installDist
JAVA_HOME=$JAVA21_HOME ./build/install/uiautomatorviewer-gradle/bin/uiautomatorviewer-gradle
popd
