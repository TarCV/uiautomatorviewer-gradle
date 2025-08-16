with import <nixpkgs> {};
(pkgs.buildFHSEnv {
  name = "uiautomatorviewer-env";
  targetPkgs = pkgs: (with pkgs;
    [
      pkgs.gtk3 pkgs.glib # For GSETTINGS_SCHEMA_PATH
      pkgs.jdk24
    ]);

  profile = ''
export JAVA_HOME="${pkgs.jdk24.home}"
export GRADLE_OPTS="-Dorg.gradle.java.home=$JAVA_HOME"
'';
}).env
