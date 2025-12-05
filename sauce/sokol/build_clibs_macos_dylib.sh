set -e

FRAMEWORKS_METAL="-framework Metal -framework MetalKit"
FRAMEWORKS_OPENGL="-framework OpenGL"
FRAMEWORKS_CORE="-framework Foundation -framework CoreGraphics -framework Cocoa -framework QuartzCore -framework CoreAudio -framework AudioToolbox"

build_lib_release() {
    src=$1
    dst=$2
    backend=$3
    arch=$4
    frameworks=""
    if [ $backend = "SOKOL_METAL" ]; then
        frameworks="${frameworks} ${FRAMEWORKS_METAL}"
    else
        frameworks="${frameworks} ${FRAMEWORKS_OPENGL}"
    fi
    echo $dst
    MACOSX_DEPLOYMENT_TARGET=10.13 clang -c -O2 -x objective-c -arch $arch -DNDEBUG -DIMPL -D$backend c/$src.c
    clang -dynamiclib -arch $arch $FRAMEWORKS_CORE $frameworks -o $dst.dylib $src.o $dep
}

build_lib_debug() {
    src=$1
    dst=$2
    backend=$3
    arch=$4
    frameworks=""
    if [ $backend = "SOKOL_METAL" ]; then
        frameworks="${frameworks} ${FRAMEWORKS_METAL}"
    else
        frameworks="${frameworks} ${FRAMEWORKS_OPENGL}"
    fi
    echo $dst
    MACOSX_DEPLOYMENT_TARGET=10.13 clang -c -g -x objective-c -arch $arch -DIMPL -D$backend c/$src.c
    clang -dynamiclib -arch $arch $FRAMEWORKS_CORE $frameworks -o $dst.dylib $src.o $dep
}

mkdir -p dylib

build_lib_release sokol dylib/sokol_dylib_macos_arm64_metal_release SOKOL_METAL    arm64
build_lib_debug   sokol dylib/sokol_dylib_macos_arm64_metal_debug   SOKOL_METAL    arm64
build_lib_release sokol dylib/sokol_dylib_macos_x64_metal_release   SOKOL_METAL    x86_64
build_lib_debug   sokol dylib/sokol_dylib_macos_x64_metal_debug     SOKOL_METAL    x86_64
build_lib_release sokol dylib/sokol_dylib_macos_arm64_gl_release    SOKOL_GLCORE arm64
build_lib_debug   sokol dylib/sokol_dylib_macos_arm64_gl_debug      SOKOL_GLCORE arm64
build_lib_release sokol dylib/sokol_dylib_macos_x64_gl_release      SOKOL_GLCORE x86_64
build_lib_debug   sokol dylib/sokol_dylib_macos_x64_gl_debug        SOKOL_GLCORE x86_64

rm *.o
