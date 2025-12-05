set -e

build_lib_arm64_release() {
    src=$1
    dst=$2
    backend=$3
    echo $dst
    MACOSX_DEPLOYMENT_TARGET=10.13 clang -c -O2 -x objective-c -arch arm64 -DNDEBUG -DIMPL -D$backend c/$src.c
    ar rcs $dst.a $src.o
}

build_lib_arm64_debug() {
    src=$1
    dst=$2
    backend=$3
    echo $dst
    MACOSX_DEPLOYMENT_TARGET=10.13 clang -c -g -x objective-c -arch arm64 -DIMPL -D$backend c/$src.c
    ar rcs $dst.a $src.o
}

build_lib_x64_release() {
    src=$1
    dst=$2
    backend=$3
    echo $dst
    MACOSX_DEPLOYMENT_TARGET=10.13 clang -c -O2 -x objective-c -arch x86_64 -DNDEBUG -DIMPL -D$backend c/$src.c
    ar rcs $dst.a $src.o
}

build_lib_x64_debug() {
    src=$1
    dst=$2
    backend=$3
    echo $dst
    MACOSX_DEPLOYMENT_TARGET=10.13 clang -c -g -x objective-c -arch x86_64 -DIMPL -D$backend c/$src.c
    ar rcs $dst.a $src.o
}

# ARM + Metal + Release
build_lib_arm64_release sokol_log         log/sokol_log_macos_arm64_metal_release SOKOL_METAL
build_lib_arm64_release sokol_gfx         gfx/sokol_gfx_macos_arm64_metal_release SOKOL_METAL
build_lib_arm64_release sokol_app         app/sokol_app_macos_arm64_metal_release SOKOL_METAL
build_lib_arm64_release sokol_glue        glue/sokol_glue_macos_arm64_metal_release SOKOL_METAL
build_lib_arm64_release sokol_time        time/sokol_time_macos_arm64_metal_release SOKOL_METAL
build_lib_arm64_release sokol_audio       audio/sokol_audio_macos_arm64_metal_release SOKOL_METAL
build_lib_arm64_release sokol_debugtext   debugtext/sokol_debugtext_macos_arm64_metal_release SOKOL_METAL
build_lib_arm64_release sokol_shape       shape/sokol_shape_macos_arm64_metal_release SOKOL_METAL
build_lib_arm64_release sokol_gl          gl/sokol_gl_macos_arm64_metal_release SOKOL_METAL

# ARM + Metal + Debug
build_lib_arm64_debug sokol_log           log/sokol_log_macos_arm64_metal_debug SOKOL_METAL
build_lib_arm64_debug sokol_gfx           gfx/sokol_gfx_macos_arm64_metal_debug SOKOL_METAL
build_lib_arm64_debug sokol_app           app/sokol_app_macos_arm64_metal_debug SOKOL_METAL
build_lib_arm64_debug sokol_glue          glue/sokol_glue_macos_arm64_metal_debug SOKOL_METAL
build_lib_arm64_debug sokol_time          time/sokol_time_macos_arm64_metal_debug SOKOL_METAL
build_lib_arm64_debug sokol_audio         audio/sokol_audio_macos_arm64_metal_debug SOKOL_METAL
build_lib_arm64_debug sokol_debugtext     debugtext/sokol_debugtext_macos_arm64_metal_debug SOKOL_METAL
build_lib_arm64_debug sokol_shape         shape/sokol_shape_macos_arm64_metal_debug SOKOL_METAL
build_lib_arm64_debug sokol_gl            gl/sokol_gl_macos_arm64_metal_debug SOKOL_METAL

# x64 + Metal + Release
build_lib_x64_release sokol_log         log/sokol_log_macos_x64_metal_release SOKOL_METAL
build_lib_x64_release sokol_gfx         gfx/sokol_gfx_macos_x64_metal_release SOKOL_METAL
build_lib_x64_release sokol_app         app/sokol_app_macos_x64_metal_release SOKOL_METAL
build_lib_x64_release sokol_glue        glue/sokol_glue_macos_x64_metal_release SOKOL_METAL
build_lib_x64_release sokol_time        time/sokol_time_macos_x64_metal_release SOKOL_METAL
build_lib_x64_release sokol_audio       audio/sokol_audio_macos_x64_metal_release SOKOL_METAL
build_lib_x64_release sokol_debugtext   debugtext/sokol_debugtext_macos_x64_metal_release SOKOL_METAL
build_lib_x64_release sokol_shape       shape/sokol_shape_macos_x64_metal_release SOKOL_METAL
build_lib_x64_release sokol_gl          gl/sokol_gl_macos_x64_metal_release SOKOL_METAL

# x64 + Metal + Debug
build_lib_x64_debug sokol_log           log/sokol_log_macos_x64_metal_debug SOKOL_METAL
build_lib_x64_debug sokol_gfx           gfx/sokol_gfx_macos_x64_metal_debug SOKOL_METAL
build_lib_x64_debug sokol_app           app/sokol_app_macos_x64_metal_debug SOKOL_METAL
build_lib_x64_debug sokol_glue          glue/sokol_glue_macos_x64_metal_debug SOKOL_METAL
build_lib_x64_debug sokol_time          time/sokol_time_macos_x64_metal_debug SOKOL_METAL
build_lib_x64_debug sokol_audio         audio/sokol_audio_macos_x64_metal_debug SOKOL_METAL
build_lib_x64_debug sokol_debugtext     debugtext/sokol_debugtext_macos_x64_metal_debug SOKOL_METAL
build_lib_x64_debug sokol_shape         shape/sokol_shape_macos_x64_metal_debug SOKOL_METAL
build_lib_x64_debug sokol_gl            gl/sokol_gl_macos_x64_metal_debug SOKOL_METAL

# ARM + GL + Release
build_lib_arm64_release sokol_log         log/sokol_log_macos_arm64_gl_release SOKOL_GLCORE
build_lib_arm64_release sokol_gfx         gfx/sokol_gfx_macos_arm64_gl_release SOKOL_GLCORE
build_lib_arm64_release sokol_app         app/sokol_app_macos_arm64_gl_release SOKOL_GLCORE
build_lib_arm64_release sokol_glue        glue/sokol_glue_macos_arm64_gl_release SOKOL_GLCORE
build_lib_arm64_release sokol_time        time/sokol_time_macos_arm64_gl_release SOKOL_GLCORE
build_lib_arm64_release sokol_audio       audio/sokol_audio_macos_arm64_gl_release SOKOL_GLCORE
build_lib_arm64_release sokol_debugtext   debugtext/sokol_debugtext_macos_arm64_gl_release SOKOL_GLCORE
build_lib_arm64_release sokol_shape       shape/sokol_shape_macos_arm64_gl_release SOKOL_GLCORE
build_lib_arm64_release sokol_gl          gl/sokol_gl_macos_arm64_gl_release SOKOL_GLCORE

# ARM + GL + Debug
build_lib_arm64_debug sokol_log           log/sokol_log_macos_arm64_gl_debug SOKOL_GLCORE
build_lib_arm64_debug sokol_gfx           gfx/sokol_gfx_macos_arm64_gl_debug SOKOL_GLCORE
build_lib_arm64_debug sokol_app           app/sokol_app_macos_arm64_gl_debug SOKOL_GLCORE
build_lib_arm64_debug sokol_glue          glue/sokol_glue_macos_arm64_gl_debug SOKOL_GLCORE
build_lib_arm64_debug sokol_time          time/sokol_time_macos_arm64_gl_debug SOKOL_GLCORE
build_lib_arm64_debug sokol_audio         audio/sokol_audio_macos_arm64_gl_debug SOKOL_GLCORE
build_lib_arm64_debug sokol_debugtext     debugtext/sokol_debugtext_macos_arm64_gl_debug SOKOL_GLCORE
build_lib_arm64_debug sokol_shape         shape/sokol_shape_macos_arm64_gl_debug SOKOL_GLCORE
build_lib_arm64_debug sokol_gl            gl/sokol_gl_macos_arm64_gl_debug SOKOL_GLCORE

# x64 + GL + Release
build_lib_x64_release sokol_log         log/sokol_log_macos_x64_gl_release SOKOL_GLCORE
build_lib_x64_release sokol_gfx         gfx/sokol_gfx_macos_x64_gl_release SOKOL_GLCORE
build_lib_x64_release sokol_app         app/sokol_app_macos_x64_gl_release SOKOL_GLCORE
build_lib_x64_release sokol_glue        glue/sokol_glue_macos_x64_gl_release SOKOL_GLCORE
build_lib_x64_release sokol_time        time/sokol_time_macos_x64_gl_release SOKOL_GLCORE
build_lib_x64_release sokol_audio       audio/sokol_audio_macos_x64_gl_release SOKOL_GLCORE
build_lib_x64_release sokol_debugtext   debugtext/sokol_debugtext_macos_x64_gl_release SOKOL_GLCORE
build_lib_x64_release sokol_shape       shape/sokol_shape_macos_x64_gl_release SOKOL_GLCORE
build_lib_x64_release sokol_gl          gl/sokol_gl_macos_x64_gl_release SOKOL_GLCORE

# x64 + GL + Debug
build_lib_x64_debug sokol_log           log/sokol_log_macos_x64_gl_debug SOKOL_GLCORE
build_lib_x64_debug sokol_gfx           gfx/sokol_gfx_macos_x64_gl_debug SOKOL_GLCORE
build_lib_x64_debug sokol_app           app/sokol_app_macos_x64_gl_debug SOKOL_GLCORE
build_lib_x64_debug sokol_glue          glue/sokol_glue_macos_x64_gl_debug SOKOL_GLCORE
build_lib_x64_debug sokol_time          time/sokol_time_macos_x64_gl_debug SOKOL_GLCORE
build_lib_x64_debug sokol_audio         audio/sokol_audio_macos_x64_gl_debug SOKOL_GLCORE
build_lib_x64_debug sokol_debugtext     debugtext/sokol_debugtext_macos_x64_gl_debug SOKOL_GLCORE
build_lib_x64_debug sokol_shape         shape/sokol_shape_macos_x64_gl_debug SOKOL_GLCORE
build_lib_x64_debug sokol_gl            gl/sokol_gl_macos_x64_gl_debug SOKOL_GLCORE

rm *.o
