// machine generated, do not edit

package sokol_time

/*

    sokol_time.h    -- simple cross-platform time measurement

    Project URL: https://github.com/floooh/sokol

    Do this:
        #define SOKOL_IMPL or
        #define SOKOL_TIME_IMPL
    before you include this file in *one* C or C++ file to create the
    implementation.

    Optionally provide the following defines with your own implementations:
    SOKOL_ASSERT(c)     - your own assert macro (default: assert(c))
    SOKOL_TIME_API_DECL - public function declaration prefix (default: extern)
    SOKOL_API_DECL      - same as SOKOL_TIME_API_DECL
    SOKOL_API_IMPL      - public function implementation prefix (default: -)

    If sokol_time.h is compiled as a DLL, define the following before
    including the declaration or implementation:

    SOKOL_DLL

    On Windows, SOKOL_DLL will define SOKOL_TIME_API_DECL as __declspec(dllexport)
    or __declspec(dllimport) as needed.

    void stm_setup();
        Call once before any other functions to initialize sokol_time
        (this calls for instance QueryPerformanceFrequency on Windows)

    uint64_t stm_now();
        Get current point in time in unspecified 'ticks'. The value that
        is returned has no relation to the 'wall-clock' time and is
        not in a specific time unit, it is only useful to compute
        time differences.

    uint64_t stm_diff(uint64_t new, uint64_t old);
        Computes the time difference between new and old. This will always
        return a positive, non-zero value.

    uint64_t stm_since(uint64_t start);
        Takes the current time, and returns the elapsed time since start
        (this is a shortcut for "stm_diff(stm_now(), start)")

    uint64_t stm_laptime(uint64_t* last_time);
        This is useful for measuring frame time and other recurring
        events. It takes the current time, returns the time difference
        to the value in last_time, and stores the current time in
        last_time for the next call. If the value in last_time is 0,
        the return value will be zero (this usually happens on the
        very first call).

    uint64_t stm_round_to_common_refresh_rate(uint64_t duration)
        This oddly named function takes a measured frame time and
        returns the closest "nearby" common display refresh rate frame duration
        in ticks. If the input duration isn't close to any common display
        refresh rate, the input duration will be returned unchanged as a fallback.
        The main purpose of this function is to remove jitter/inaccuracies from
        measured frame times, and instead use the display refresh rate as
        frame duration.
        NOTE: for more robust frame timing, consider using the
        sokol_app.h function sapp_frame_duration()

    Use the following functions to convert a duration in ticks into
    useful time units:

    double stm_sec(uint64_t ticks);
    double stm_ms(uint64_t ticks);
    double stm_us(uint64_t ticks);
    double stm_ns(uint64_t ticks);
        Converts a tick value into seconds, milliseconds, microseconds
        or nanoseconds. Note that not all platforms will have nanosecond
        or even microsecond precision.

    Uses the following time measurement functions under the hood:

    Windows:        QueryPerformanceFrequency() / QueryPerformanceCounter()
    MacOS/iOS:      mach_absolute_time()
    emscripten:     emscripten_get_now()
    Linux+others:   clock_gettime(CLOCK_MONOTONIC)

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

import "core:c"

_ :: c

SOKOL_DEBUG :: #config(SOKOL_DEBUG, ODIN_DEBUG)

DEBUG :: #config(SOKOL_TIME_DEBUG, SOKOL_DEBUG)
USE_GL :: #config(SOKOL_USE_GL, false)
USE_DLL :: #config(SOKOL_DLL, false)

when ODIN_OS == .Windows {
    when USE_DLL {
        when USE_GL {
            when DEBUG { foreign import sokol_time_clib { "../sokol_dll_windows_x64_gl_debug.lib" } }
            else       { foreign import sokol_time_clib { "../sokol_dll_windows_x64_gl_release.lib" } }
        } else {
            when DEBUG { foreign import sokol_time_clib { "../sokol_dll_windows_x64_d3d11_debug.lib" } }
            else       { foreign import sokol_time_clib { "../sokol_dll_windows_x64_d3d11_release.lib" } }
        }
    } else {
        when USE_GL {
            when DEBUG { foreign import sokol_time_clib { "sokol_time_windows_x64_gl_debug.lib" } }
            else       { foreign import sokol_time_clib { "sokol_time_windows_x64_gl_release.lib" } }
        } else {
            when DEBUG { foreign import sokol_time_clib { "sokol_time_windows_x64_d3d11_debug.lib" } }
            else       { foreign import sokol_time_clib { "sokol_time_windows_x64_d3d11_release.lib" } }
        }
    }
} else when ODIN_OS == .Darwin {
    when USE_DLL {
             when  USE_GL && ODIN_ARCH == .arm64 &&  DEBUG { foreign import sokol_time_clib { "../dylib/sokol_dylib_macos_arm64_gl_debug.dylib" } }
        else when  USE_GL && ODIN_ARCH == .arm64 && !DEBUG { foreign import sokol_time_clib { "../dylib/sokol_dylib_macos_arm64_gl_release.dylib" } }
        else when  USE_GL && ODIN_ARCH == .amd64 &&  DEBUG { foreign import sokol_time_clib { "../dylib/sokol_dylib_macos_x64_gl_debug.dylib" } }
        else when  USE_GL && ODIN_ARCH == .amd64 && !DEBUG { foreign import sokol_time_clib { "../dylib/sokol_dylib_macos_x64_gl_release.dylib" } }
        else when !USE_GL && ODIN_ARCH == .arm64 &&  DEBUG { foreign import sokol_time_clib { "../dylib/sokol_dylib_macos_arm64_metal_debug.dylib" } }
        else when !USE_GL && ODIN_ARCH == .arm64 && !DEBUG { foreign import sokol_time_clib { "../dylib/sokol_dylib_macos_arm64_metal_release.dylib" } }
        else when !USE_GL && ODIN_ARCH == .amd64 &&  DEBUG { foreign import sokol_time_clib { "../dylib/sokol_dylib_macos_x64_metal_debug.dylib" } }
        else when !USE_GL && ODIN_ARCH == .amd64 && !DEBUG { foreign import sokol_time_clib { "../dylib/sokol_dylib_macos_x64_metal_release.dylib" } }
    } else {
        when USE_GL {
            when ODIN_ARCH == .arm64 {
                when DEBUG { foreign import sokol_time_clib { "sokol_time_macos_arm64_gl_debug.a" } }
                else       { foreign import sokol_time_clib { "sokol_time_macos_arm64_gl_release.a" } }
            } else {
                when DEBUG { foreign import sokol_time_clib { "sokol_time_macos_x64_gl_debug.a" } }
                else       { foreign import sokol_time_clib { "sokol_time_macos_x64_gl_release.a" } }
            }
        } else {
            when ODIN_ARCH == .arm64 {
                when DEBUG { foreign import sokol_time_clib { "sokol_time_macos_arm64_metal_debug.a" } }
                else       { foreign import sokol_time_clib { "sokol_time_macos_arm64_metal_release.a" } }
            } else {
                when DEBUG { foreign import sokol_time_clib { "sokol_time_macos_x64_metal_debug.a" } }
                else       { foreign import sokol_time_clib { "sokol_time_macos_x64_metal_release.a" } }
            }
        }
    }
} else when ODIN_OS == .Linux {
    when USE_DLL {
        when DEBUG { foreign import sokol_time_clib { "sokol_time_linux_x64_gl_debug.so" } }
        else       { foreign import sokol_time_clib { "sokol_time_linux_x64_gl_release.so" } }
    } else {
        when DEBUG { foreign import sokol_time_clib { "sokol_time_linux_x64_gl_debug.a" } }
        else       { foreign import sokol_time_clib { "sokol_time_linux_x64_gl_release.a" } }
    }
} else when ODIN_ARCH == .wasm32 || ODIN_ARCH == .wasm64p32 {
    // Feed sokol_time_wasm_gl_debug.a or sokol_time_wasm_gl_release.a into emscripten compiler.
    foreign import sokol_time_clib { "env.o" }
} else {
    #panic("This OS is currently not supported")
}

@(default_calling_convention="c", link_prefix="stm_")
foreign sokol_time_clib {
    setup :: proc()  ---
    now :: proc() -> u64 ---
    diff :: proc(new_ticks: u64, old_ticks: u64) -> u64 ---
    since :: proc(start_ticks: u64) -> u64 ---
    laptime :: proc(last_time: ^u64) -> u64 ---
    round_to_common_refresh_rate :: proc(frame_ticks: u64) -> u64 ---
    sec :: proc(ticks: u64) -> f64 ---
    ms :: proc(ticks: u64) -> f64 ---
    us :: proc(ticks: u64) -> f64 ---
    ns :: proc(ticks: u64) -> f64 ---
}

