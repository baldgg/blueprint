// machine generated, do not edit

package sokol_glue

/*

    sokol_glue.h -- glue helper functions for sokol headers

    Project URL: https://github.com/floooh/sokol

    Do this:
        #define SOKOL_IMPL or
        #define SOKOL_GLUE_IMPL
    before you include this file in *one* C or C++ file to create the
    implementation.

    ...optionally provide the following macros to override defaults:

    SOKOL_ASSERT(c)     - your own assert macro (default: assert(c))
    SOKOL_GLUE_API_DECL - public function declaration prefix (default: extern)
    SOKOL_API_DECL      - same as SOKOL_GLUE_API_DECL
    SOKOL_API_IMPL      - public function implementation prefix (default: -)

    If sokol_glue.h is compiled as a DLL, define the following before
    including the declaration or implementation:

    SOKOL_DLL

    On Windows, SOKOL_DLL will define SOKOL_GLUE_API_DECL as __declspec(dllexport)
    or __declspec(dllimport) as needed.

    OVERVIEW
    ========
    sokol_glue.h provides glue helper functions between sokol_gfx.h and sokol_app.h,
    so that sokol_gfx.h doesn't need to depend on sokol_app.h but can be
    used with different window system glue libraries.

    PROVIDED FUNCTIONS
    ==================

    sg_environment sglue_environment(void)

        Returns an sg_environment struct initialized by calling sokol_app.h
        functions. Use this in the sg_setup() call like this:

        sg_setup(&(sg_desc){
            .environment = sglue_environment(),
            ...
        });

    sg_swapchain sglue_swapchain(void)

        Returns an sg_swapchain struct initialized by calling sokol_app.h
        functions. Use this in sg_begin_pass() for a 'swapchain pass' like
        this:

        sg_begin_pass(&(sg_pass){ .swapchain = sglue_swapchain(), ... });

    LICENSE
    =======
    zlib/libpng license

    Copyright (c) 2018 Andre Weissflog

    This software is provided 'as-is', without any express or implied warranty.
    In no event will the authors be held liable for any damages arising from the
    use of this software.

    Permission is granted to anyone to use this software for any purpose,
    including commercial applications, and to alter it and redistribute it
    freely, subject to the following restrictions:

        1. The origin of this software must not be misrepresented; you must not
        claim that you wrote the original software. If you use this software in a
        product, an acknowledgment in the product documentation would be
        appreciated but is not required.

        2. Altered source versions must be plainly marked as such, and must not
        be misrepresented as being the original software.

        3. This notice may not be removed or altered from any source
        distribution.

*/
import sg "../gfx"

import "core:c"

_ :: c

SOKOL_DEBUG :: #config(SOKOL_DEBUG, ODIN_DEBUG)

DEBUG :: #config(SOKOL_GLUE_DEBUG, SOKOL_DEBUG)
USE_GL :: #config(SOKOL_USE_GL, false)
USE_DLL :: #config(SOKOL_DLL, false)

when ODIN_OS == .Windows {
    when USE_DLL {
        when USE_GL {
            when DEBUG { foreign import sokol_glue_clib { "../sokol_dll_windows_x64_gl_debug.lib" } }
            else       { foreign import sokol_glue_clib { "../sokol_dll_windows_x64_gl_release.lib" } }
        } else {
            when DEBUG { foreign import sokol_glue_clib { "../sokol_dll_windows_x64_d3d11_debug.lib" } }
            else       { foreign import sokol_glue_clib { "../sokol_dll_windows_x64_d3d11_release.lib" } }
        }
    } else {
        when USE_GL {
            when DEBUG { foreign import sokol_glue_clib { "sokol_glue_windows_x64_gl_debug.lib" } }
            else       { foreign import sokol_glue_clib { "sokol_glue_windows_x64_gl_release.lib" } }
        } else {
            when DEBUG { foreign import sokol_glue_clib { "sokol_glue_windows_x64_d3d11_debug.lib" } }
            else       { foreign import sokol_glue_clib { "sokol_glue_windows_x64_d3d11_release.lib" } }
        }
    }
} else when ODIN_OS == .Darwin {
    when USE_DLL {
             when  USE_GL && ODIN_ARCH == .arm64 &&  DEBUG { foreign import sokol_glue_clib { "../dylib/sokol_dylib_macos_arm64_gl_debug.dylib" } }
        else when  USE_GL && ODIN_ARCH == .arm64 && !DEBUG { foreign import sokol_glue_clib { "../dylib/sokol_dylib_macos_arm64_gl_release.dylib" } }
        else when  USE_GL && ODIN_ARCH == .amd64 &&  DEBUG { foreign import sokol_glue_clib { "../dylib/sokol_dylib_macos_x64_gl_debug.dylib" } }
        else when  USE_GL && ODIN_ARCH == .amd64 && !DEBUG { foreign import sokol_glue_clib { "../dylib/sokol_dylib_macos_x64_gl_release.dylib" } }
        else when !USE_GL && ODIN_ARCH == .arm64 &&  DEBUG { foreign import sokol_glue_clib { "../dylib/sokol_dylib_macos_arm64_metal_debug.dylib" } }
        else when !USE_GL && ODIN_ARCH == .arm64 && !DEBUG { foreign import sokol_glue_clib { "../dylib/sokol_dylib_macos_arm64_metal_release.dylib" } }
        else when !USE_GL && ODIN_ARCH == .amd64 &&  DEBUG { foreign import sokol_glue_clib { "../dylib/sokol_dylib_macos_x64_metal_debug.dylib" } }
        else when !USE_GL && ODIN_ARCH == .amd64 && !DEBUG { foreign import sokol_glue_clib { "../dylib/sokol_dylib_macos_x64_metal_release.dylib" } }
    } else {
        when USE_GL {
            when ODIN_ARCH == .arm64 {
                when DEBUG { foreign import sokol_glue_clib { "sokol_glue_macos_arm64_gl_debug.a" } }
                else       { foreign import sokol_glue_clib { "sokol_glue_macos_arm64_gl_release.a" } }
            } else {
                when DEBUG { foreign import sokol_glue_clib { "sokol_glue_macos_x64_gl_debug.a" } }
                else       { foreign import sokol_glue_clib { "sokol_glue_macos_x64_gl_release.a" } }
            }
        } else {
            when ODIN_ARCH == .arm64 {
                when DEBUG { foreign import sokol_glue_clib { "sokol_glue_macos_arm64_metal_debug.a" } }
                else       { foreign import sokol_glue_clib { "sokol_glue_macos_arm64_metal_release.a" } }
            } else {
                when DEBUG { foreign import sokol_glue_clib { "sokol_glue_macos_x64_metal_debug.a" } }
                else       { foreign import sokol_glue_clib { "sokol_glue_macos_x64_metal_release.a" } }
            }
        }
    }
} else when ODIN_OS == .Linux {
    when USE_DLL {
        when DEBUG { foreign import sokol_glue_clib { "sokol_glue_linux_x64_gl_debug.so" } }
        else       { foreign import sokol_glue_clib { "sokol_glue_linux_x64_gl_release.so" } }
    } else {
        when DEBUG { foreign import sokol_glue_clib { "sokol_glue_linux_x64_gl_debug.a" } }
        else       { foreign import sokol_glue_clib { "sokol_glue_linux_x64_gl_release.a" } }
    }
} else when ODIN_ARCH == .wasm32 || ODIN_ARCH == .wasm64p32 {
    // Feed sokol_glue_wasm_gl_debug.a or sokol_glue_wasm_gl_release.a into emscripten compiler.
    foreign import sokol_glue_clib { "env.o" }
} else {
    #panic("This OS is currently not supported")
}

@(default_calling_convention="c", link_prefix="sglue_")
foreign sokol_glue_clib {
    environment :: proc() -> sg.Environment ---
    swapchain :: proc() -> sg.Swapchain ---
}

