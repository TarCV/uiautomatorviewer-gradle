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
