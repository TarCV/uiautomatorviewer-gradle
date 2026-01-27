with import <nixpkgs> {};
(pkgs.buildFHSEnv {
  name = "uiautomatorviewer-env";
  targetPkgs = pkgs: (with pkgs;
    [
      pkgs.gtk3 pkgs.glib # For GSETTINGS_SCHEMA_PATH
      pkgs.javaPackages.compiler.openjdk25
      pkgs.zlib # required when JVM is installed by Gradle
    ]);

  profile = ''
export JAVA_HOME="${pkgs.javaPackages.compiler.openjdk25.home}"
export GRADLE_OPTS="-Dorg.gradle.java.home=$JAVA_HOME"
'';
}).env
