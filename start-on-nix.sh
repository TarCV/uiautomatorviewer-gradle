requisites="$(nix-store --query --requisites --quiet --quiet "$(which java)")"
gsettings_schemas_path=$(echo "${requisites}" | grep gsettings-desktop-schemas | head -n1)
gtk_path=$(echo "$requisites" | grep gtk+3 | head -n1)
eval "$(nix-store --print-env "$(nix-store -qd "${gsettings_schemas_path}")" | grep "export name")"
gsettings_schemas_name=$name
eval "$(nix-store --print-env "$(nix-store -qd "${gtk_path}")" | grep "export name")"
gtk_name=$name
export XDG_DATA_DIRS="$gsettings_schemas_path"/share/gsettings-schemas/"$gsettings_schemas_name":"$gtk_path"/share/gsettings-schemas/"$gtk_name":"$XDG_DATA_DIRS"
unset name
unset requisites
unset gsettings_schemas_path
unset gtk_path
unset gsettings_schemas_name
unset gtk_name

./gradlew installDist
steam-run ./build/install/uiautomatorviewer-gradle/bin/uiautomatorviewer-gradle
