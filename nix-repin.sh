#!/usr/bin/env bash
set -e

pushd "$(dirname "$(readlink -f "$0")")"
rm -r ./.nix-gc-roots
nix-instantiate shell.nix --indirect --add-root ./.nix-gc-roots/shell.drv
popd
