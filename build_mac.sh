#!/bin/zsh

mkdir -p build/mac_debug

(
  cd ./sauce/sokol/ || exit 1
  if [ ! -e ./app/sokol_app_macos_arm64_metal_debug.a ]; then
    echo "Building sokol..."
    zsh build_clibs_macos.sh
  fi
)

odin run ./sauce/build -- target:mac
