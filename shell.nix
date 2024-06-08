with import <nixpkgs> {};
(pkgs.buildFHSUserEnv {
  name = "uiautomatorviewer-env";
  targetPkgs = pkgs: (with pkgs;
    [
      pkgs.gtk3 pkgs.glib # For GSETTINGS_SCHEMA_PATH
      pkgs.jdk22
      pkgs.zlib # required when JVM is installed by Gradle
    ]);

  profile = ''
export JAVA_HOME="${pkgs.jdk22.home}"
export GRADLE_OPTS="-Dorg.gradle.java.home=${pkgs.jdk.home}"
'';
}).env
