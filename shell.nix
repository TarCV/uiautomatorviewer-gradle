with import <nixpkgs> {};

(pkgs.buildFHSUserEnv {
  name = "uiautomatorviewer-env";
  targetPkgs = pkgs: (with pkgs;
    [
      pkgs.jdk17
      pkgs.zlib # required when JVM is installed by Gradle
    ]);

  profile = ''
export JAVA_HOME="${pkgs.jdk17.home}"
export GRADLE_OPTS="-Dorg.gradle.java.home=${pkgs.jdk17.home}"
'';
}).env
