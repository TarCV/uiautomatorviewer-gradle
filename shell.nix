with import <nixpkgs> { overlays = [
  (self: super:
    let
      # TODO: remove when JDK21 support is merged in
      jdk21Pkgs = import (builtins.fetchTarball {
        name = "jdk21Pkgs";
        url = "https://github.com/NixOS/nixpkgs/archive/9a00ebc79fbdc9bed1964af8756ebec95af8191c.tar.gz";
        #        # Use nix-prefetch-url --unpack to generate:
        sha256 = "0rz45pyg1mnviw6l9vv65w84jpqzx84z3r78k1v77ciymjd5fdg9";
      }) {};
    in
    {
      jdk21 = jdk21Pkgs.jdk21;
   }
  )
];};

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
