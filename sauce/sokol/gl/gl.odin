// machine generated, do not edit

package sokol_gl

/*

    sokol_gl.h -- OpenGL 1.x style rendering on top of sokol_gfx.h

    Project URL: https://github.com/floooh/sokol

    Do this:
        #define SOKOL_IMPL or
        #define SOKOL_GL_IMPL
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

    SOKOL_ASSERT(c)     - your own assert macro (default: assert(c))
    SOKOL_GL_API_DECL   - public function declaration prefix (default: extern)
    SOKOL_API_DECL      - same as SOKOL_GL_API_DECL
    SOKOL_API_IMPL      - public function implementation prefix (default: -)
    SOKOL_UNREACHABLE() - a guard macro for unreachable code (default: assert(false))

    If sokol_gl.h is compiled as a DLL, define the following before
    including the declaration or implementation:

    SOKOL_DLL

    On Windows, SOKOL_DLL will define SOKOL_GL_API_DECL as __declspec(dllexport)
    or __declspec(dllimport) as needed.

    Include the following headers before including sokol_gl.h:

        sokol_gfx.h

    Matrix functions have been taken from MESA and Regal.

    FEATURE OVERVIEW:
    =================
    sokol_gl.h implements a subset of the OpenGLES 1.x feature set useful for
    when you just want to quickly render a bunch of triangles or
    lines without having to mess with buffers and shaders.

    The current feature set is mostly useful for debug visualizations
    and simple UI-style 2D rendering:

    What's implemented:
        - vertex components:
            - position (x, y, z)
            - 2D texture coords (u, v)
            - color (r, g, b, a)
        - primitive types:
            - triangle list and strip
            - line list and strip
            - quad list (TODO: quad strips)
            - point list
        - one texture layer (no multi-texturing)
        - viewport and scissor-rect with selectable origin (top-left or bottom-left)
        - all GL 1.x matrix stack functions, and additionally equivalent
          functions for gluPerspective and gluLookat

    Notable GLES 1.x features that are *NOT* implemented:
        - vertex lighting (this is the most likely GL feature that might be added later)
        - vertex arrays (although providing whole chunks of vertex data at once
          might be a useful feature for a later version)
        - texture coordinate generation
        - line width
        - all pixel store functions
        - no ALPHA_TEST
        - no clear functions (clearing is handled by the sokol-gfx render pass)
        - fog

    Notable differences to GL:
        - No "enum soup" for render states etc, instead there's a
          'pipeline stack', this is similar to GL's matrix stack,
          but for pipeline-state-objects. The pipeline object at
          the top of the pipeline stack defines the active set of render states
        - All angles are in radians, not degrees (note the sgl_rad() and
          sgl_deg() conversion functions)
        - No enable/disable state for scissor test, this is always enabled

    STEP BY STEP:
    =============
    --- To initialize sokol-gl, call:

            sgl_setup(const sgl_desc_t* desc)

        NOTE that sgl_setup() must be called *after* initializing sokol-gfx
        (via sg_setup). This is because sgl_setup() needs to create
        sokol-gfx resource objects.

        If you're intending to render to the default pass, and also don't
        want to tweak memory usage, and don't want any logging output you can
        just keep sgl_desc_t zero-initialized:

            sgl_setup(&(sgl_desc_t*){ 0 });

        In this case, sokol-gl will create internal sg_pipeline objects that
        are compatible with the sokol-app default framebuffer.

        I would recommend to at least install a logging callback so that
        you'll see any warnings and errors. The easiest way is through
        sokol_log.h:

            #include "sokol_log.h"

            sgl_setup(&(sgl_desc_t){
                .logger.func = slog_func.
            });

        If you want to render into a framebuffer with different pixel-format
        and MSAA attributes you need to provide the matching attributes in the
        sgl_setup() call:

            sgl_setup(&(sgl_desc_t*){
                .color_format = SG_PIXELFORMAT_...,
                .depth_format = SG_PIXELFORMAT_...,
                .sample_count = ...,
            });

        To reduce memory usage, or if you need to create more then the default number of
        contexts, pipelines, vertices or draw commands, set the following sgl_desc_t
        members:

            .context_pool_size      (default: 4)
            .pipeline_pool_size     (default: 64)
            .max_vertices       (default: 64k)
            .max_commands       (default: 16k)

        Finally you can change the face winding for front-facing triangles
        and quads:

            .face_winding    - default is SG_FACEWINDING_CCW

        The default winding for front faces is counter-clock-wise. This is
        the same as OpenGL's default, but different from sokol-gfx.

    --- Optionally create additional context objects if you want to render into
        multiple sokol-gfx render passes (or generally if you want to
        use multiple independent sokol-gl "state buckets")

            sgl_context ctx = sgl_make_context(const sgl_context_desc_t* desc)

        For details on rendering with sokol-gl contexts, search below for
        WORKING WITH CONTEXTS.

    --- Optionally create pipeline-state-objects if you need render state
        that differs from sokol-gl's default state:

            sgl_pipeline pip = sgl_make_pipeline(const sg_pipeline_desc* desc)

        ...this creates a pipeline object that's compatible with the currently
        active context, alternatively call:

            sgl_pipeline_pip = sgl_context_make_pipeline(sgl_context ctx, const sg_pipeline_desc* desc)

        ...to create a pipeline object that's compatible with an explicitly
        provided context.

        The similarity with sokol_gfx.h's sg_pipeline type and sg_make_pipeline()
        function is intended. sgl_make_pipeline() also takes a standard
        sokol-gfx sg_pipeline_desc object to describe the render state, but
        without:
            - shader
            - vertex layout
            - color- and depth-pixel-formats
            - primitive type (lines, triangles, ...)
            - MSAA sample count
        Those will be filled in by sgl_make_pipeline(). Note that each
        call to sgl_make_pipeline() needs to create several sokol-gfx
        pipeline objects (one for each primitive type).

        'depth.write_enabled' will be forced to 'false' if the context this
        pipeline object is intended for has its depth pixel format set to
        SG_PIXELFORMAT_NONE (which means the framebuffer this context is used
        with doesn't have a depth-stencil surface).

    --- if you need to destroy sgl_pipeline objects before sgl_shutdown():

            sgl_destroy_pipeline(sgl_pipeline pip)

    --- After sgl_setup() you can call any of the sokol-gl functions anywhere
        in a frame, *except* sgl_draw(). The 'vanilla' functions
        will only change internal sokol-gl state, and not call any sokol-gfx
        functions.

    --- Unlike OpenGL, sokol-gl has a function to reset internal state to
        a known default. This is useful at the start of a sequence of
        rendering operations:

            void sgl_defaults(void)

        This will set the following default state:

            - current texture coordinate to u=0.0f, v=0.0f
            - current color to white (rgba all 1.0f)
            - current point size to 1.0f
            - unbind the current texture and texturing will be disabled
            - *all* matrices will be set to identity (also the projection matrix)
            - the default render state will be set by loading the 'default pipeline'
              into the top of the pipeline stack

        The current matrix- and pipeline-stack-depths will not be changed by
        sgl_defaults().

    --- change the currently active renderstate through the
        pipeline-stack functions, this works similar to the
        traditional GL matrix stack:

            ...load the default pipeline state on the top of the pipeline stack:

                sgl_load_default_pipeline()

            ...load a specific pipeline on the top of the pipeline stack:

                sgl_load_pipeline(sgl_pipeline pip)

            ...push and pop the pipeline stack:
                sgl_push_pipeline()
                sgl_pop_pipeline()

    --- control texturing with:

            sgl_enable_texture()
            sgl_disable_texture()
            sgl_texture(sg_view tex_view, sg_sampler smp)

        NOTE: the tex_view and smp handles can be invalid (SG_INVALID_ID), in this
        case, sokol-gl will fall back to the internal default (white) texture
        and sampler.

    --- set the current viewport and scissor rect with:

            sgl_viewport(int x, int y, int w, int h, bool origin_top_left)
            sgl_scissor_rect(int x, int y, int w, int h, bool origin_top_left)

        ...or call these alternatives which take float arguments (this might allow
        to avoid casting between float and integer in more strongly typed languages
        when floating point pixel coordinates are used):

            sgl_viewportf(float x, float y, float w, float h, bool origin_top_left)
            sgl_scissor_rectf(float x, float y, float w, float h, bool origin_top_left)

        ...these calls add a new command to the internal command queue, so
        that the viewport or scissor rect are set at the right time relative
        to other sokol-gl calls.

    --- adjust the transform matrices, matrix manipulation works just like
        the OpenGL matrix stack:

        ...set the current matrix mode:

            sgl_matrix_mode_modelview()
            sgl_matrix_mode_projection()
            sgl_matrix_mode_texture()

        ...load the identity matrix into the current matrix:

            sgl_load_identity()

        ...translate, rotate and scale the current matrix:

            sgl_translate(float x, float y, float z)
            sgl_rotate(float angle_rad, float x, float y, float z)
            sgl_scale(float x, float y, float z)

        NOTE that all angles in sokol-gl are in radians, not in degree.
        Convert between radians and degree with the helper functions:

            float sgl_rad(float deg)        - degrees to radians
            float sgl_deg(float rad)        - radians to degrees

        ...directly load the current matrix from a float[16] array:

            sgl_load_matrix(const float m[16])
            sgl_load_transpose_matrix(const float m[16])

        ...directly multiply the current matrix from a float[16] array:

            sgl_mult_matrix(const float m[16])
            sgl_mult_transpose_matrix(const float m[16])

        The memory layout of those float[16] arrays is the same as in OpenGL.

        ...more matrix functions:

            sgl_frustum(float left, float right, float bottom, float top, float near, float far)
            sgl_ortho(float left, float right, float bottom, float top, float near, float far)
            sgl_perspective(float fov_y, float aspect, float near, float far)
            sgl_lookat(float eye_x, float eye_y, float eye_z, float center_x, float center_y, float center_z, float up_x, float up_y, float up_z)

        These functions work the same as glFrustum(), glOrtho(), gluPerspective()
        and gluLookAt().

        ...and finally to push / pop the current matrix stack:

            sgl_push_matrix(void)
            sgl_pop_matrix(void)

        Again, these work the same as glPushMatrix() and glPopMatrix().

    --- perform primitive rendering:

        ...set the current texture coordinate and color 'registers' with or
        point size with:

            sgl_t2f(float u, float v)   - set current texture coordinate
            sgl_c*(...)                 - set current color
            sgl_point_size(float size)  - set current point size

        There are several functions for setting the color (as float values,
        unsigned byte values, packed as unsigned 32-bit integer, with
        and without alpha).

        NOTE that these are the only functions that can be called both inside
        sgl_begin_*() / sgl_end() and outside.

        Also NOTE that point size is currently hardwired to 1.0f if the D3D11
        backend is used.

        ...start a primitive vertex sequence with:

            sgl_begin_points()
            sgl_begin_lines()
            sgl_begin_line_strip()
            sgl_begin_triangles()
            sgl_begin_triangle_strip()
            sgl_begin_quads()

        ...after sgl_begin_*() specify vertices:

            sgl_v*(...)
            sgl_v*_t*(...)
            sgl_v*_c*(...)
            sgl_v*_t*_c*(...)

        These functions write a new vertex to sokol-gl's internal vertex buffer,
        optionally with texture-coords and color. If the texture coordinate
        and/or color is missing, it will be taken from the current texture-coord
        and color 'register'.

        ...finally, after specifying vertices, call:

            sgl_end()

        This will record a new draw command in sokol-gl's internal command
        list, or it will extend the previous draw command if no relevant
        state has changed since the last sgl_begin/end pair.

    --- inside a sokol-gfx rendering pass, call the sgl_draw() function
        to render the currently active context:

            sgl_draw()

        ...or alternatively call:

            sgl_context_draw(ctx)

        ...to render an explicitly provided context.

        This will render everything that has been recorded in the context since
        the last call to sgl_draw() through sokol-gfx, and will 'rewind' the internal
        vertex-, uniform- and command-buffers.

    --- each sokol-gl context tracks internal error states which can
        be obtains via:

            sgl_error_t sgl_error()

        ...alternatively with an explicit context argument:

            sgl_error_t sgl_context_error(ctx);

        ...this returns a struct with the following booleans:

            .any                - true if any of the below errors is true
            .vertices_full      - internal vertex buffer is full (checked in sgl_end())
            .uniforms_full      - the internal uniforms buffer is full (checked in sgl_end())
            .commands_full      - the internal command buffer is full (checked in sgl_end())
            .stack_overflow     - matrix- or pipeline-stack overflow
            .stack_underflow    - matrix- or pipeline-stack underflow
            .no_context         - the active context no longer exists

        ...depending on the above error state, sgl_draw() may skip rendering
        completely, or only draw partial geometry

    --- you can get the number of recorded vertices and draw commands in the current
        frame and active sokol-gl context via:

            int sgl_num_vertices()
            int sgl_num_commands()

        ...this allows you to check whether the vertex or command pools are running
        full before the overflow actually happens (in this case you could also
        check the error booleans in the result of sgl_error()).

    RENDER LAYERS
    =============
    Render layers allow to split sokol-gl rendering into separate draw-command
    groups which can then be rendered separately in a sokol-gfx draw pass. This
    allows to mix/interleave sokol-gl rendering with other render operations.

    Layered rendering is controlled through two functions:

        sgl_layer(int layer_id)
        sgl_draw_layer(int layer_id)

    (and the context-variant sgl_draw_layer(): sgl_context_draw_layer()

    The sgl_layer() function sets the 'current layer', any sokol-gl calls
    which internally record draw commands will also store the current layer
    in the draw command, and later in a sokol-gfx render pass, a call
    to sgl_draw_layer() will only render the draw commands that have
    a matching layer.

    The default layer is '0', this is active after sokol-gl setup, and
    is also restored at the start of a new frame (but *not* by calling
    sgl_defaults()).

    NOTE that calling sgl_draw() is equivalent with sgl_draw_layer(0)
    (in general you should either use either use sgl_draw() or
    sgl_draw_layer() in an application, but not both).

    WORKING WITH CONTEXTS:
    ======================
    If you want to render to more than one sokol-gfx render pass you need to
    work with additional sokol-gl context objects (one context object for
    each offscreen rendering pass, in addition to the implicitly created
    'default context'.

    All sokol-gl state is tracked per context, and there is always a "current
    context" (with the notable exception that the currently set context is
    destroyed, more on that later).

    Using multiple contexts can also be useful if you only render in
    a single pass, but want to maintain multiple independent "state buckets".

    To create new context object, call:

        sgl_context ctx = sgl_make_context(&(sgl_context_desc){
            .max_vertices = ...,        // default: 64k
            .max_commands = ...,        // default: 16k
            .color_format = ...,
            .depth_format = ...,
            .sample_count = ...,
        });

    The color_format, depth_format and sample_count items must be compatible
    with the render pass the sgl_draw() or sgL_context_draw() function
    will be called in.

    Creating a context does *not* make the context current. To do this, call:

        sgl_set_context(ctx);

    The currently active context will implicitly be used by most sokol-gl functions
    which don't take an explicit context handle as argument.

    To switch back to the default context, pass the global constant SGL_DEFAULT_CONTEXT:

        sgl_set_context(SGL_DEFAULT_CONTEXT);

    ...or alternatively use the function sgl_default_context() instead of the
    global constant:

        sgl_set_context(sgl_default_context());

    To get the currently active context, call:

        sgl_context cur_ctx = sgl_get_context();

    The following functions exist in two variants, one which use the currently
    active context (set with sgl_set_context()), and another version which
    takes an explicit context handle instead:

        sgl_make_pipeline() vs sgl_context_make_pipeline()
        sgl_error() vs sgl_context_error();
        sgl_draw() vs sgl_context_draw();

    Except for using the currently active context versus a provided context
    handle, the two variants are exactlyidentical, e.g. the following
    code sequences do the same thing:

        sgl_set_context(ctx);
        sgl_pipeline pip = sgl_make_pipeline(...);
        sgl_error_t err = sgl_error();
        sgl_draw();

        vs

        sgl_pipeline pip = sgl_context_make_pipeline(ctx, ...);
        sgl_error_t err = sgl_context_error(ctx);
        sgl_context_draw(ctx);

    Destroying the currently active context is a 'soft error'. All following
    calls which require a currently active context will silently fail,
    and sgl_error() will return SGL_ERROR_NO_CONTEXT.

    UNDER THE HOOD:
    ===============
    sokol_gl.h works by recording vertex data and rendering commands into
    memory buffers, and then drawing the recorded commands via sokol_gfx.h

    The only functions which call into sokol_gfx.h are:
        - sgl_setup()
        - sgl_shutdown()
        - sgl_draw() (and variants)

    sgl_setup() must be called after initializing sokol-gfx.
    sgl_shutdown() must be called before shutting down sokol-gfx.
    sgl_draw() must be called once per frame inside a sokol-gfx render pass.

    All other sokol-gl function can be called anywhere in a frame, since
    they just record data into memory buffers owned by sokol-gl.

    What happens in:

        sgl_setup():
            Unique resources shared by all contexts are created:
                - a shader object (using embedded shader source or byte code)
                - an 8x8 white default texture
            The default context is created, which involves:
                - 3 memory buffers are created, one for vertex data,
                  one for uniform data, and one for commands
                - a dynamic vertex buffer is created
                - the default sgl_pipeline object is created, which involves
                  creating 5 sg_pipeline objects

            One vertex is 24 bytes:
                - float3 position
                - float2 texture coords
                - uint32_t color

            One uniform block is 128 bytes:
                - mat4 model-view-projection matrix
                - mat4 texture matrix

            One draw command is ca. 24 bytes for the actual
            command code plus command arguments.

            Each sgl_end() consumes one command, and one uniform block
            (only when the matrices have changed).
            The required size for one sgl_begin/end pair is (at most):

                (152 + 24 * num_verts) bytes

        sgl_shutdown():
            - all sokol-gfx resources (buffer, shader, default-texture and
              all pipeline objects) are destroyed
            - the 3 memory buffers are freed

        sgl_draw() (and variants)
            - copy all recorded vertex data into the dynamic sokol-gfx buffer
              via a call to sg_update_buffer()
            - for each recorded command:
                - if the layer number stored in the command doesn't match
                  the layer that's to be rendered, skip to the next
                  command
                - if it's a viewport command, call sg_apply_viewport()
                - if it's a scissor-rect command, call sg_apply_scissor_rect()
                - if it's a draw command:
                    - depending on what has changed since the last draw command,
                      call sg_apply_pipeline(), sg_apply_bindings() and
                      sg_apply_uniforms()
                    - finally call sg_draw()

    All other functions only modify the internally tracked state, add
    data to the vertex, uniform and command buffers, or manipulate
    the matrix stack.

    ON DRAW COMMAND MERGING
    =======================
    Not every call to sgl_end() will automatically record a new draw command.
    If possible, the previous draw command will simply be extended,
    resulting in fewer actual draw calls later in sgl_draw().

    A draw command will be merged with the previous command if "no relevant
    state has changed" since the last sgl_end(), meaning:

    - no calls to sgl_viewport() and sgl_scissor_rect()
    - the primitive type hasn't changed
    - the primitive type isn't a 'strip type' (no line or triangle strip)
    - the pipeline state object hasn't changed
    - the current layer hasn't changed
    - none of the matrices has changed
    - none of the texture state has changed

    Merging a draw command simply means that the number of vertices
    to render in the previous draw command will be incremented by the
    number of vertices in the new draw command.

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
            sgl_setup(&(sgl_desc_t){
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

        sgl_setup(&(sgl_desc_t){
            // ...
            .logger.func = slog_func
        });

    To override logging with your own callback, first write a logging function like this:

        void my_log(const char* tag,                // e.g. 'sgl'
                    uint32_t log_level,             // 0=panic, 1=error, 2=warn, 3=info
                    uint32_t log_item_id,           // SGL_LOGITEM_*
                    const char* message_or_null,    // a message string, may be nullptr in release mode
                    uint32_t line_nr,               // line number in sokol_gl.h
                    const char* filename_or_null,   // source filename, may be nullptr in release mode
                    void* user_data)
        {
            ...
        }

    ...and then setup sokol-gl like this:

        sgl_setup(&(sgl_desc_t){
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

DEBUG :: #config(SOKOL_GL_DEBUG, SOKOL_DEBUG)
USE_GL :: #config(SOKOL_USE_GL, false)
USE_DLL :: #config(SOKOL_DLL, false)

when ODIN_OS == .Windows {
    when USE_DLL {
        when USE_GL {
            when DEBUG { foreign import sokol_gl_clib { "../sokol_dll_windows_x64_gl_debug.lib" } }
            else       { foreign import sokol_gl_clib { "../sokol_dll_windows_x64_gl_release.lib" } }
        } else {
            when DEBUG { foreign import sokol_gl_clib { "../sokol_dll_windows_x64_d3d11_debug.lib" } }
            else       { foreign import sokol_gl_clib { "../sokol_dll_windows_x64_d3d11_release.lib" } }
        }
    } else {
        when USE_GL {
            when DEBUG { foreign import sokol_gl_clib { "sokol_gl_windows_x64_gl_debug.lib" } }
            else       { foreign import sokol_gl_clib { "sokol_gl_windows_x64_gl_release.lib" } }
        } else {
            when DEBUG { foreign import sokol_gl_clib { "sokol_gl_windows_x64_d3d11_debug.lib" } }
            else       { foreign import sokol_gl_clib { "sokol_gl_windows_x64_d3d11_release.lib" } }
        }
    }
} else when ODIN_OS == .Darwin {
    when USE_DLL {
             when  USE_GL && ODIN_ARCH == .arm64 &&  DEBUG { foreign import sokol_gl_clib { "../dylib/sokol_dylib_macos_arm64_gl_debug.dylib" } }
        else when  USE_GL && ODIN_ARCH == .arm64 && !DEBUG { foreign import sokol_gl_clib { "../dylib/sokol_dylib_macos_arm64_gl_release.dylib" } }
        else when  USE_GL && ODIN_ARCH == .amd64 &&  DEBUG { foreign import sokol_gl_clib { "../dylib/sokol_dylib_macos_x64_gl_debug.dylib" } }
        else when  USE_GL && ODIN_ARCH == .amd64 && !DEBUG { foreign import sokol_gl_clib { "../dylib/sokol_dylib_macos_x64_gl_release.dylib" } }
        else when !USE_GL && ODIN_ARCH == .arm64 &&  DEBUG { foreign import sokol_gl_clib { "../dylib/sokol_dylib_macos_arm64_metal_debug.dylib" } }
        else when !USE_GL && ODIN_ARCH == .arm64 && !DEBUG { foreign import sokol_gl_clib { "../dylib/sokol_dylib_macos_arm64_metal_release.dylib" } }
        else when !USE_GL && ODIN_ARCH == .amd64 &&  DEBUG { foreign import sokol_gl_clib { "../dylib/sokol_dylib_macos_x64_metal_debug.dylib" } }
        else when !USE_GL && ODIN_ARCH == .amd64 && !DEBUG { foreign import sokol_gl_clib { "../dylib/sokol_dylib_macos_x64_metal_release.dylib" } }
    } else {
        when USE_GL {
            when ODIN_ARCH == .arm64 {
                when DEBUG { foreign import sokol_gl_clib { "sokol_gl_macos_arm64_gl_debug.a" } }
                else       { foreign import sokol_gl_clib { "sokol_gl_macos_arm64_gl_release.a" } }
            } else {
                when DEBUG { foreign import sokol_gl_clib { "sokol_gl_macos_x64_gl_debug.a" } }
                else       { foreign import sokol_gl_clib { "sokol_gl_macos_x64_gl_release.a" } }
            }
        } else {
            when ODIN_ARCH == .arm64 {
                when DEBUG { foreign import sokol_gl_clib { "sokol_gl_macos_arm64_metal_debug.a" } }
                else       { foreign import sokol_gl_clib { "sokol_gl_macos_arm64_metal_release.a" } }
            } else {
                when DEBUG { foreign import sokol_gl_clib { "sokol_gl_macos_x64_metal_debug.a" } }
                else       { foreign import sokol_gl_clib { "sokol_gl_macos_x64_metal_release.a" } }
            }
        }
    }
} else when ODIN_OS == .Linux {
    when USE_DLL {
        when DEBUG { foreign import sokol_gl_clib { "sokol_gl_linux_x64_gl_debug.so" } }
        else       { foreign import sokol_gl_clib { "sokol_gl_linux_x64_gl_release.so" } }
    } else {
        when DEBUG { foreign import sokol_gl_clib { "sokol_gl_linux_x64_gl_debug.a" } }
        else       { foreign import sokol_gl_clib { "sokol_gl_linux_x64_gl_release.a" } }
    }
} else when ODIN_ARCH == .wasm32 || ODIN_ARCH == .wasm64p32 {
    // Feed sokol_gl_wasm_gl_debug.a or sokol_gl_wasm_gl_release.a into emscripten compiler.
    foreign import sokol_gl_clib { "env.o" }
} else {
    #panic("This OS is currently not supported")
}

@(default_calling_convention="c", link_prefix="sgl_")
foreign sokol_gl_clib {
    // setup/shutdown/misc
    setup :: proc(#by_ptr desc: Desc)  ---
    shutdown :: proc()  ---
    rad :: proc(deg: f32) -> f32 ---
    deg :: proc(rad: f32) -> f32 ---
    error :: proc() -> Error ---
    context_error :: proc(ctx: Context) -> Error ---
    // context functions
    make_context :: proc(#by_ptr desc: Context_Desc) -> Context ---
    destroy_context :: proc(ctx: Context)  ---
    set_context :: proc(ctx: Context)  ---
    get_context :: proc() -> Context ---
    default_context :: proc() -> Context ---
    // get information about recorded vertices and commands in current context
    num_vertices :: proc() -> c.int ---
    num_commands :: proc() -> c.int ---
    // draw recorded commands (call inside a sokol-gfx render pass)
    draw :: proc()  ---
    context_draw :: proc(ctx: Context)  ---
    draw_layer :: proc(#any_int layer_id: c.int)  ---
    context_draw_layer :: proc(ctx: Context, #any_int layer_id: c.int)  ---
    // create and destroy pipeline objects
    make_pipeline :: proc(#by_ptr desc: sg.Pipeline_Desc) -> Pipeline ---
    context_make_pipeline :: proc(ctx: Context, #by_ptr desc: sg.Pipeline_Desc) -> Pipeline ---
    destroy_pipeline :: proc(pip: Pipeline)  ---
    // render state functions
    defaults :: proc()  ---
    viewport :: proc(#any_int x: c.int, #any_int y: c.int, #any_int w: c.int, #any_int h: c.int, origin_top_left: bool)  ---
    viewportf :: proc(x: f32, y: f32, w: f32, h: f32, origin_top_left: bool)  ---
    scissor_rect :: proc(#any_int x: c.int, #any_int y: c.int, #any_int w: c.int, #any_int h: c.int, origin_top_left: bool)  ---
    scissor_rectf :: proc(x: f32, y: f32, w: f32, h: f32, origin_top_left: bool)  ---
    enable_texture :: proc()  ---
    disable_texture :: proc()  ---
    texture :: proc(tex_view: sg.View, smp: sg.Sampler)  ---
    layer :: proc(#any_int layer_id: c.int)  ---
    // pipeline stack functions
    load_default_pipeline :: proc()  ---
    load_pipeline :: proc(pip: Pipeline)  ---
    push_pipeline :: proc()  ---
    pop_pipeline :: proc()  ---
    // matrix stack functions
    matrix_mode_modelview :: proc()  ---
    matrix_mode_projection :: proc()  ---
    matrix_mode_texture :: proc()  ---
    load_identity :: proc()  ---
    load_matrix :: proc(m: ^f32)  ---
    load_transpose_matrix :: proc(m: ^f32)  ---
    mult_matrix :: proc(m: ^f32)  ---
    mult_transpose_matrix :: proc(m: ^f32)  ---
    rotate :: proc(angle_rad: f32, x: f32, y: f32, z: f32)  ---
    scale :: proc(x: f32, y: f32, z: f32)  ---
    translate :: proc(x: f32, y: f32, z: f32)  ---
    frustum :: proc(l: f32, r: f32, b: f32, t: f32, n: f32, f: f32)  ---
    ortho :: proc(l: f32, r: f32, b: f32, t: f32, n: f32, f: f32)  ---
    perspective :: proc(fov_y: f32, aspect: f32, z_near: f32, z_far: f32)  ---
    lookat :: proc(eye_x: f32, eye_y: f32, eye_z: f32, center_x: f32, center_y: f32, center_z: f32, up_x: f32, up_y: f32, up_z: f32)  ---
    push_matrix :: proc()  ---
    pop_matrix :: proc()  ---
    // these functions only set the internal 'current texcoord / color / point size' (valid inside or outside begin/end)
    t2f :: proc(u: f32, v: f32)  ---
    c3f :: proc(r: f32, g: f32, b: f32)  ---
    c4f :: proc(r: f32, g: f32, b: f32, a: f32)  ---
    c3b :: proc(r: u8, g: u8, b: u8)  ---
    c4b :: proc(r: u8, g: u8, b: u8, a: u8)  ---
    c1i :: proc(rgba: u32)  ---
    point_size :: proc(s: f32)  ---
    // define primitives, each begin/end is one draw command
    begin_points :: proc()  ---
    begin_lines :: proc()  ---
    begin_line_strip :: proc()  ---
    begin_triangles :: proc()  ---
    begin_triangle_strip :: proc()  ---
    begin_quads :: proc()  ---
    v2f :: proc(x: f32, y: f32)  ---
    v3f :: proc(x: f32, y: f32, z: f32)  ---
    v2f_t2f :: proc(x: f32, y: f32, u: f32, v: f32)  ---
    v3f_t2f :: proc(x: f32, y: f32, z: f32, u: f32, v: f32)  ---
    v2f_c3f :: proc(x: f32, y: f32, r: f32, g: f32, b: f32)  ---
    v2f_c3b :: proc(x: f32, y: f32, r: u8, g: u8, b: u8)  ---
    v2f_c4f :: proc(x: f32, y: f32, r: f32, g: f32, b: f32, a: f32)  ---
    v2f_c4b :: proc(x: f32, y: f32, r: u8, g: u8, b: u8, a: u8)  ---
    v2f_c1i :: proc(x: f32, y: f32, rgba: u32)  ---
    v3f_c3f :: proc(x: f32, y: f32, z: f32, r: f32, g: f32, b: f32)  ---
    v3f_c3b :: proc(x: f32, y: f32, z: f32, r: u8, g: u8, b: u8)  ---
    v3f_c4f :: proc(x: f32, y: f32, z: f32, r: f32, g: f32, b: f32, a: f32)  ---
    v3f_c4b :: proc(x: f32, y: f32, z: f32, r: u8, g: u8, b: u8, a: u8)  ---
    v3f_c1i :: proc(x: f32, y: f32, z: f32, rgba: u32)  ---
    v2f_t2f_c3f :: proc(x: f32, y: f32, u: f32, v: f32, r: f32, g: f32, b: f32)  ---
    v2f_t2f_c3b :: proc(x: f32, y: f32, u: f32, v: f32, r: u8, g: u8, b: u8)  ---
    v2f_t2f_c4f :: proc(x: f32, y: f32, u: f32, v: f32, r: f32, g: f32, b: f32, a: f32)  ---
    v2f_t2f_c4b :: proc(x: f32, y: f32, u: f32, v: f32, r: u8, g: u8, b: u8, a: u8)  ---
    v2f_t2f_c1i :: proc(x: f32, y: f32, u: f32, v: f32, rgba: u32)  ---
    v3f_t2f_c3f :: proc(x: f32, y: f32, z: f32, u: f32, v: f32, r: f32, g: f32, b: f32)  ---
    v3f_t2f_c3b :: proc(x: f32, y: f32, z: f32, u: f32, v: f32, r: u8, g: u8, b: u8)  ---
    v3f_t2f_c4f :: proc(x: f32, y: f32, z: f32, u: f32, v: f32, r: f32, g: f32, b: f32, a: f32)  ---
    v3f_t2f_c4b :: proc(x: f32, y: f32, z: f32, u: f32, v: f32, r: u8, g: u8, b: u8, a: u8)  ---
    v3f_t2f_c1i :: proc(x: f32, y: f32, z: f32, u: f32, v: f32, rgba: u32)  ---
    end :: proc()  ---
}

Log_Item :: enum i32 {
    OK,
    MALLOC_FAILED,
    MAKE_PIPELINE_FAILED,
    PIPELINE_POOL_EXHAUSTED,
    ADD_COMMIT_LISTENER_FAILED,
    CONTEXT_POOL_EXHAUSTED,
    CANNOT_DESTROY_DEFAULT_CONTEXT,
}

/*
    sgl_logger_t

    Used in sgl_desc_t to provide a custom logging and error reporting
    callback to sokol-gl.
*/
Logger :: struct {
    func : proc "c" (a0: cstring, a1: u32, a2: u32, a3: cstring, a4: u32, a5: cstring, a6: rawptr),
    user_data : rawptr,
}

// sokol_gl pipeline handle (created with sgl_make_pipeline())
Pipeline :: struct {
    id : u32,
}

// a context handle (created with sgl_make_context())
Context :: struct {
    id : u32,
}

/*
    sgl_error_t

    Errors are reset each frame after calling sgl_draw(),
    get the last error code with sgl_error()
*/
Error :: struct {
    any : bool,
    vertices_full : bool,
    uniforms_full : bool,
    commands_full : bool,
    stack_overflow : bool,
    stack_underflow : bool,
    no_context : bool,
}

/*
    sgl_context_desc_t

    Describes the initialization parameters of a rendering context.
    Creating additional contexts is useful if you want to render
    in separate sokol-gfx passes.
*/
Context_Desc :: struct {
    max_vertices : c.int,
    max_commands : c.int,
    color_format : sg.Pixel_Format,
    depth_format : sg.Pixel_Format,
    sample_count : c.int,
}

/*
    sgl_allocator_t

    Used in sgl_desc_t to provide custom memory-alloc and -free functions
    to sokol_gl.h. If memory management should be overridden, both the
    alloc and free function must be provided (e.g. it's not valid to
    override one function but not the other).
*/
Allocator :: struct {
    alloc_fn : proc "c" (a0: c.size_t, a1: rawptr) -> rawptr,
    free_fn : proc "c" (a0: rawptr, a1: rawptr),
    user_data : rawptr,
}

Desc :: struct {
    max_vertices : c.int,
    max_commands : c.int,
    context_pool_size : c.int,
    pipeline_pool_size : c.int,
    color_format : sg.Pixel_Format,
    depth_format : sg.Pixel_Format,
    sample_count : c.int,
    face_winding : sg.Face_Winding,
    allocator : Allocator,
    logger : Logger,
}

