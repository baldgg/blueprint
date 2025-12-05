// machine generated, do not edit

package sokol_debugtext

/*

    sokol_debugtext.h   - simple ASCII debug text rendering on top of sokol_gfx.h

    Project URL: https://github.com/floooh/sokol

    Do this:
        #define SOKOL_IMPL or
        #define SOKOL_DEBUGTEXT_IMPL
    before you include this file in *one* C or C++ file to create the
    implementation.

    The following defines are used by the implementation to select the
    platform-specific embedded shader code (these are the same defines as
    used by sokol_gfx.h and sokol_app.h):

    SOKOL_GLCORE
    SOKOL_GLES3
    SOKOL_D3D11
    SOKOL_METAL
    SOKOL_WGPU

    ...optionally provide the following macros to override defaults:

    SOKOL_VSNPRINTF     - the function name of an alternative vsnprintf() function (default: vsnprintf)
    SOKOL_ASSERT(c)     - your own assert macro (default: assert(c))
    SOKOL_DEBUGTEXT_API_DECL    - public function declaration prefix (default: extern)
    SOKOL_API_DECL      - same as SOKOL_DEBUGTEXT_API_DECL
    SOKOL_API_IMPL      - public function implementation prefix (default: -)
    SOKOL_UNREACHABLE() - a guard macro for unreachable code (default: assert(false))

    If sokol_debugtext.h is compiled as a DLL, define the following before
    including the declaration or implementation:

    SOKOL_DLL

    On Windows, SOKOL_DLL will define SOKOL_DEBUGTEXT_API_DECL as __declspec(dllexport)
    or __declspec(dllimport) as needed.

    Include the following headers before including sokol_debugtext.h:

        sokol_gfx.h

    FEATURES AND CONCEPTS
    =====================
    - renders 8-bit ASCII text as fixed-size 8x8 pixel characters
    - comes with 6 embedded 8-bit home computer fonts (each taking up 2 KBytes)
    - easily plug in your own fonts
    - create multiple contexts for rendering text in different layers or render passes

    STEP BY STEP
    ============

    --- to initialize sokol-debugtext, call sdtx_setup() *after* initializing
        sokol-gfx:

            sdtx_setup(&(sdtx_desc_t){ ... });

        To see any warnings and errors, you should always install a logging callback.
        The easiest way is via sokol_log.h:

            #include "sokol_log.h"

            sdtx_setup(&(sdtx_desc_t){
                .logger.func = slog_func,
            });

    --- configure sokol-debugtext by populating the sdtx_desc_t struct:

        .context_pool_size (default: 8)
            The max number of text contexts that can be created.

        .printf_buf_size (default: 4096)
            The size of the internal text formatting buffer used by
            sdtx_printf() and sdtx_vprintf().

        .fonts (default: none)
            An array of sdtx_font_desc_t structs used to configure the
            fonts that can be used for rendering. To use all builtin
            fonts call sdtx_setup() like this (in C99):

            sdtx_setup(&(sdtx_desc_t){
                .fonts = {
                    [0] = sdtx_font_kc853(),
                    [1] = sdtx_font_kc854(),
                    [2] = sdtx_font_z1013(),
                    [3] = sdtx_font_cpc(),
                    [4] = sdtx_font_c64(),
                    [5] = sdtx_font_oric()
                }
            });

            For documentation on how to use you own font data, search
            below for "USING YOUR OWN FONT DATA".

        .context
            The setup parameters for the default text context. This will
            be active right after sdtx_setup(), or when calling
            sdtx_set_context(SDTX_DEFAULT_CONTEXT):

            .max_commands (default: 4096)
                The max number of render commands that can be recorded
                into the internal command buffer. This directly translates
                to the number of render layer changes in a single frame.

            .char_buf_size (default: 4096)
                The number of characters that can be rendered per frame in this
                context, defines the size of an internal fixed-size vertex
                buffer.  Any additional characters will be silently ignored.

            .canvas_width (default: 640)
            .canvas_height (default: 480)
                The 'virtual canvas size' in pixels. This defines how big
                characters will be rendered relative to the default framebuffer
                dimensions. Each character occupies a grid of 8x8 'virtual canvas
                pixels' (so a virtual canvas size of 640x480 means that 80x60 characters
                fit on the screen). For rendering in a resizeable window, you
                should dynamically update the canvas size in each frame by
                calling sdtx_canvas(w, h).

            .tab_width (default: 4)
                The width of a tab character in number of character cells.

            .color_format (default: 0)
            .depth_format (default: 0)
            .sample_count (default: 0)
                The pixel format description for the default context needed
                for creating the context's sg_pipeline object. When
                rendering to the default framebuffer you can leave those
                zero-initialized, in this case the proper values will be
                filled in by sokol-gfx. You only need to provide non-default
                values here when rendering to render targets with different
                pixel format attributes than the default framebuffer.

    --- Before starting to render text, optionally call sdtx_canvas() to
        dynamically resize the virtual canvas. This is recommended when
        rendering to a resizeable window. The virtual canvas size can
        also be used to scale text in relation to the display resolution.

        Examples when using sokol-app:

        - to render characters at 8x8 'physical pixels':

            sdtx_canvas(sapp_width(), sapp_height());

        - to render characters at 16x16 physical pixels:

            sdtx_canvas(sapp_width()/2.0f, sapp_height()/2.0f);

        Do *not* use integer math here, since this will not look nice
        when the render target size isn't divisible by 2.

    --- Optionally define the origin for the character grid with:

            sdtx_origin(x, y);

        The provided coordinates are in character grid cells, not in
        virtual canvas pixels. E.g. to set the origin to 2 character tiles
        from the left and top border:

            sdtx_origin(2, 2);

        You can define fractions, e.g. to start rendering half
        a character tile from the top-left corner:

            sdtx_origin(0.5f, 0.5f);

    --- Optionally set a different font by calling:

            sdtx_font(font_index)

        sokol-debugtext provides 8 font slots which can be populated
        with the builtin fonts or with user-provided font data, so
        'font_index' must be a number from 0 to 7.

    --- Position the text cursor with one of the following calls. All arguments
        are in character grid cells as floats and relative to the
        origin defined with sdtx_origin():

            sdtx_pos(x, y)      - sets absolute cursor position
            sdtx_pos_x(x)       - only set absolute x cursor position
            sdtx_pos_y(y)       - only set absolute y cursor position

            sdtx_move(x, y)     - move cursor relative in x and y direction
            sdtx_move_x(x)      - move cursor relative only in x direction
            sdtx_move_y(y)      - move cursor relative only in y direction

            sdtx_crlf()         - set cursor to beginning of next line
                                  (same as sdtx_pos_x(0) + sdtx_move_y(1))
            sdtx_home()         - resets the cursor to the origin
                                  (same as sdtx_pos(0, 0))

    --- Set a new text color with any of the following functions:

            sdtx_color3b(r, g, b)       - RGB 0..255, A=255
            sdtx_color3f(r, g, b)       - RGB 0.0f..1.0f, A=1.0f
            sdtx_color4b(r, g, b, a)    - RGBA 0..255
            sdtx_color4f(r, g, b, a)    - RGBA 0.0f..1.0f
            sdtx_color1i(uint32_t rgba) - ABGR (0xAABBGGRR)

    --- Output 8-bit ASCII text with the following functions:

            sdtx_putc(c)             - output a single character

            sdtx_puts(str)           - output a null-terminated C string, note that
                                       this will *not* append a newline (so it behaves
                                       differently than the CRT's puts() function)

            sdtx_putr(str, len)     - 'put range' output the first 'len' characters of
                                       a C string or until the zero character is encountered

            sdtx_printf(fmt, ...)   - output with printf-formatting, note that you
                                      can inject your own printf-compatible function
                                      by overriding the SOKOL_VSNPRINTF define before
                                      including the implementation

            sdtx_vprintf(fmt, args) - same as sdtx_printf() but with the arguments
                                      provided in a va_list

        - Note that the text will not yet be rendered, only recorded for rendering
          at a later time, the actual rendering happens when sdtx_draw() is called
          inside a sokol-gfx render pass.
        - This means also you can output text anywhere in the frame, it doesn't
          have to be inside a render pass.
        - Note that character codes <32 are reserved as control characters
          and won't render anything. Currently only the following control
          characters are implemented:

            \r  - carriage return (same as sdtx_pos_x(0))
            \n  - carriage return + line feed (same as stdx_crlf())
            \t  - a tab character

    --- You can 'record' text into render layers, this allows to mix/interleave
        sokol-debugtext rendering with other rendering operations inside
        sokol-gfx render passes. To start recording text into a different render
        layer, call:

            sdtx_layer(int layer_id)

        ...outside a sokol-gfx render pass.

    --- finally, from within a sokol-gfx render pass, call:

            sdtx_draw()

        ...for non-layered rendering, or to draw a specific layer:

            sdtx_draw_layer(int layer_id)

        NOTE that sdtx_draw() is equivalent to:

            sdtx_draw_layer(0)

        ...so sdtx_draw() will *NOT* render all text layers, instead it will
        only render the 'default layer' 0.

    --- at the end of a frame (defined by the call to sg_commit()), sokol-debugtext
        will rewind all contexts:

            - the internal vertex index is set to 0
            - the internal command index is set to 0
            - the current layer id is set to 0
            - the current font is set to 0
            - the cursor position is reset


    RENDERING WITH MULTIPLE CONTEXTS
    ================================
    Use multiple text contexts if you need to render debug text in different
    sokol-gfx render passes, or want to render text to different layers
    in the same render pass, each with its own set of parameters.

    To create a new text context call:

        sdtx_context ctx = sdtx_make_context(&(sdtx_context_desc_t){ ... });

    The creation parameters in the sdtx_context_desc_t struct are the same
    as already described above in the sdtx_setup() function:

        .char_buf_size      -- max number of characters rendered in one frame, default: 4096
        .canvas_width       -- the initial virtual canvas width, default: 640
        .canvas_height      -- the initial virtual canvas height, default: 400
        .tab_width          -- tab width in number of characters, default: 4
        .color_format       -- color pixel format of target render pass
        .depth_format       -- depth pixel format of target render pass
        .sample_count       -- MSAA sample count of target render pass

    To make a new context the active context, call:

        sdtx_set_context(ctx)

    ...and after that call the text output functions as described above, and
    finally, inside a sokol-gfx render pass, call sdtx_draw() to actually
    render the text for this context.

    A context keeps track of the following parameters:

        - the active font
        - the virtual canvas size
        - the origin position
        - the current cursor position
        - the current tab width
        - the current color
        - and the current layer-id

    You can get the currently active context with:

        sdtx_get_context()

    To make the default context current, call sdtx_set_context() with the
    special SDTX_DEFAULT_CONTEXT handle:

        sdtx_set_context(SDTX_DEFAULT_CONTEXT)

    Alternatively, use the function sdtx_default_context() to get the default
    context handle:

        sdtx_set_context(sdtx_default_context());

    To destroy a context, call:

        sdtx_destroy_context(ctx)

    If a context is set as active that no longer exists, all sokol-debugtext
    functions that require an active context will silently fail.

    You can directly draw the recorded text in a specific context without
    setting the active context:

        sdtx_context_draw(ctx)
        sdtx_context_draw_layer(ctx, layer_id)

    USING YOUR OWN FONT DATA
    ========================

    Instead of the built-in fonts you can also plug your own font data
    into sokol-debugtext by providing one or several sdtx_font_desc_t
    structures in the sdtx_setup call.

    For instance to use a built-in font at slot 0, and a user-font at
    font slot 1, the sdtx_setup() call might look like this:

        sdtx_setup(&sdtx_desc_t){
            .fonts = {
                [0] = sdtx_font_kc853(),
                [1] = {
                    .data = {
                        .ptr = my_font_data,
                        .size = sizeof(my_font_data)
                    },
                    .first_char = ...,
                    .last_char = ...
                }
            }
        });

    Where 'my_font_data' is a byte array where every character is described
    by 8 bytes arranged like this:

        bits
        7 6 5 4 3 2 1 0
        . . . X X . . .     byte 0: 0x18
        . . X X X X . .     byte 1: 0x3C
        . X X . . X X .     byte 2: 0x66
        . X X . . X X .     byte 3: 0x66
        . X X X X X X .     byte 4: 0x7E
        . X X . . X X .     byte 5: 0x66
        . X X . . X X .     byte 6: 0x66
        . . . . . . . .     byte 7: 0x00

    A complete font consists of 256 characters, resulting in 2048 bytes for
    the font data array (but note that the character codes 0..31 will never
    be rendered).

    If you provide such a complete font data array, you can drop the .first_char
    and .last_char initialization parameters since those default to 0 and 255,
    note that you can also use the SDTX_RANGE() helper macro to build the
    .data item:

        sdtx_setup(&sdtx_desc_t){
            .fonts = {
                [0] = sdtx_font_kc853(),
                [1] = {
                    .data = SDTX_RANGE(my_font_data)
                }
            }
        });

    If the font doesn't define all 256 character tiles, or you don't need an
    entire 256-character font and want to save a couple of bytes, use the
    .first_char and .last_char initialization parameters to define a sub-range.
    For instance if the font only contains the characters between the Space
    (ASCII code 32) and uppercase character 'Z' (ASCII code 90):

        sdtx_setup(&sdtx_desc_t){
            .fonts = {
                [0] = sdtx_font_kc853(),
                [1] = {
                    .data = SDTX_RANGE(my_font_data),
                    .first_char = 32,       // could also write ' '
                    .last_char = 90         // could also write 'Z'
                }
            }
        });

    Character tiles that haven't been defined in the font will be rendered
    as a solid 8x8 quad.


    MEMORY ALLOCATION OVERRIDE
    ==========================
    You can override the memory allocation functions at initialization time
    like this:

        void* my_alloc(size_t size, void* user_data) {
            return malloc(size);
        }

        void my_free(void* ptr, void* user_data) {
            free(ptr);
        }

        ...
            sdtx_setup(&(sdtx_desc_t){
                // ...
                .allocator = {
                    .alloc_fn = my_alloc,
                    .free_fn = my_free,
                    .user_data = ...;
                }
            });
        ...

    If no overrides are provided, malloc and free will be used.


    ERROR REPORTING AND LOGGING
    ===========================
    To get any logging information at all you need to provide a logging callback in the setup call,
    the easiest way is to use sokol_log.h:

        #include "sokol_log.h"

        sdtx_setup(&(sdtx_desc_t){
            // ...
            .logger.func = slog_func
        });

    To override logging with your own callback, first write a logging function like this:

        void my_log(const char* tag,                // e.g. 'sdtx'
                    uint32_t log_level,             // 0=panic, 1=error, 2=warn, 3=info
                    uint32_t log_item_id,           // SDTX_LOGITEM_*
                    const char* message_or_null,    // a message string, may be nullptr in release mode
                    uint32_t line_nr,               // line number in sokol_debugtext.h
                    const char* filename_or_null,   // source filename, may be nullptr in release mode
                    void* user_data)
        {
            ...
        }

    ...and then setup sokol-debugtext like this:

        sdtx_setup(&(sdtx_desc_t){
            .logger = {
                .func = my_log,
                .user_data = my_user_data,
            }
        });

    The provided logging function must be reentrant (e.g. be callable from
    different threads).

    If you don't want to provide your own custom logger it is highly recommended to use
    the standard logger in sokol_log.h instead, otherwise you won't see any warnings or
    errors.


    LICENSE
    =======
    zlib/libpng license

    Copyright (c) 2020 Andre Weissflog

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

import "core:fmt"
import "core:strings"
printf :: proc(s: string, args: ..any) {
    fstr := fmt.tprintf(s, ..args)
    putr(strings.unsafe_string_to_cstring(fstr), len(fstr))
}
import "core:c"

_ :: c

SOKOL_DEBUG :: #config(SOKOL_DEBUG, ODIN_DEBUG)

DEBUG :: #config(SOKOL_DEBUGTEXT_DEBUG, SOKOL_DEBUG)
USE_GL :: #config(SOKOL_USE_GL, false)
USE_DLL :: #config(SOKOL_DLL, false)

when ODIN_OS == .Windows {
    when USE_DLL {
        when USE_GL {
            when DEBUG { foreign import sokol_debugtext_clib { "../sokol_dll_windows_x64_gl_debug.lib" } }
            else       { foreign import sokol_debugtext_clib { "../sokol_dll_windows_x64_gl_release.lib" } }
        } else {
            when DEBUG { foreign import sokol_debugtext_clib { "../sokol_dll_windows_x64_d3d11_debug.lib" } }
            else       { foreign import sokol_debugtext_clib { "../sokol_dll_windows_x64_d3d11_release.lib" } }
        }
    } else {
        when USE_GL {
            when DEBUG { foreign import sokol_debugtext_clib { "sokol_debugtext_windows_x64_gl_debug.lib" } }
            else       { foreign import sokol_debugtext_clib { "sokol_debugtext_windows_x64_gl_release.lib" } }
        } else {
            when DEBUG { foreign import sokol_debugtext_clib { "sokol_debugtext_windows_x64_d3d11_debug.lib" } }
            else       { foreign import sokol_debugtext_clib { "sokol_debugtext_windows_x64_d3d11_release.lib" } }
        }
    }
} else when ODIN_OS == .Darwin {
    when USE_DLL {
             when  USE_GL && ODIN_ARCH == .arm64 &&  DEBUG { foreign import sokol_debugtext_clib { "../dylib/sokol_dylib_macos_arm64_gl_debug.dylib" } }
        else when  USE_GL && ODIN_ARCH == .arm64 && !DEBUG { foreign import sokol_debugtext_clib { "../dylib/sokol_dylib_macos_arm64_gl_release.dylib" } }
        else when  USE_GL && ODIN_ARCH == .amd64 &&  DEBUG { foreign import sokol_debugtext_clib { "../dylib/sokol_dylib_macos_x64_gl_debug.dylib" } }
        else when  USE_GL && ODIN_ARCH == .amd64 && !DEBUG { foreign import sokol_debugtext_clib { "../dylib/sokol_dylib_macos_x64_gl_release.dylib" } }
        else when !USE_GL && ODIN_ARCH == .arm64 &&  DEBUG { foreign import sokol_debugtext_clib { "../dylib/sokol_dylib_macos_arm64_metal_debug.dylib" } }
        else when !USE_GL && ODIN_ARCH == .arm64 && !DEBUG { foreign import sokol_debugtext_clib { "../dylib/sokol_dylib_macos_arm64_metal_release.dylib" } }
        else when !USE_GL && ODIN_ARCH == .amd64 &&  DEBUG { foreign import sokol_debugtext_clib { "../dylib/sokol_dylib_macos_x64_metal_debug.dylib" } }
        else when !USE_GL && ODIN_ARCH == .amd64 && !DEBUG { foreign import sokol_debugtext_clib { "../dylib/sokol_dylib_macos_x64_metal_release.dylib" } }
    } else {
        when USE_GL {
            when ODIN_ARCH == .arm64 {
                when DEBUG { foreign import sokol_debugtext_clib { "sokol_debugtext_macos_arm64_gl_debug.a" } }
                else       { foreign import sokol_debugtext_clib { "sokol_debugtext_macos_arm64_gl_release.a" } }
            } else {
                when DEBUG { foreign import sokol_debugtext_clib { "sokol_debugtext_macos_x64_gl_debug.a" } }
                else       { foreign import sokol_debugtext_clib { "sokol_debugtext_macos_x64_gl_release.a" } }
            }
        } else {
            when ODIN_ARCH == .arm64 {
                when DEBUG { foreign import sokol_debugtext_clib { "sokol_debugtext_macos_arm64_metal_debug.a" } }
                else       { foreign import sokol_debugtext_clib { "sokol_debugtext_macos_arm64_metal_release.a" } }
            } else {
                when DEBUG { foreign import sokol_debugtext_clib { "sokol_debugtext_macos_x64_metal_debug.a" } }
                else       { foreign import sokol_debugtext_clib { "sokol_debugtext_macos_x64_metal_release.a" } }
            }
        }
    }
} else when ODIN_OS == .Linux {
    when USE_DLL {
        when DEBUG { foreign import sokol_debugtext_clib { "sokol_debugtext_linux_x64_gl_debug.so" } }
        else       { foreign import sokol_debugtext_clib { "sokol_debugtext_linux_x64_gl_release.so" } }
    } else {
        when DEBUG { foreign import sokol_debugtext_clib { "sokol_debugtext_linux_x64_gl_debug.a" } }
        else       { foreign import sokol_debugtext_clib { "sokol_debugtext_linux_x64_gl_release.a" } }
    }
} else when ODIN_ARCH == .wasm32 || ODIN_ARCH == .wasm64p32 {
    // Feed sokol_debugtext_wasm_gl_debug.a or sokol_debugtext_wasm_gl_release.a into emscripten compiler.
    foreign import sokol_debugtext_clib { "env.o" }
} else {
    #panic("This OS is currently not supported")
}

@(default_calling_convention="c", link_prefix="sdtx_")
foreign sokol_debugtext_clib {
    // initialization/shutdown
    setup :: proc(#by_ptr desc: Desc)  ---
    shutdown :: proc()  ---
    // builtin font data (use to populate sdtx_desc.font[])
    font_kc853 :: proc() -> Font_Desc ---
    font_kc854 :: proc() -> Font_Desc ---
    font_z1013 :: proc() -> Font_Desc ---
    font_cpc :: proc() -> Font_Desc ---
    font_c64 :: proc() -> Font_Desc ---
    font_oric :: proc() -> Font_Desc ---
    // context functions
    make_context :: proc(#by_ptr desc: Context_Desc) -> Context ---
    destroy_context :: proc(ctx: Context)  ---
    set_context :: proc(ctx: Context)  ---
    get_context :: proc() -> Context ---
    default_context :: proc() -> Context ---
    // drawing functions (call inside sokol-gfx render pass)
    draw :: proc()  ---
    context_draw :: proc(ctx: Context)  ---
    draw_layer :: proc(#any_int layer_id: c.int)  ---
    context_draw_layer :: proc(ctx: Context, #any_int layer_id: c.int)  ---
    // switch render layer
    layer :: proc(#any_int layer_id: c.int)  ---
    // switch to a different font
    font :: proc(#any_int font_index: c.int)  ---
    // set a new virtual canvas size in screen pixels
    canvas :: proc(w: f32, h: f32)  ---
    // set a new origin in character grid coordinates
    origin :: proc(x: f32, y: f32)  ---
    // cursor movement functions (relative to origin in character grid coordinates)
    home :: proc()  ---
    pos :: proc(x: f32, y: f32)  ---
    pos_x :: proc(x: f32)  ---
    pos_y :: proc(y: f32)  ---
    move :: proc(dx: f32, dy: f32)  ---
    move_x :: proc(dx: f32)  ---
    move_y :: proc(dy: f32)  ---
    crlf :: proc()  ---
    // set the current text color
    color3b :: proc(r: u8, g: u8, b: u8)  ---
    color3f :: proc(r: f32, g: f32, b: f32)  ---
    color4b :: proc(r: u8, g: u8, b: u8, a: u8)  ---
    color4f :: proc(r: f32, g: f32, b: f32, a: f32)  ---
    color1i :: proc(rgba: u32)  ---
    // text rendering
    putc :: proc(c: u8)  ---
    puts :: proc(str: cstring)  ---
    putr :: proc(str: cstring, #any_int len: c.int)  ---
    // language bindings helper: get the internal printf format buffer
    get_cleared_fmt_buffer :: proc() -> Range ---
}

Log_Item :: enum i32 {
    OK,
    MALLOC_FAILED,
    ADD_COMMIT_LISTENER_FAILED,
    COMMAND_BUFFER_FULL,
    CONTEXT_POOL_EXHAUSTED,
    CANNOT_DESTROY_DEFAULT_CONTEXT,
}

/*
    sdtx_logger_t

    Used in sdtx_desc_t to provide a custom logging and error reporting
    callback to sokol-debugtext.
*/
Logger :: struct {
    func : proc "c" (a0: cstring, a1: u32, a2: u32, a3: cstring, a4: u32, a5: cstring, a6: rawptr),
    user_data : rawptr,
}

// a rendering context handle
Context :: struct {
    id : u32,
}

/*
    sdtx_range is a pointer-size-pair struct used to pass memory
    blobs into sokol-debugtext. When initialized from a value type
    (array or struct), use the SDTX_RANGE() macro to build
    an sdtx_range struct.
*/
Range :: struct {
    ptr : rawptr,
    size : c.size_t,
}

Font_Desc :: struct {
    data : Range,
    first_char : u8,
    last_char : u8,
}

/*
    sdtx_context_desc_t

    Describes the initialization parameters of a rendering context. Creating
    additional rendering contexts is useful if you want to render in
    different sokol-gfx rendering passes, or when rendering several layers
    of text.
*/
Context_Desc :: struct {
    max_commands : c.int,
    char_buf_size : c.int,
    canvas_width : f32,
    canvas_height : f32,
    tab_width : c.int,
    color_format : sg.Pixel_Format,
    depth_format : sg.Pixel_Format,
    sample_count : c.int,
}

/*
    sdtx_allocator_t

    Used in sdtx_desc_t to provide custom memory-alloc and -free functions
    to sokol_debugtext.h. If memory management should be overridden, both the
    alloc_fn and free_fn function must be provided (e.g. it's not valid to
    override one function but not the other).
*/
Allocator :: struct {
    alloc_fn : proc "c" (a0: c.size_t, a1: rawptr) -> rawptr,
    free_fn : proc "c" (a0: rawptr, a1: rawptr),
    user_data : rawptr,
}

/*
    sdtx_desc_t

    Describes the sokol-debugtext API initialization parameters. Passed
    to the sdtx_setup() function.

    NOTE: to populate the fonts item array with builtin fonts, use any
    of the following functions:

        sdtx_font_kc853()
        sdtx_font_kc854()
        sdtx_font_z1013()
        sdtx_font_cpc()
        sdtx_font_c64()
        sdtx_font_oric()
*/
Desc :: struct {
    context_pool_size : c.int,
    printf_buf_size : c.int,
    fonts : [8]Font_Desc,
    ctx : Context_Desc,
    allocator : Allocator,
    logger : Logger,
}

