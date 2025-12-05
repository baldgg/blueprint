// machine generated, do not edit

package sokol_log

/*

    sokol_log.h -- common logging callback for sokol headers

    Project URL: https://github.com/floooh/sokol

    Example code: https://github.com/floooh/sokol-samples

    Do this:
        #define SOKOL_IMPL or
        #define SOKOL_LOG_IMPL
    before you include this file in *one* C or C++ file to create the
    implementation.

    Optionally provide the following defines when building the implementation:

    SOKOL_ASSERT(c)             - your own assert macro (default: assert(c))
    SOKOL_UNREACHABLE()         - a guard macro for unreachable code (default: assert(false))
    SOKOL_LOG_API_DECL          - public function declaration prefix (default: extern)
    SOKOL_API_DECL              - same as SOKOL_GFX_API_DECL
    SOKOL_API_IMPL              - public function implementation prefix (default: -)

    Optionally define the following for verbose output:

    SOKOL_DEBUG         - by default this is defined if NDEBUG is not defined


    OVERVIEW
    ========
    sokol_log.h provides a default logging callback for other sokol headers.

    To use the default log callback, just include sokol_log.h and provide
    a function pointer to the 'slog_func' function when setting up the
    sokol library:

    For instance with sokol_audio.h:

        #include "sokol_log.h"
        ...
        saudio_setup(&(saudio_desc){ .logger.func = slog_func });

    Logging output goes to stderr and/or a platform specific logging subsystem
    (which means that in some scenarios you might see logging messages duplicated):

        - Windows: stderr + OutputDebugStringA()
        - macOS/iOS/Linux: stderr + syslog()
        - Emscripten: console.info()/warn()/error()
        - Android: __android_log_write()

    On Windows with sokol_app.h also note the runtime config items to make
    stdout/stderr output visible on the console for WinMain() applications
    via sapp_desc.win32_console_attach or sapp_desc.win32_console_create,
    however when running in a debugger on Windows, the logging output should
    show up on the debug output UI panel.

    In debug mode, a log message might look like this:

        [sspine][error][id:12] /Users/floh/projects/sokol/util/sokol_spine.h:3472:0:
            SKELETON_DESC_NO_ATLAS: no atlas object provided in sspine_skeleton_desc.atlas

    The source path and line number is formatted like compiler errors, in some IDEs (like VSCode)
    such error messages are clickable.

    In release mode, logging is less verbose as to not bloat the executable with string data, but you still get
    enough information to identify the type and location of an error:

        [sspine][error][id:12][line:3472]

    RULES FOR WRITING YOUR OWN LOGGING FUNCTION
    ===========================================
    - must be re-entrant because it might be called from different threads
    - must treat **all** provided string pointers as optional (can be null)
    - don't store the string pointers, copy the string data instead
    - must not return for log level panic

    LICENSE
    =======
    zlib/libpng license

    Copyright (c) 2023 Andre Weissflog

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

import "core:c"

_ :: c

SOKOL_DEBUG :: #config(SOKOL_DEBUG, ODIN_DEBUG)

DEBUG :: #config(SOKOL_LOG_DEBUG, SOKOL_DEBUG)
USE_GL :: #config(SOKOL_USE_GL, false)
USE_DLL :: #config(SOKOL_DLL, false)

when ODIN_OS == .Windows {
    when USE_DLL {
        when USE_GL {
            when DEBUG { foreign import sokol_log_clib { "../sokol_dll_windows_x64_gl_debug.lib" } }
            else       { foreign import sokol_log_clib { "../sokol_dll_windows_x64_gl_release.lib" } }
        } else {
            when DEBUG { foreign import sokol_log_clib { "../sokol_dll_windows_x64_d3d11_debug.lib" } }
            else       { foreign import sokol_log_clib { "../sokol_dll_windows_x64_d3d11_release.lib" } }
        }
    } else {
        when USE_GL {
            when DEBUG { foreign import sokol_log_clib { "sokol_log_windows_x64_gl_debug.lib" } }
            else       { foreign import sokol_log_clib { "sokol_log_windows_x64_gl_release.lib" } }
        } else {
            when DEBUG { foreign import sokol_log_clib { "sokol_log_windows_x64_d3d11_debug.lib" } }
            else       { foreign import sokol_log_clib { "sokol_log_windows_x64_d3d11_release.lib" } }
        }
    }
} else when ODIN_OS == .Darwin {
    when USE_DLL {
             when  USE_GL && ODIN_ARCH == .arm64 &&  DEBUG { foreign import sokol_log_clib { "../dylib/sokol_dylib_macos_arm64_gl_debug.dylib" } }
        else when  USE_GL && ODIN_ARCH == .arm64 && !DEBUG { foreign import sokol_log_clib { "../dylib/sokol_dylib_macos_arm64_gl_release.dylib" } }
        else when  USE_GL && ODIN_ARCH == .amd64 &&  DEBUG { foreign import sokol_log_clib { "../dylib/sokol_dylib_macos_x64_gl_debug.dylib" } }
        else when  USE_GL && ODIN_ARCH == .amd64 && !DEBUG { foreign import sokol_log_clib { "../dylib/sokol_dylib_macos_x64_gl_release.dylib" } }
        else when !USE_GL && ODIN_ARCH == .arm64 &&  DEBUG { foreign import sokol_log_clib { "../dylib/sokol_dylib_macos_arm64_metal_debug.dylib" } }
        else when !USE_GL && ODIN_ARCH == .arm64 && !DEBUG { foreign import sokol_log_clib { "../dylib/sokol_dylib_macos_arm64_metal_release.dylib" } }
        else when !USE_GL && ODIN_ARCH == .amd64 &&  DEBUG { foreign import sokol_log_clib { "../dylib/sokol_dylib_macos_x64_metal_debug.dylib" } }
        else when !USE_GL && ODIN_ARCH == .amd64 && !DEBUG { foreign import sokol_log_clib { "../dylib/sokol_dylib_macos_x64_metal_release.dylib" } }
    } else {
        when USE_GL {
            when ODIN_ARCH == .arm64 {
                when DEBUG { foreign import sokol_log_clib { "sokol_log_macos_arm64_gl_debug.a" } }
                else       { foreign import sokol_log_clib { "sokol_log_macos_arm64_gl_release.a" } }
            } else {
                when DEBUG { foreign import sokol_log_clib { "sokol_log_macos_x64_gl_debug.a" } }
                else       { foreign import sokol_log_clib { "sokol_log_macos_x64_gl_release.a" } }
            }
        } else {
            when ODIN_ARCH == .arm64 {
                when DEBUG { foreign import sokol_log_clib { "sokol_log_macos_arm64_metal_debug.a" } }
                else       { foreign import sokol_log_clib { "sokol_log_macos_arm64_metal_release.a" } }
            } else {
                when DEBUG { foreign import sokol_log_clib { "sokol_log_macos_x64_metal_debug.a" } }
                else       { foreign import sokol_log_clib { "sokol_log_macos_x64_metal_release.a" } }
            }
        }
    }
} else when ODIN_OS == .Linux {
    when USE_DLL {
        when DEBUG { foreign import sokol_log_clib { "sokol_log_linux_x64_gl_debug.so" } }
        else       { foreign import sokol_log_clib { "sokol_log_linux_x64_gl_release.so" } }
    } else {
        when DEBUG { foreign import sokol_log_clib { "sokol_log_linux_x64_gl_debug.a" } }
        else       { foreign import sokol_log_clib { "sokol_log_linux_x64_gl_release.a" } }
    }
} else when ODIN_ARCH == .wasm32 || ODIN_ARCH == .wasm64p32 {
    // Feed sokol_log_wasm_gl_debug.a or sokol_log_wasm_gl_release.a into emscripten compiler.
    foreign import sokol_log_clib { "env.o" }
} else {
    #panic("This OS is currently not supported")
}

@(default_calling_convention="c", link_prefix="slog_")
foreign sokol_log_clib {
    /*
        Plug this function into the 'logger.func' struct item when initializing any of the sokol
        headers. For instance for sokol_audio.h it would look like this:

        saudio_setup(&(saudio_desc){
            .logger = {
                .func = slog_func
            }
        });
    */
    func :: proc(tag: cstring, log_level: u32, log_item: u32, message: cstring, line_nr: u32, filename: cstring, user_data: rawptr)  ---
}

