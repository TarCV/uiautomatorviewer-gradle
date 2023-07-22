![Screenshot](MainScreen.png)

### Verifying this code against the SDK sources ###
1. **Verifying that this repository is actually based on the original viewer sources**: This repository is based on https://android.googlesource.com/platform/tools/swt/+/1ad1e59667a2b7ea4c0c90e3bfb76c39c5a96fb3/uiautomatorviewer/ .
The [initial commit - da94b667bbdc007d2bdf74d300932eb3dc75256e](https://github.com/TarCV/uiautomatorviewer-gradle/tree/da94b667bbdc007d2bdf74d300932eb3dc75256e) is exactly that directory.
Therefore, you can [download that source](https://android.googlesource.com/platform/tools/swt/+archive/1ad1e59667a2b7ea4c0c90e3bfb76c39c5a96fb3/uiautomatorviewer.tar.gz) and compare it against [the sources in that initial commit](https://github.com/TarCV/uiautomatorviewer-gradle/archive/da94b667bbdc007d2bdf74d300932eb3dc75256e.zip).<br/>There should be no differences except in timestamps.
2. **Reviewing changes**: Some changes were made to those original sources to fix building on the latest Java/OS/etc., update libraries, and for convenience. These changes can be reviewed by [comparing the current main with the initial commit](https://github.com/TarCV/uiautomatorviewer-gradle/compare/da94b667bbdc007d2bdf74d300932eb3dc75256e...main).

### Running on Windows, Linux ###
You can run the app as is on these OSes, just make sure Android Debug Bridge is available.

### Running on Mac ###
Launch the app passing `-XstartOnFirstThread` JVM argument, otherwise it will immediately crash. For example:
```bash
./gradlew installDist
JAVA_OPTS=-XstartOnFirstThread ./build/install/uiautomatorviewer-gradle/bin/uiautomatorviewer-gradle
```
(Unfortunately, this option is not supported on Linux, so it cannot be added to the shell wrapper script)

Also make sure Android Debug Bridge is available.
