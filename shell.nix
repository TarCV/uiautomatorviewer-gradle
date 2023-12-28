with import <nixpkgs> {};
(pkgs.buildFHSUserEnv {
  name = "uiautomatorviewer-env";
  targetPkgs = pkgs: (with pkgs;
    [
      pkgs.gtk3 pkgs.glib # For GSETTINGS_SCHEMA_PATH
      pkgs.jdk
      pkgs.jdk21
      pkgs.zlib # required when JVM is installed by Gradle
    ]);

  profile = ''
export JAVA_HOME="${pkgs.jdk.home}"
export JAVA21_HOME="${pkgs.jdk21.home}"
export GRADLE_OPTS="-Dorg.gradle.java.home=${pkgs.jdk.home}"
'';
}).env
