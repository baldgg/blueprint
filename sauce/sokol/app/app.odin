// machine generated, do not edit

package sokol_app

/*

    sokol_app.h -- cross-platform application wrapper

    Project URL: https://github.com/floooh/sokol

    Do this:
        #define SOKOL_IMPL or
        #define SOKOL_APP_IMPL
    before you include this file in *one* C or C++ file to create the
    implementation.

    In the same place define one of the following to select the 3D-API
    which should be initialized by sokol_app.h (this must also match
    the backend selected for sokol_gfx.h if both are used in the same
    project):

        #define SOKOL_GLCORE
        #define SOKOL_GLES3
        #define SOKOL_D3D11
        #define SOKOL_METAL
        #define SOKOL_WGPU
        #define SOKOL_NOAPI

    Optionally provide the following defines with your own implementations:

        SOKOL_ASSERT(c)             - your own assert macro (default: assert(c))
        SOKOL_UNREACHABLE()         - a guard macro for unreachable code (default: assert(false))
        SOKOL_WIN32_FORCE_MAIN      - define this on Win32 to add a main() entry point
        SOKOL_WIN32_FORCE_WINMAIN   - define this on Win32 to add a WinMain() entry point (enabled by default unless
                                      SOKOL_WIN32_FORCE_MAIN or SOKOL_NO_ENTRY is defined)
        SOKOL_NO_ENTRY              - define this if sokol_app.h shouldn't "hijack" the main() function
        SOKOL_APP_API_DECL          - public function declaration prefix (default: extern)
        SOKOL_API_DECL              - same as SOKOL_APP_API_DECL
        SOKOL_API_IMPL              - public function implementation prefix (default: -)

    Optionally define the following to force debug checks and validations
    even in release mode:

        SOKOL_DEBUG         - by default this is defined if NDEBUG is not defined

    If sokol_app.h is compiled as a DLL, define the following before
    including the declaration or implementation:

        SOKOL_DLL

    On Windows, SOKOL_DLL will define SOKOL_APP_API_DECL as __declspec(dllexport)
    or __declspec(dllimport) as needed.

    if SOKOL_WIN32_FORCE_MAIN and SOKOL_WIN32_FORCE_WINMAIN are both defined,
    it is up to the developer to define the desired subsystem.

    On Linux, SOKOL_GLCORE can use either GLX or EGL.
    GLX is default, set SOKOL_FORCE_EGL to override.

    For example code, see https://github.com/floooh/sokol-samples/tree/master/sapp

    Portions of the Windows and Linux GL initialization, event-, icon- etc... code
    have been taken from GLFW (http://www.glfw.org/).

    iOS onscreen keyboard support 'inspired' by libgdx.

    Link with the following system libraries:

    - on macOS:
        - all backends: Foundation, Cocoa, QuartzCore
        - with SOKOL_METAL: Metal, MetalKit
        - with SOKOL_GLCORE: OpenGL
        - with SOKOL_WGPU: a WebGPU implementation library (tested with webgpu_dawn)
    - on iOS:
        - all backends: Foundation, UIKit
        - with SOKOL_METAL: Metal, MetalKit
        - with SOKOL_GLES3: OpenGLES, GLKit
    - on Linux:
        - all backends: X11, Xi, Xcursor, dl, pthread, m
        - with SOKOL_GLCORE: GL
        - with SOKOL_GLES3: GLESv2
        - with SOKOL_WGPU: a WebGPU implementation library (tested with webgpu_dawn)
        - with EGL: EGL
    - on Android: GLESv3, EGL, log, android
    - on Windows:
        - with MSVC or Clang: library dependencies are defined via `#pragma comment`
        - with SOKOL_WGPU: a WebGPU implementation library (tested with webgpu_dawn)
        - with MINGW/MSYS2 gcc:
            - compile with '-mwin32' so that _WIN32 is defined
            - link with the following libs: -lkernel32 -luser32 -lshell32
            - additionally with the GL backend: -lgdi32
            - additionally with the D3D11 backend: -ld3d11 -ldxgi

    On Linux, you also need to use the -pthread compiler and linker option, otherwise weird
    things will happen, see here for details: https://github.com/floooh/sokol/issues/376

    On macOS and iOS, the implementation must be compiled as Objective-C.

    On Emscripten:
        - for WebGL2: add the linker option `-s USE_WEBGL2=1`
        - for WebGPU: compile and link with `--use-port=emdawnwebgpu`
          (for more exotic situations read: https://dawn.googlesource.com/dawn/+/refs/heads/main/src/emdawnwebgpu/pkg/README.md)

    FEATURE OVERVIEW
    ================
    sokol_app.h provides a minimalistic cross-platform API which
    implements the 'application-wrapper' parts of a 3D application:

    - a common application entry function
    - creates a window and 3D-API context/device with a swapchain
      surface, depth-stencil-buffer surface and optionally MSAA surface
    - makes the rendered frame visible
    - provides keyboard-, mouse- and low-level touch-events
    - platforms: MacOS, iOS, HTML5, Win32, Linux/RaspberryPi, Android
    - 3D-APIs: Metal, D3D11, GL4.1, GL4.3, GLES3, WebGL2, WebGPU, NOAPI

    FEATURE/PLATFORM MATRIX
    =======================
                        | Windows | macOS | Linux |  iOS  | Android |  HTML5
    --------------------+---------+-------+-------+-------+---------+--------
    gl 4.x              | YES     | YES   | YES   | ---   | ---     |  ---
    gles3/webgl2        | ---     | ---   | YES(2)| YES   | YES     |  YES
    metal               | ---     | YES   | ---   | YES   | ---     |  ---
    d3d11               | YES     | ---   | ---   | ---   | ---     |  ---
    webgpu              | YES(4)  | YES(4)| YES(4)| NO    | NO      |  YES
    noapi               | YES     | TODO  | TODO  | ---   | TODO    |  ---
    KEY_DOWN            | YES     | YES   | YES   | SOME  | TODO    |  YES
    KEY_UP              | YES     | YES   | YES   | SOME  | TODO    |  YES
    CHAR                | YES     | YES   | YES   | YES   | TODO    |  YES
    MOUSE_DOWN          | YES     | YES   | YES   | ---   | ---     |  YES
    MOUSE_UP            | YES     | YES   | YES   | ---   | ---     |  YES
    MOUSE_SCROLL        | YES     | YES   | YES   | ---   | ---     |  YES
    MOUSE_MOVE          | YES     | YES   | YES   | ---   | ---     |  YES
    MOUSE_ENTER         | YES     | YES   | YES   | ---   | ---     |  YES
    MOUSE_LEAVE         | YES     | YES   | YES   | ---   | ---     |  YES
    TOUCHES_BEGAN       | ---     | ---   | ---   | YES   | YES     |  YES
    TOUCHES_MOVED       | ---     | ---   | ---   | YES   | YES     |  YES
    TOUCHES_ENDED       | ---     | ---   | ---   | YES   | YES     |  YES
    TOUCHES_CANCELLED   | ---     | ---   | ---   | YES   | YES     |  YES
    RESIZED             | YES     | YES   | YES   | YES   | YES     |  YES
    ICONIFIED           | YES     | YES   | YES   | ---   | ---     |  ---
    RESTORED            | YES     | YES   | YES   | ---   | ---     |  ---
    FOCUSED             | YES     | YES   | YES   | ---   | ---     |  YES
    UNFOCUSED           | YES     | YES   | YES   | ---   | ---     |  YES
    SUSPENDED           | ---     | ---   | ---   | YES   | YES     |  TODO
    RESUMED             | ---     | ---   | ---   | YES   | YES     |  TODO
    QUIT_REQUESTED      | YES     | YES   | YES   | ---   | ---     |  YES
    IME                 | TODO    | TODO? | TODO  | ???   | TODO    |  ???
    key repeat flag     | YES     | YES   | YES   | ---   | ---     |  YES
    windowed            | YES     | YES   | YES   | ---   | ---     |  YES
    fullscreen          | YES     | YES   | YES   | YES   | YES     |  YES(3)
    mouse hide          | YES     | YES   | YES   | ---   | ---     |  YES
    mouse lock          | YES     | YES   | YES   | ---   | ---     |  YES
    set cursor type     | YES     | YES   | YES   | ---   | ---     |  YES
    screen keyboard     | ---     | ---   | ---   | YES   | TODO    |  YES
    swap interval       | YES     | YES   | YES   | YES   | TODO    |  YES
    high-dpi            | YES     | YES   | TODO  | YES   | YES     |  YES
    clipboard           | YES     | YES   | YES   | ---   | ---     |  YES
    MSAA                | YES     | YES   | YES   | YES   | YES     |  YES
    drag'n'drop         | YES     | YES   | YES   | ---   | ---     |  YES
    window icon         | YES     | YES(1)| YES   | ---   | ---     |  YES

    (1) macOS has no regular window icons, instead the dock icon is changed
    (2) supported with EGL only (not GLX)
    (3) fullscreen in the browser not supported on iphones
    (4) WebGPU on native desktop platforms should be considered experimental
        and mainly useful for debugging and benchmarking

    STEP BY STEP
    ============
    --- Add a sokol_main() function to your code which returns a sapp_desc structure
        with initialization parameters and callback function pointers. This
        function is called very early, usually at the start of the
        platform's entry function (e.g. main or WinMain). You should do as
        little as possible here, since the rest of your code might be called
        from another thread (this depends on the platform):

            sapp_desc sokol_main(int argc, char* argv[]) {
                return (sapp_desc) {
                    .width = 640,
                    .height = 480,
                    .init_cb = my_init_func,
                    .frame_cb = my_frame_func,
                    .cleanup_cb = my_cleanup_func,
                    .event_cb = my_event_func,
                    ...
                };
            }

        To get any logging output in case of errors you need to provide a log
        callback. The easiest way is via sokol_log.h:

            #include "sokol_log.h"

            sapp_desc sokol_main(int argc, char* argv[]) {
                return (sapp_desc) {
                    ...
                    .logger.func = slog_func,
                };
            }

        There are many more setup parameters, but these are the most important.
        For a complete list search for the sapp_desc structure declaration
        below.

        DO NOT call any sokol-app function from inside sokol_main(), since
        sokol-app will not be initialized at this point.

        The .width and .height parameters are the preferred size of the 3D
        rendering canvas. The actual size may differ from this depending on
        platform and other circumstances. Also the canvas size may change at
        any time (for instance when the user resizes the application window,
        or rotates the mobile device). You can just keep .width and .height
        zero-initialized to open a default-sized window (what "default-size"
        exactly means is platform-specific, but usually it's a size that covers
        most of, but not all, of the display).

        All provided function callbacks will be called from the same thread,
        but this may be different from the thread where sokol_main() was called.

        .init_cb (void (*)(void))
            This function is called once after the application window,
            3D rendering context and swap chain have been created. The
            function takes no arguments and has no return value.
        .frame_cb (void (*)(void))
            This is the per-frame callback, which is usually called 60
            times per second. This is where your application would update
            most of its state and perform all rendering.
        .cleanup_cb (void (*)(void))
            The cleanup callback is called once right before the application
            quits.
        .event_cb (void (*)(const sapp_event* event))
            The event callback is mainly for input handling, but is also
            used to communicate other types of events to the application. Keep the
            event_cb struct member zero-initialized if your application doesn't require
            event handling.

        As you can see, those 'standard callbacks' don't have a user_data
        argument, so any data that needs to be preserved between callbacks
        must live in global variables. If keeping state in global variables
        is not an option, there's an alternative set of callbacks with
        an additional user_data pointer argument:

        .user_data (void*)
            The user-data argument for the callbacks below
        .init_userdata_cb (void (*)(void* user_data))
        .frame_userdata_cb (void (*)(void* user_data))
        .cleanup_userdata_cb (void (*)(void* user_data))
        .event_userdata_cb (void(*)(const sapp_event* event, void* user_data))

        The function sapp_userdata() can be used to query the user_data
        pointer provided in the sapp_desc struct.

        You can also call sapp_query_desc() to get a copy of the
        original sapp_desc structure.

        NOTE that there's also an alternative compile mode where sokol_app.h
        doesn't "hijack" the main() function. Search below for SOKOL_NO_ENTRY.

    --- Implement the initialization callback function (init_cb), this is called
        once after the rendering surface, 3D API and swap chain have been
        initialized by sokol_app. All sokol-app functions can be called
        from inside the initialization callback, the most useful functions
        at this point are:

        int sapp_width(void)
        int sapp_height(void)
            Returns the current width and height of the default framebuffer in pixels,
            this may change from one frame to the next, and it may be different
            from the initial size provided in the sapp_desc struct.

        float sapp_widthf(void)
        float sapp_heightf(void)
            These are alternatives to sapp_width() and sapp_height() which return
            the default framebuffer size as float values instead of integer. This
            may help to prevent casting back and forth between int and float
            in more strongly typed languages than C and C++.

        double sapp_frame_duration(void)
            Returns the frame duration in seconds averaged over a number of
            frames to smooth out any jittering spikes.

        int sapp_color_format(void)
        int sapp_depth_format(void)
            The color and depth-stencil pixelformats of the default framebuffer,
            as integer values which are compatible with sokol-gfx's
            sg_pixel_format enum (so that they can be plugged directly in places
            where sg_pixel_format is expected). Possible values are:

                23 == SG_PIXELFORMAT_RGBA8
                28 == SG_PIXELFORMAT_BGRA8
                42 == SG_PIXELFORMAT_DEPTH
                43 == SG_PIXELFORMAT_DEPTH_STENCIL

        int sapp_sample_count(void)
            Return the MSAA sample count of the default framebuffer.

        const void* sapp_metal_get_device(void)
        const void* sapp_metal_get_current_drawable(void)
        const void* sapp_metal_get_depth_stencil_texture(void)
        const void* sapp_metal_get_msaa_color_texture(void)
            If the Metal backend has been selected, these functions return pointers
            to various Metal API objects required for rendering, otherwise
            they return a null pointer. These void pointers are actually
            Objective-C ids converted with a (ARC) __bridge cast so that
            the ids can be tunneled through C code. Also note that the returned
            pointers may change from one frame to the next, only the Metal device
            object is guaranteed to stay the same.

        const void* sapp_macos_get_window(void)
            On macOS, get the NSWindow object pointer, otherwise a null pointer.
            Before being used as Objective-C object, the void* must be converted
            back with a (ARC) __bridge cast.

        const void* sapp_ios_get_window(void)
            On iOS, get the UIWindow object pointer, otherwise a null pointer.
            Before being used as Objective-C object, the void* must be converted
            back with a (ARC) __bridge cast.

        const void* sapp_d3d11_get_device(void)
        const void* sapp_d3d11_get_device_context(void)
        const void* sapp_d3d11_get_render_view(void)
        const void* sapp_d3d11_get_resolve_view(void);
        const void* sapp_d3d11_get_depth_stencil_view(void)
            Similar to the sapp_metal_* functions, the sapp_d3d11_* functions
            return pointers to D3D11 API objects required for rendering,
            only if the D3D11 backend has been selected. Otherwise they
            return a null pointer. Note that the returned pointers to the
            render-target-view and depth-stencil-view may change from one
            frame to the next!

        const void* sapp_win32_get_hwnd(void)
            On Windows, get the window's HWND, otherwise a null pointer. The
            HWND has been cast to a void pointer in order to be tunneled
            through code which doesn't include Windows.h.

        const void* sapp_x11_get_window(void)
            On Linux, get the X11 Window, otherwise a null pointer. The
            Window has been cast to a void pointer in order to be tunneled
            through code which doesn't include X11/Xlib.h.

        const void* sapp_x11_get_display(void)
            On Linux, get the X11 Display, otherwise a null pointer. The
            Display has been cast to a void pointer in order to be tunneled
            through code which doesn't include X11/Xlib.h.

        const void* sapp_wgpu_get_device(void)
        const void* sapp_wgpu_get_render_view(void)
        const void* sapp_wgpu_get_resolve_view(void)
        const void* sapp_wgpu_get_depth_stencil_view(void)
            These are the WebGPU-specific functions to get the WebGPU
            objects and values required for rendering. If sokol_app.h
            is not compiled with SOKOL_WGPU, these functions return null.

        uint32_t sapp_gl_get_framebuffer(void)
            This returns the 'default framebuffer' of the GL context.
            Typically this will be zero.

        int sapp_gl_get_major_version(void)
        int sapp_gl_get_minor_version(void)
        bool sapp_gl_is_gles(void)
            Returns the major and minor version of the GL context and
            whether the GL context is a GLES context

        const void* sapp_android_get_native_activity(void);
            On Android, get the native activity ANativeActivity pointer, otherwise
            a null pointer.

    --- Implement the frame-callback function, this function will be called
        on the same thread as the init callback, but might be on a different
        thread than the sokol_main() function. Note that the size of
        the rendering framebuffer might have changed since the frame callback
        was called last. Call the functions sapp_width() and sapp_height()
        each frame to get the current size.

    --- Optionally implement the event-callback to handle input events.
        sokol-app provides the following type of input events:
            - a 'virtual key' was pressed down or released
            - a single text character was entered (provided as UTF-32 encoded
              UNICODE code point)
            - a mouse button was pressed down or released (left, right, middle)
            - mouse-wheel or 2D scrolling events
            - the mouse was moved
            - the mouse has entered or left the application window boundaries
            - low-level, portable multi-touch events (began, moved, ended, cancelled)
            - the application window was resized, iconified or restored
            - the application was suspended or restored (on mobile platforms)
            - the user or application code has asked to quit the application
            - a string was pasted to the system clipboard
            - one or more files have been dropped onto the application window

        To explicitly 'consume' an event and prevent that the event is
        forwarded for further handling to the operating system, call
        sapp_consume_event() from inside the event handler (NOTE that
        this behaviour is currently only implemented for some HTML5
        events, support for other platforms and event types will
        be added as needed, please open a GitHub ticket and/or provide
        a PR if needed).

        NOTE: Do *not* call any 3D API rendering functions in the event
        callback function, since the 3D API context may not be active when the
        event callback is called (it may work on some platforms and 3D APIs,
        but not others, and the exact behaviour may change between
        sokol-app versions).

    --- Implement the cleanup-callback function, this is called once
        after the user quits the application (see the section
        "APPLICATION QUIT" for detailed information on quitting
        behaviour, and how to intercept a pending quit - for instance to show a
        "Really Quit?" dialog box). Note that the cleanup-callback isn't
        guaranteed to be called on the web and mobile platforms.

    MOUSE CURSOR TYPE AND VISIBILITY
    ================================
    You can show and hide the mouse cursor with

        void sapp_show_mouse(bool show)

    And to get the current shown status:

        bool sapp_mouse_shown(void)

    NOTE that hiding the mouse cursor is different and independent from
    the MOUSE/POINTER LOCK feature which will also hide the mouse pointer when
    active (MOUSE LOCK is described below).

    To change the mouse cursor to one of several predefined types, call
    the function:

        void sapp_set_mouse_cursor(sapp_mouse_cursor cursor)

    Setting the default mouse cursor SAPP_MOUSECURSOR_DEFAULT will restore
    the standard look.

    To get the currently active mouse cursor type, call:

        sapp_mouse_cursor sapp_get_mouse_cursor(void)

    MOUSE LOCK (AKA POINTER LOCK, AKA MOUSE CAPTURE)
    ================================================
    In normal mouse mode, no mouse movement events are reported when the
    mouse leaves the windows client area or hits the screen border (whether
    it's one or the other depends on the platform), and the mouse move events
    (SAPP_EVENTTYPE_MOUSE_MOVE) contain absolute mouse positions in
    framebuffer pixels in the sapp_event items mouse_x and mouse_y, and
    relative movement in framebuffer pixels in the sapp_event items mouse_dx
    and mouse_dy.

    To get continuous mouse movement (also when the mouse leaves the window
    client area or hits the screen border), activate mouse-lock mode
    by calling:

        sapp_lock_mouse(true)

    When mouse lock is activated, the mouse pointer is hidden, the
    reported absolute mouse position (sapp_event.mouse_x/y) appears
    frozen, and the relative mouse movement in sapp_event.mouse_dx/dy
    no longer has a direct relation to framebuffer pixels but instead
    uses "raw mouse input" (what "raw mouse input" exactly means also
    differs by platform).

    To deactivate mouse lock and return to normal mouse mode, call

        sapp_lock_mouse(false)

    And finally, to check if mouse lock is currently active, call

        if (sapp_mouse_locked()) { ... }

    Note that mouse-lock state may not change immediately after sapp_lock_mouse(true/false)
    is called, instead on some platforms the actual state switch may be delayed
    to the end of the current frame or even to a later frame.

    The mouse may also be unlocked automatically without calling sapp_lock_mouse(false),
    most notably when the application window becomes inactive.

    On the web platform there are further restrictions to be aware of, caused
    by the limitations of the HTML5 Pointer Lock API:

        - sapp_lock_mouse(true) can be called at any time, but it will
          only take effect in a 'short-lived input event handler of a specific
          type', meaning when one of the following events happens:
            - SAPP_EVENTTYPE_MOUSE_DOWN
            - SAPP_EVENTTYPE_MOUSE_UP
            - SAPP_EVENTTYPE_MOUSE_SCROLL
            - SAPP_EVENTTYPE_KEY_UP
            - SAPP_EVENTTYPE_KEY_DOWN
        - The mouse lock/unlock action on the web platform is asynchronous,
          this means that sapp_mouse_locked() won't immediately return
          the new status after calling sapp_lock_mouse(), instead the
          reported status will only change when the pointer lock has actually
          been activated or deactivated in the browser.
        - On the web, mouse lock can be deactivated by the user at any time
          by pressing the Esc key. When this happens, sokol_app.h behaves
          the same as if sapp_lock_mouse(false) is called.

    For things like camera manipulation it's most straightforward to lock
    and unlock the mouse right from the sokol_app.h event handler, for
    instance the following code enters and leaves mouse lock when the
    left mouse button is pressed and released, and then uses the relative
    movement information to manipulate a camera (taken from the
    cgltf-sapp.c sample in the sokol-samples repository
    at https://github.com/floooh/sokol-samples):

        static void input(const sapp_event* ev) {
            switch (ev->type) {
                case SAPP_EVENTTYPE_MOUSE_DOWN:
                    if (ev->mouse_button == SAPP_MOUSEBUTTON_LEFT) {
                        sapp_lock_mouse(true);
                    }
                    break;

                case SAPP_EVENTTYPE_MOUSE_UP:
                    if (ev->mouse_button == SAPP_MOUSEBUTTON_LEFT) {
                        sapp_lock_mouse(false);
                    }
                    break;

                case SAPP_EVENTTYPE_MOUSE_MOVE:
                    if (sapp_mouse_locked()) {
                        cam_orbit(&state.camera, ev->mouse_dx * 0.25f, ev->mouse_dy * 0.25f);
                    }
                    break;

                default:
                    break;
            }
        }

    For a 'first person shooter mouse' the following code inside the sokol-app event handler
    is recommended somewhere in your frame callback:

        if (!sapp_mouse_locked()) {
            sapp_lock_mouse(true);
        }

    CLIPBOARD SUPPORT
    =================
    Applications can send and receive UTF-8 encoded text data from and to the
    system clipboard. By default, clipboard support is disabled and
    must be enabled at startup via the following sapp_desc struct
    members:

        sapp_desc.enable_clipboard  - set to true to enable clipboard support
        sapp_desc.clipboard_size    - size of the internal clipboard buffer in bytes

    Enabling the clipboard will dynamically allocate a clipboard buffer
    for UTF-8 encoded text data of the requested size in bytes, the default
    size is 8 KBytes. Strings that don't fit into the clipboard buffer
    (including the terminating zero) will be silently clipped, so it's
    important that you provide a big enough clipboard size for your
    use case.

    To send data to the clipboard, call sapp_set_clipboard_string() with
    a pointer to an UTF-8 encoded, null-terminated C-string.

    NOTE that on the HTML5 platform, sapp_set_clipboard_string() must be
    called from inside a 'short-lived event handler', and there are a few
    other HTML5-specific caveats to workaround. You'll basically have to
    tinker until it works in all browsers :/ (maybe the situation will
    improve when all browsers agree on and implement the new
    HTML5 navigator.clipboard API).

    To get data from the clipboard, check for the SAPP_EVENTTYPE_CLIPBOARD_PASTED
    event in your event handler function, and then call sapp_get_clipboard_string()
    to obtain the pasted UTF-8 encoded text.

    NOTE that behaviour of sapp_get_clipboard_string() is slightly different
    depending on platform:

        - on the HTML5 platform, the internal clipboard buffer will only be updated
          right before the SAPP_EVENTTYPE_CLIPBOARD_PASTED event is sent,
          and sapp_get_clipboard_string() will simply return the current content
          of the clipboard buffer
        - on 'native' platforms, the call to sapp_get_clipboard_string() will
          update the internal clipboard buffer with the most recent data
          from the system clipboard

    Portable code should check for the SAPP_EVENTTYPE_CLIPBOARD_PASTED event,
    and then call sapp_get_clipboard_string() right in the event handler.

    The SAPP_EVENTTYPE_CLIPBOARD_PASTED event will be generated by sokol-app
    as follows:

        - on macOS: when the Cmd+V key is pressed down
        - on HTML5: when the browser sends a 'paste' event to the global 'window' object
        - on all other platforms: when the Ctrl+V key is pressed down

    DRAG AND DROP SUPPORT
    =====================
    PLEASE NOTE: the drag'n'drop feature works differently on WASM/HTML5
    and on the native desktop platforms (Win32, Linux and macOS) because
    of security-related restrictions in the HTML5 drag'n'drop API. The
    WASM/HTML5 specifics are described at the end of this documentation
    section:

    Like clipboard support, drag'n'drop support must be explicitly enabled
    at startup in the sapp_desc struct.

        sapp_desc sokol_main(void) {
            return (sapp_desc) {
                .enable_dragndrop = true,   // default is false
                ...
            };
        }

    You can also adjust the maximum number of files that are accepted
    in a drop operation, and the maximum path length in bytes if needed:

        sapp_desc sokol_main(void) {
            return (sapp_desc) {
                .enable_dragndrop = true,               // default is false
                .max_dropped_files = 8,                 // default is 1
                .max_dropped_file_path_length = 8192,   // in bytes, default is 2048
                ...
            };
        }

    When drag'n'drop is enabled, the event callback will be invoked with an
    event of type SAPP_EVENTTYPE_FILES_DROPPED whenever the user drops files on
    the application window.

    After the SAPP_EVENTTYPE_FILES_DROPPED is received, you can query the
    number of dropped files, and their absolute paths by calling separate
    functions:

        void on_event(const sapp_event* ev) {
            if (ev->type == SAPP_EVENTTYPE_FILES_DROPPED) {

                // the mouse position where the drop happened
                float x = ev->mouse_x;
                float y = ev->mouse_y;

                // get the number of files and their paths like this:
                const int num_dropped_files = sapp_get_num_dropped_files();
                for (int i = 0; i < num_dropped_files; i++) {
                    const char* path = sapp_get_dropped_file_path(i);
                    ...
                }
            }
        }

    The returned file paths are UTF-8 encoded strings.

    You can call sapp_get_num_dropped_files() and sapp_get_dropped_file_path()
    anywhere, also outside the event handler callback, but be aware that the
    file path strings will be overwritten with the next drop operation.

    In any case, sapp_get_dropped_file_path() will never return a null pointer,
    instead an empty string "" will be returned if the drag'n'drop feature
    hasn't been enabled, the last drop-operation failed, or the file path index
    is out of range.

    Drag'n'drop caveats:

        - if more files are dropped in a single drop-action
          than sapp_desc.max_dropped_files, the additional
          files will be silently ignored
        - if any of the file paths is longer than
          sapp_desc.max_dropped_file_path_length (in number of bytes, after UTF-8
          encoding) the entire drop operation will be silently ignored (this
          needs some sort of error feedback in the future)
        - no mouse positions are reported while the drag is in
          process, this may change in the future

    Drag'n'drop on HTML5/WASM:

    The HTML5 drag'n'drop API doesn't return file paths, but instead
    black-box 'file objects' which must be used to load the content
    of dropped files. This is the reason why sokol_app.h adds two
    HTML5-specific functions to the drag'n'drop API:

        uint32_t sapp_html5_get_dropped_file_size(int index)
            Returns the size in bytes of a dropped file.

        void sapp_html5_fetch_dropped_file(const sapp_html5_fetch_request* request)
            Asynchronously loads the content of a dropped file into a
            provided memory buffer (which must be big enough to hold
            the file content)

    To start loading the first dropped file after an SAPP_EVENTTYPE_FILES_DROPPED
    event is received:

        sapp_html5_fetch_dropped_file(&(sapp_html5_fetch_request){
            .dropped_file_index = 0,
            .callback = fetch_cb
            .buffer = {
                .ptr = buf,
                .size = sizeof(buf)
            },
            .user_data = ...
        });

    Make sure that the memory pointed to by 'buf' stays valid until the
    callback function is called!

    As result of the asynchronous loading operation (no matter if succeeded or
    failed) the 'fetch_cb' function will be called:

        void fetch_cb(const sapp_html5_fetch_response* response) {
            // IMPORTANT: check if the loading operation actually succeeded:
            if (response->succeeded) {
                // the size of the loaded file:
                const size_t num_bytes = response->data.size;
                // and the pointer to the data (same as 'buf' in the fetch-call):
                const void* ptr = response->data.ptr;
            } else {
                // on error check the error code:
                switch (response->error_code) {
                    case SAPP_HTML5_FETCH_ERROR_BUFFER_TOO_SMALL:
                        ...
                        break;
                    case SAPP_HTML5_FETCH_ERROR_OTHER:
                        ...
                        break;
                }
            }
        }

    Check the droptest-sapp example for a real-world example which works
    both on native platforms and the web:

    https://github.com/floooh/sokol-samples/blob/master/sapp/droptest-sapp.c

    HIGH-DPI RENDERING
    ==================
    You can set the sapp_desc.high_dpi flag during initialization to request
    a full-resolution framebuffer on HighDPI displays. The default behaviour
    is sapp_desc.high_dpi=false, this means that the application will
    render to a lower-resolution framebuffer on HighDPI displays and the
    rendered content will be upscaled by the window system composer.

    In a HighDPI scenario, you still request the same window size during
    sokol_main(), but the framebuffer sizes returned by sapp_width()
    and sapp_height() will be scaled up according to the DPI scaling
    ratio.

    Note that on some platforms the DPI scaling factor may change at any
    time (for instance when a window is moved from a high-dpi display
    to a low-dpi display).

    To query the current DPI scaling factor, call the function:

    float sapp_dpi_scale(void);

    For instance on a Retina Mac, returning the following sapp_desc
    struct from sokol_main():

    sapp_desc sokol_main(void) {
        return (sapp_desc) {
            .width = 640,
            .height = 480,
            .high_dpi = true,
            ...
        };
    }

    ...the functions the functions sapp_width(), sapp_height()
    and sapp_dpi_scale() will return the following values:

    sapp_width:     1280
    sapp_height:    960
    sapp_dpi_scale: 2.0

    If the high_dpi flag is false, or you're not running on a Retina display,
    the values would be:

    sapp_width:     640
    sapp_height:    480
    sapp_dpi_scale: 1.0

    If the window is moved from the Retina display to a low-dpi external display,
    the values would change as follows:

    sapp_width:     1280 => 640
    sapp_height:    960  => 480
    sapp_dpi_scale: 2.0  => 1.0

    Currently there is no event associated with a DPI change, but an
    SAPP_EVENTTYPE_RESIZED will be sent as a side effect of the
    framebuffer size changing.

    Per-monitor DPI is currently supported on macOS and Windows.

    APPLICATION QUIT
    ================
    Without special quit handling, a sokol_app.h application will quit
    'gracefully' when the user clicks the window close-button unless a
    platform's application model prevents this (e.g. on web or mobile).
    'Graceful exit' means that the application-provided cleanup callback will
    be called before the application quits.

    On native desktop platforms sokol_app.h provides more control over the
    application-quit-process. It's possible to initiate a 'programmatic quit'
    from the application code, and a quit initiated by the application user can
    be intercepted (for instance to show a custom dialog box).

    This 'programmatic quit protocol' is implemented through 3 functions
    and 1 event:

        - sapp_quit(): This function simply quits the application without
          giving the user a chance to intervene. Usually this might
          be called when the user clicks the 'Ok' button in a 'Really Quit?'
          dialog box
        - sapp_request_quit(): Calling sapp_request_quit() will send the
          event SAPP_EVENTTYPE_QUIT_REQUESTED to the applications event handler
          callback, giving the user code a chance to intervene and cancel the
          pending quit process (for instance to show a 'Really Quit?' dialog
          box). If the event handler callback does nothing, the application
          will be quit as usual. To prevent this, call the function
          sapp_cancel_quit() from inside the event handler.
        - sapp_cancel_quit(): Cancels a pending quit request, either initiated
          by the user clicking the window close button, or programmatically
          by calling sapp_request_quit(). The only place where calling this
          function makes sense is from inside the event handler callback when
          the SAPP_EVENTTYPE_QUIT_REQUESTED event has been received.
        - SAPP_EVENTTYPE_QUIT_REQUESTED: this event is sent when the user
          clicks the window's close button or application code calls the
          sapp_request_quit() function. The event handler callback code can handle
          this event by calling sapp_cancel_quit() to cancel the quit.
          If the event is ignored, the application will quit as usual.

    On the web platform, the quit behaviour differs from native platforms,
    because of web-specific restrictions:

    A `programmatic quit` initiated by calling sapp_quit() or
    sapp_request_quit() will work as described above: the cleanup callback is
    called, platform-specific cleanup is performed (on the web
    this means that JS event handlers are unregistered), and then
    the request-animation-loop will be exited. However that's all. The
    web page itself will continue to exist (e.g. it's not possible to
    programmatically close the browser tab).

    On the web it's also not possible to run custom code when the user
    closes a browser tab, so it's not possible to prevent this with a
    fancy custom dialog box.

    Instead the standard "Leave Site?" dialog box can be activated (or
    deactivated) with the following function:

        sapp_html5_ask_leave_site(bool ask);

    The initial state of the associated internal flag can be provided
    at startup via sapp_desc.html5_ask_leave_site.

    This feature should only be used sparingly in critical situations - for
    instance when the user would loose data - since popping up modal dialog
    boxes is considered quite rude in the web world. Note that there's no way
    to customize the content of this dialog box or run any code as a result
    of the user's decision. Also note that the user must have interacted with
    the site before the dialog box will appear. These are all security measures
    to prevent fishing.

    The Dear ImGui HighDPI sample contains example code of how to
    implement a 'Really Quit?' dialog box with Dear ImGui (native desktop
    platforms only), and for showing the hardwired "Leave Site?" dialog box
    when running on the web platform:

        https://floooh.github.io/sokol-html5/wasm/imgui-highdpi-sapp.html

    FULLSCREEN
    ==========
    If the sapp_desc.fullscreen flag is true, sokol-app will try to create
    a fullscreen window on platforms with a 'proper' window system
    (mobile devices will always use fullscreen). The implementation details
    depend on the target platform, in general sokol-app will use a
    'soft approach' which doesn't interfere too much with the platform's
    window system (for instance borderless fullscreen window instead of
    a 'real' fullscreen mode). Such details might change over time
    as sokol-app is adapted for different needs.

    The most important effect of fullscreen mode to keep in mind is that
    the requested canvas width and height will be ignored for the initial
    window size, calling sapp_width() and sapp_height() will instead return
    the resolution of the fullscreen canvas (however the provided size
    might still be used for the non-fullscreen window, in case the user can
    switch back from fullscreen- to windowed-mode).

    To toggle fullscreen mode programmatically, call sapp_toggle_fullscreen().

    To check if the application window is currently in fullscreen mode,
    call sapp_is_fullscreen().

    On the web, sapp_desc.fullscreen will have no effect, and the application
    will always start in non-fullscreen mode. Call sapp_toggle_fullscreen()
    from within or 'near' an input event to switch to fullscreen programatically.
    Note that on the web, the fullscreen state may change back to windowed at
    any time (either because the browser had rejected switching into fullscreen,
    or the user leaves fullscreen via Esc), this means that the result
    of sapp_is_fullscreen() may change also without calling sapp_toggle_fullscreen()!


    WINDOW ICON SUPPORT
    ===================
    Some sokol_app.h backends allow to change the window icon programmatically:

        - on Win32: the small icon in the window's title bar, and the
          bigger icon in the task bar
        - on Linux: highly dependent on the used window manager, but usually
          the window's title bar icon and/or the task bar icon
        - on HTML5: the favicon shown in the page's browser tab
        - on macOS: the application icon shown in the dock, but only
          for currently running applications

    NOTE that it is not possible to set the actual application icon which is
    displayed by the operating system on the desktop or 'home screen'. Those
    icons must be provided 'traditionally' through operating-system-specific
    resources which are associated with the application (sokol_app.h might
    later support setting the window icon from platform specific resource data
    though).

    There are two ways to set the window icon:

        - at application start in the sokol_main() function by initializing
          the sapp_desc.icon nested struct
        - or later by calling the function sapp_set_icon()

    As a convenient shortcut, sokol_app.h comes with a builtin default-icon
    (a rainbow-colored 'S', which at least looks a bit better than the Windows
    default icon for applications), which can be activated like this:

    At startup in sokol_main():

        sapp_desc sokol_main(...) {
            return (sapp_desc){
                ...
                icon.sokol_default = true
            };
        }

    Or later by calling:

        sapp_set_icon(&(sapp_icon_desc){ .sokol_default = true });

    NOTE that a completely zero-initialized sapp_icon_desc struct will not
    update the window icon in any way. This is an 'escape hatch' so that you
    can handle the window icon update yourself (or if you do this already,
    sokol_app.h won't get in your way, in this case just leave the
    sapp_desc.icon struct zero-initialized).

    Providing your own icon images works exactly like in GLFW (down to the
    data format):

    You provide one or more 'candidate images' in different sizes, and the
    sokol_app.h platform backends pick the best match for the specific backend
    and icon type.

    For each candidate image, you need to provide:

        - the width in pixels
        - the height in pixels
        - and the actual pixel data in RGBA8 pixel format (e.g. 0xFFCC8844
          on a little-endian CPU means: alpha=0xFF, blue=0xCC, green=0x88, red=0x44)

    For instance, if you have 3 candidate images (small, medium, big) of
    sizes 16x16, 32x32 and 64x64 the corresponding sapp_icon_desc struct is setup
    like this:

        // the actual pixel data (RGBA8, origin top-left)
        const uint32_t small[16][16]  = { ... };
        const uint32_t medium[32][32] = { ... };
        const uint32_t big[64][64]    = { ... };

        const sapp_icon_desc icon_desc = {
            .images = {
                { .width = 16, .height = 16, .pixels = SAPP_RANGE(small) },
                { .width = 32, .height = 32, .pixels = SAPP_RANGE(medium) },
                // ...or without the SAPP_RANGE helper macro:
                { .width = 64, .height = 64, .pixels = { .ptr=big, .size=sizeof(big) } }
            }
        };

    An sapp_icon_desc struct initialized like this can then either be applied
    at application start in sokol_main:

        sapp_desc sokol_main(...) {
            return (sapp_desc){
                ...
                icon = icon_desc
            };
        }

    ...or later by calling sapp_set_icon():

        sapp_set_icon(&icon_desc);

    Some window icon caveats:

        - once the window icon has been updated, there's no way to go back to
          the platform's default icon, this is because some platforms (Linux
          and HTML5) don't switch the icon visual back to the default even if
          the custom icon is deleted or removed
        - on HTML5, if the sokol_app.h icon doesn't show up in the browser
          tab, check that there's no traditional favicon 'link' element
          is defined in the page's index.html, sokol_app.h will only
          append a new favicon link element, but not delete any manually
          defined favicon in the page

    For an example and test of the window icon feature, check out the
    'icon-sapp' sample on the sokol-samples git repository.

    ONSCREEN KEYBOARD
    =================
    On some platforms which don't provide a physical keyboard, sokol-app
    can display the platform's integrated onscreen keyboard for text
    input. To request that the onscreen keyboard is shown, call

        sapp_show_keyboard(true);

    Likewise, to hide the keyboard call:

        sapp_show_keyboard(false);

    Note that onscreen keyboard functionality is no longer supported
    on the browser platform (the previous hacks and workarounds to make browser
    keyboards work for on web applications that don't use HTML UIs
    never really worked across browsers).

    INPUT EVENT BUBBLING ON THE WEB PLATFORM
    ========================================
    By default, input event bubbling on the web platform is configured in
    a way that makes the most sense for 'full-canvas' apps that cover the
    entire browser client window area:

    - mouse, touch and wheel events do not bubble up, this prevents various
      ugly side events, like:
        - HTML text overlays being selected on double- or triple-click into
          the canvas
        - 'scroll bumping' even when the canvas covers the entire client area
    - key_up/down events for 'character keys' *do* bubble up (otherwise
      the browser will not generate UNICODE character events)
    - all other key events *do not* bubble up by default (this prevents side effects
      like F1 opening help, or F7 starting 'caret browsing')
    - character events do not bubble up (although I haven't noticed any side effects
      otherwise)

    Event bubbling can be enabled for input event categories during initialization
    in the sapp_desc struct:

        sapp_desc sokol_main(int argc, char* argv[]) {
            return (sapp_desc){
                //...
                .html5_bubble_mouse_events = true,
                .html5_bubble_touch_events = true,
                .html5_bubble_wheel_events = true,
                .html5_bubble_key_events = true,
                .html5_bubble_char_events = true,
            };
        }

    This basically opens the floodgates and lets *all* input events bubble up to the browser.

    To prevent individual events from bubbling, call sapp_consume_event() from within
    the sokol_app.h event callback when that specific event is reported.


    SETTING THE CANVAS OBJECT ON THE WEB PLATFORM
    =============================================
    On the web, sokol_app.h and the Emscripten SDK functions need to find
    the WebGL/WebGPU canvas intended for rendering and attaching event
    handlers. This can happen in four ways:

    1. do nothing and just set the id of the canvas object to 'canvas' (preferred)
    2. via a CSS Selector string (preferred)
    3. by setting the `Module.canvas` property to the canvas object
    4. by adding the canvas object to the global variable `specialHTMLTargets[]`
       (this is a special variable used by the Emscripten runtime to lookup
       event target objects for which document.querySelector() cannot be used)

    The easiest way is to just name your canvas object 'canvas':

        <canvas id="canvas" ...></canvas>

    This works because the default css selector string used by sokol_app.h
    is '#canvas'.

    If you name your canvas differently, you need to communicate that name to
    sokol_app.h via `sapp_desc.html5_canvas_selector` as a regular css selector
    string that's compatible with `document.querySelector()`. E.g. if your canvas
    object looks like this:

        <canvas id="bla" ...></canvas>

    The `sapp_desc.html5_canvas_selector` string must be set to '#bla':

        .html5_canvas_selector = "#bla"

    If the canvas object cannot be looked up via `document.querySelector()` you
    need to use one of the alternative methods, both involve the special
    Emscripten runtime `Module` object which is usually setup in the index.html
    like this before the WASM blob is loaded and instantiated:

        <script type='text/javascript'>
            var Module = {
                // ...
            };
        </script>

    The first option is to set the `Module.canvas` property to your canvas object:

        <script type='text/javascript'>
            var Module = {
                canvas: my_canvas_object,
            };
        </script>

    When sokol_app.h initializes, it will check the global Module object whether
    a `Module.canvas` property exists and is an object. This method will add
    a new entry to the `specialHTMLTargets[]` object

    The other option is to add the canvas under a name chosen by you to the
    special `specialHTMLTargets[]` map, which is used by the Emscripten runtime
    to lookup 'event target objects' which are not visible to `document.querySelector()`.
    Note that `specialHTMLTargets[]` must be updated after the Emscripten runtime
    has started but before the WASM code is running. A good place for this is
    the special `Module.preRun` array in index.html:

        <script type='text/javascript'>
            var Module = {
                preRun: [
                    () => {
                        specialHTMLTargets['my_canvas'] = my_canvas_object;
                    }
                ],
            };
        </script>

    In that case, pass the same string to sokol_app.h which is used as key
    in the specialHTMLTargets[] map:

        .html5_canvas_selector = "my_canvas"

    If sokol_app.h can't find your canvas for some reason check for warning
    messages on the browser console.


    OPTIONAL: DON'T HIJACK main() (#define SOKOL_NO_ENTRY)
    ======================================================
    NOTE: SOKOL_NO_ENTRY and sapp_run() is currently not supported on Android.

    In its default configuration, sokol_app.h "hijacks" the platform's
    standard main() function. This was done because different platforms
    have different entry point conventions which are not compatible with
    C's main() (for instance WinMain on Windows has completely different
    arguments). However, this "main hijacking" posed a problem for
    usage scenarios like integrating sokol_app.h with other languages than
    C or C++, so an alternative SOKOL_NO_ENTRY mode has been added
    in which the user code provides the platform's main function:

    - define SOKOL_NO_ENTRY before including the sokol_app.h implementation
    - do *not* provide a sokol_main() function
    - instead provide the standard main() function of the platform
    - from the main function, call the function ```sapp_run()``` which
      takes a pointer to an ```sapp_desc``` structure.
    - from here on```sapp_run()``` takes over control and calls the provided
      init-, frame-, event- and cleanup-callbacks just like in the default model.

    sapp_run() behaves differently across platforms:

        - on some platforms, sapp_run() will return when the application quits
        - on other platforms, sapp_run() will never return, even when the
          application quits (the operating system is free to simply terminate
          the application at any time)
        - on Emscripten specifically, sapp_run() will return immediately while
          the frame callback keeps being called

    This different behaviour of sapp_run() essentially means that there shouldn't
    be any code *after* sapp_run(), because that may either never be called, or in
    case of Emscripten will be called at an unexpected time (at application start).

    An application also should not depend on the cleanup-callback being called
    when cross-platform compatibility is required.

    Since sapp_run() returns immediately on Emscripten you shouldn't activate
    the 'EXIT_RUNTIME' linker option (this is disabled by default when compiling
    for the browser target), since the C/C++ exit runtime would be called immediately at
    application start, causing any global objects to be destroyed and global
    variables to be zeroed.

    WINDOWS CONSOLE OUTPUT
    ======================
    On Windows, regular windowed applications don't show any stdout/stderr text
    output, which can be a bit of a hassle for printf() debugging or generally
    logging text to the console. Also, console output by default uses a local
    codepage setting and thus international UTF-8 encoded text is printed
    as garbage.

    To help with these issues, sokol_app.h can be configured at startup
    via the following Windows-specific sapp_desc flags:

        sapp_desc.win32_console_utf8 (default: false)
            When set to true, the output console codepage will be switched
            to UTF-8 (and restored to the original codepage on exit)

        sapp_desc.win32_console_attach (default: false)
            When set to true, stdout and stderr will be attached to the
            console of the parent process (if the parent process actually
            has a console). This means that if the application was started
            in a command line window, stdout and stderr output will be printed
            to the terminal, just like a regular command line program. But if
            the application is started via double-click, it will behave like
            a regular UI application, and stdout/stderr will not be visible.

        sapp_desc.win32_console_create (default: false)
            When set to true, a new console window will be created and
            stdout/stderr will be redirected to that console window. It
            doesn't matter if the application is started from the command
            line or via double-click.

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

        sapp_desc sokol_main(int argc, char* argv[]) {
            return (sapp_desc){
                // ...
                .allocator = {
                    .alloc_fn = my_alloc,
                    .free_fn = my_free,
                    .user_data = ...,
                }
            };
        }

    If no overrides are provided, malloc and free will be used.

    This only affects memory allocation calls done by sokol_app.h
    itself though, not any allocations in OS libraries.


    ERROR REPORTING AND LOGGING
    ===========================
    To get any logging information at all you need to provide a logging callback in the setup call
    the easiest way is to use sokol_log.h:

        #include "sokol_log.h"

        sapp_desc sokol_main(int argc, char* argv[]) {
            return (sapp_desc) {
                ...
                .logger.func = slog_func,
            };
        }

    To override logging with your own callback, first write a logging function like this:

        void my_log(const char* tag,                // e.g. 'sapp'
                    uint32_t log_level,             // 0=panic, 1=error, 2=warn, 3=info
                    uint32_t log_item_id,           // SAPP_LOGITEM_*
                    const char* message_or_null,    // a message string, may be nullptr in release mode
                    uint32_t line_nr,               // line number in sokol_app.h
                    const char* filename_or_null,   // source filename, may be nullptr in release mode
                    void* user_data)
        {
            ...
        }

    ...and then setup sokol-app like this:

        sapp_desc sokol_main(int argc, char* argv[]) {
            return (sapp_desc) {
                ...
                .logger = {
                    .func = my_log,
                    .user_data = my_user_data,
                }
            };
        }

    The provided logging function must be reentrant (e.g. be callable from
    different threads).

    If you don't want to provide your own custom logger it is highly recommended to use
    the standard logger in sokol_log.h instead, otherwise you won't see any warnings or
    errors.

    TEMP NOTE DUMP
    ==============
    - sapp_desc needs a bool whether to initialize depth-stencil surface
    - the Android implementation calls cleanup_cb() and destroys the egl context in onDestroy
      at the latest but should do it earlier, in onStop, as an app is "killable" after onStop
      on Android Honeycomb and later (it can't be done at the moment as the app may be started
      again after onStop and the sokol lifecycle does not yet handle context teardown/bringup)


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

import "core:c"

_ :: c

SOKOL_DEBUG :: #config(SOKOL_DEBUG, ODIN_DEBUG)

DEBUG :: #config(SOKOL_APP_DEBUG, SOKOL_DEBUG)
USE_GL :: #config(SOKOL_USE_GL, false)
USE_DLL :: #config(SOKOL_DLL, false)

when ODIN_OS == .Windows {
    when USE_DLL {
        when USE_GL {
            when DEBUG { foreign import sokol_app_clib { "../sokol_dll_windows_x64_gl_debug.lib" } }
            else       { foreign import sokol_app_clib { "../sokol_dll_windows_x64_gl_release.lib" } }
        } else {
            when DEBUG { foreign import sokol_app_clib { "../sokol_dll_windows_x64_d3d11_debug.lib" } }
            else       { foreign import sokol_app_clib { "../sokol_dll_windows_x64_d3d11_release.lib" } }
        }
    } else {
        when USE_GL {
            when DEBUG { foreign import sokol_app_clib { "sokol_app_windows_x64_gl_debug.lib" } }
            else       { foreign import sokol_app_clib { "sokol_app_windows_x64_gl_release.lib" } }
        } else {
            when DEBUG { foreign import sokol_app_clib { "sokol_app_windows_x64_d3d11_debug.lib" } }
            else       { foreign import sokol_app_clib { "sokol_app_windows_x64_d3d11_release.lib" } }
        }
    }
} else when ODIN_OS == .Darwin {
    when USE_DLL {
             when  USE_GL && ODIN_ARCH == .arm64 &&  DEBUG { foreign import sokol_app_clib { "../dylib/sokol_dylib_macos_arm64_gl_debug.dylib" } }
        else when  USE_GL && ODIN_ARCH == .arm64 && !DEBUG { foreign import sokol_app_clib { "../dylib/sokol_dylib_macos_arm64_gl_release.dylib" } }
        else when  USE_GL && ODIN_ARCH == .amd64 &&  DEBUG { foreign import sokol_app_clib { "../dylib/sokol_dylib_macos_x64_gl_debug.dylib" } }
        else when  USE_GL && ODIN_ARCH == .amd64 && !DEBUG { foreign import sokol_app_clib { "../dylib/sokol_dylib_macos_x64_gl_release.dylib" } }
        else when !USE_GL && ODIN_ARCH == .arm64 &&  DEBUG { foreign import sokol_app_clib { "../dylib/sokol_dylib_macos_arm64_metal_debug.dylib" } }
        else when !USE_GL && ODIN_ARCH == .arm64 && !DEBUG { foreign import sokol_app_clib { "../dylib/sokol_dylib_macos_arm64_metal_release.dylib" } }
        else when !USE_GL && ODIN_ARCH == .amd64 &&  DEBUG { foreign import sokol_app_clib { "../dylib/sokol_dylib_macos_x64_metal_debug.dylib" } }
        else when !USE_GL && ODIN_ARCH == .amd64 && !DEBUG { foreign import sokol_app_clib { "../dylib/sokol_dylib_macos_x64_metal_release.dylib" } }
    } else {
        when USE_GL {
            when ODIN_ARCH == .arm64 {
                when DEBUG { foreign import sokol_app_clib { "sokol_app_macos_arm64_gl_debug.a", "system:Cocoa.framework","system:QuartzCore.framework","system:OpenGL.framework" } }
                else       { foreign import sokol_app_clib { "sokol_app_macos_arm64_gl_release.a", "system:Cocoa.framework","system:QuartzCore.framework","system:OpenGL.framework" } }
            } else {
                when DEBUG { foreign import sokol_app_clib { "sokol_app_macos_x64_gl_debug.a", "system:Cocoa.framework","system:QuartzCore.framework","system:OpenGL.framework" } }
                else       { foreign import sokol_app_clib { "sokol_app_macos_x64_gl_release.a", "system:Cocoa.framework","system:QuartzCore.framework","system:OpenGL.framework" } }
            }
        } else {
            when ODIN_ARCH == .arm64 {
                when DEBUG { foreign import sokol_app_clib { "sokol_app_macos_arm64_metal_debug.a", "system:Cocoa.framework","system:QuartzCore.framework","system:Metal.framework","system:MetalKit.framework" } }
                else       { foreign import sokol_app_clib { "sokol_app_macos_arm64_metal_release.a", "system:Cocoa.framework","system:QuartzCore.framework","system:Metal.framework","system:MetalKit.framework" } }
            } else {
                when DEBUG { foreign import sokol_app_clib { "sokol_app_macos_x64_metal_debug.a", "system:Cocoa.framework","system:QuartzCore.framework","system:Metal.framework","system:MetalKit.framework" } }
                else       { foreign import sokol_app_clib { "sokol_app_macos_x64_metal_release.a", "system:Cocoa.framework","system:QuartzCore.framework","system:Metal.framework","system:MetalKit.framework" } }
            }
        }
    }
} else when ODIN_OS == .Linux {
    when USE_DLL {
        when DEBUG { foreign import sokol_app_clib { "sokol_app_linux_x64_gl_debug.so", "system:X11", "system:Xi", "system:Xcursor", "system:GL", "system:dl", "system:pthread" } }
        else       { foreign import sokol_app_clib { "sokol_app_linux_x64_gl_release.so", "system:X11", "system:Xi", "system:Xcursor", "system:GL", "system:dl", "system:pthread" } }
    } else {
        when DEBUG { foreign import sokol_app_clib { "sokol_app_linux_x64_gl_debug.a", "system:X11", "system:Xi", "system:Xcursor", "system:GL", "system:dl", "system:pthread" } }
        else       { foreign import sokol_app_clib { "sokol_app_linux_x64_gl_release.a", "system:X11", "system:Xi", "system:Xcursor", "system:GL", "system:dl", "system:pthread" } }
    }
} else when ODIN_ARCH == .wasm32 || ODIN_ARCH == .wasm64p32 {
    // Feed sokol_app_wasm_gl_debug.a or sokol_app_wasm_gl_release.a into emscripten compiler.
    foreign import sokol_app_clib { "env.o" }
} else {
    #panic("This OS is currently not supported")
}

@(default_calling_convention="c", link_prefix="sapp_")
foreign sokol_app_clib {
    // returns true after sokol-app has been initialized
    isvalid :: proc() -> bool ---
    // returns the current framebuffer width in pixels
    width :: proc() -> c.int ---
    // same as sapp_width(), but returns float
    widthf :: proc() -> f32 ---
    // returns the current framebuffer height in pixels
    height :: proc() -> c.int ---
    // same as sapp_height(), but returns float
    heightf :: proc() -> f32 ---
    // get default framebuffer color pixel format
    color_format :: proc() -> c.int ---
    // get default framebuffer depth pixel format
    depth_format :: proc() -> c.int ---
    // get default framebuffer sample count
    sample_count :: proc() -> c.int ---
    // returns true when high_dpi was requested and actually running in a high-dpi scenario
    high_dpi :: proc() -> bool ---
    // returns the dpi scaling factor (window pixels to framebuffer pixels)
    dpi_scale :: proc() -> f32 ---
    // show or hide the mobile device onscreen keyboard
    show_keyboard :: proc(show: bool)  ---
    // return true if the mobile device onscreen keyboard is currently shown
    keyboard_shown :: proc() -> bool ---
    // query fullscreen mode
    is_fullscreen :: proc() -> bool ---
    // toggle fullscreen mode
    toggle_fullscreen :: proc()  ---
    // show or hide the mouse cursor
    show_mouse :: proc(show: bool)  ---
    // show or hide the mouse cursor
    mouse_shown :: proc() -> bool ---
    // enable/disable mouse-pointer-lock mode
    lock_mouse :: proc(lock: bool)  ---
    // return true if in mouse-pointer-lock mode (this may toggle a few frames later)
    mouse_locked :: proc() -> bool ---
    // set mouse cursor type
    set_mouse_cursor :: proc(cursor: Mouse_Cursor)  ---
    // get current mouse cursor type
    get_mouse_cursor :: proc() -> Mouse_Cursor ---
    // associate a custom mouse cursor image to a sapp_mouse_cursor enum entry
    bind_mouse_cursor_image :: proc(cursor: Mouse_Cursor, #by_ptr desc: Image_Desc) -> Mouse_Cursor ---
    // restore the sapp_mouse_cursor enum entry to it's default system appearance
    unbind_mouse_cursor_image :: proc(cursor: Mouse_Cursor)  ---
    // return the userdata pointer optionally provided in sapp_desc
    userdata :: proc() -> rawptr ---
    // return a copy of the sapp_desc structure
    query_desc :: proc() -> Desc ---
    // initiate a "soft quit" (sends SAPP_EVENTTYPE_QUIT_REQUESTED)
    request_quit :: proc()  ---
    // cancel a pending quit (when SAPP_EVENTTYPE_QUIT_REQUESTED has been received)
    cancel_quit :: proc()  ---
    // initiate a "hard quit" (quit application without sending SAPP_EVENTTYPE_QUIT_REQUESTED)
    quit :: proc()  ---
    // call from inside event callback to consume the current event (don't forward to platform)
    consume_event :: proc()  ---
    // get the current frame counter (for comparison with sapp_event.frame_count)
    frame_count :: proc() -> u64 ---
    // get an averaged/smoothed frame duration in seconds
    frame_duration :: proc() -> f64 ---
    // write string into clipboard
    set_clipboard_string :: proc(str: cstring)  ---
    // read string from clipboard (usually during SAPP_EVENTTYPE_CLIPBOARD_PASTED)
    get_clipboard_string :: proc() -> cstring ---
    // set the window title (only on desktop platforms)
    set_window_title :: proc(str: cstring)  ---
    // set the window icon (only on Windows and Linux)
    set_icon :: proc(#by_ptr icon_desc: Icon_Desc)  ---
    // gets the total number of dropped files (after an SAPP_EVENTTYPE_FILES_DROPPED event)
    get_num_dropped_files :: proc() -> c.int ---
    // gets the dropped file paths
    get_dropped_file_path :: proc(#any_int index: c.int) -> cstring ---
    // special run-function for SOKOL_NO_ENTRY (in standard mode this is an empty stub)
    run :: proc(#by_ptr desc: Desc)  ---
    // EGL: get EGLDisplay object
    egl_get_display :: proc() -> rawptr ---
    // EGL: get EGLContext object
    egl_get_context :: proc() -> rawptr ---
    // HTML5: enable or disable the hardwired "Leave Site?" dialog box
    html5_ask_leave_site :: proc(ask: bool)  ---
    // HTML5: get byte size of a dropped file
    html5_get_dropped_file_size :: proc(#any_int index: c.int) -> u32 ---
    // HTML5: asynchronously load the content of a dropped file
    html5_fetch_dropped_file :: proc(#by_ptr request: Html5_Fetch_Request)  ---
    // Metal: get bridged pointer to Metal device object
    metal_get_device :: proc() -> rawptr ---
    // Metal: get bridged pointer to MTKView's current drawable of type CAMetalDrawable
    metal_get_current_drawable :: proc() -> rawptr ---
    // Metal: get bridged pointer to MTKView's depth-stencil texture of type MTLTexture
    metal_get_depth_stencil_texture :: proc() -> rawptr ---
    // Metal: get bridged pointer to MTKView's msaa-color-texture of type MTLTexture (may be null)
    metal_get_msaa_color_texture :: proc() -> rawptr ---
    // macOS: get bridged pointer to macOS NSWindow
    macos_get_window :: proc() -> rawptr ---
    // iOS: get bridged pointer to iOS UIWindow
    ios_get_window :: proc() -> rawptr ---
    // D3D11: get pointer to ID3D11Device object
    d3d11_get_device :: proc() -> rawptr ---
    // D3D11: get pointer to ID3D11DeviceContext object
    d3d11_get_device_context :: proc() -> rawptr ---
    // D3D11: get pointer to IDXGISwapChain object
    d3d11_get_swap_chain :: proc() -> rawptr ---
    // D3D11: get pointer to ID3D11RenderTargetView object for rendering
    d3d11_get_render_view :: proc() -> rawptr ---
    // D3D11: get pointer ID3D11RenderTargetView object for msaa-resolve (may return null)
    d3d11_get_resolve_view :: proc() -> rawptr ---
    // D3D11: get pointer ID3D11DepthStencilView
    d3d11_get_depth_stencil_view :: proc() -> rawptr ---
    // Win32: get the HWND window handle
    win32_get_hwnd :: proc() -> rawptr ---
    // WebGPU: get WGPUDevice handle
    wgpu_get_device :: proc() -> rawptr ---
    // WebGPU: get swapchain's WGPUTextureView handle for rendering
    wgpu_get_render_view :: proc() -> rawptr ---
    // WebGPU: get swapchain's MSAA-resolve WGPUTextureView (may return null)
    wgpu_get_resolve_view :: proc() -> rawptr ---
    // WebGPU: get swapchain's WGPUTextureView for the depth-stencil surface
    wgpu_get_depth_stencil_view :: proc() -> rawptr ---
    // GL: get framebuffer object
    gl_get_framebuffer :: proc() -> u32 ---
    // GL: get major version
    gl_get_major_version :: proc() -> c.int ---
    // GL: get minor version
    gl_get_minor_version :: proc() -> c.int ---
    // GL: return true if the context is GLES
    gl_is_gles :: proc() -> bool ---
    // X11: get Window
    x11_get_window :: proc() -> rawptr ---
    // X11: get Display
    x11_get_display :: proc() -> rawptr ---
    // Android: get native activity handle
    android_get_native_activity :: proc() -> rawptr ---
}

// misc constants
MAX_TOUCHPOINTS :: 8
MAX_MOUSEBUTTONS :: 3
MAX_KEYCODES :: 512
MAX_ICONIMAGES :: 8

/*
    sapp_event_type

    The type of event that's passed to the event handler callback
    in the sapp_event.type field. These are not just "traditional"
    input events, but also notify the application about state changes
    or other user-invoked actions.
*/
Event_Type :: enum i32 {
    INVALID,
    KEY_DOWN,
    KEY_UP,
    CHAR,
    MOUSE_DOWN,
    MOUSE_UP,
    MOUSE_SCROLL,
    MOUSE_MOVE,
    MOUSE_ENTER,
    MOUSE_LEAVE,
    TOUCHES_BEGAN,
    TOUCHES_MOVED,
    TOUCHES_ENDED,
    TOUCHES_CANCELLED,
    RESIZED,
    ICONIFIED,
    RESTORED,
    FOCUSED,
    UNFOCUSED,
    SUSPENDED,
    RESUMED,
    QUIT_REQUESTED,
    CLIPBOARD_PASTED,
    FILES_DROPPED,
}

/*
    sapp_keycode

    The 'virtual keycode' of a KEY_DOWN or KEY_UP event in the
    struct field sapp_event.key_code.

    Note that the keycode values are identical with GLFW.
*/
Keycode :: enum i32 {
    INVALID = 0,
    SPACE = 32,
    APOSTROPHE = 39,
    COMMA = 44,
    MINUS = 45,
    PERIOD = 46,
    SLASH = 47,
    _0 = 48,
    _1 = 49,
    _2 = 50,
    _3 = 51,
    _4 = 52,
    _5 = 53,
    _6 = 54,
    _7 = 55,
    _8 = 56,
    _9 = 57,
    SEMICOLON = 59,
    EQUAL = 61,
    A = 65,
    B = 66,
    C = 67,
    D = 68,
    E = 69,
    F = 70,
    G = 71,
    H = 72,
    I = 73,
    J = 74,
    K = 75,
    L = 76,
    M = 77,
    N = 78,
    O = 79,
    P = 80,
    Q = 81,
    R = 82,
    S = 83,
    T = 84,
    U = 85,
    V = 86,
    W = 87,
    X = 88,
    Y = 89,
    Z = 90,
    LEFT_BRACKET = 91,
    BACKSLASH = 92,
    RIGHT_BRACKET = 93,
    GRAVE_ACCENT = 96,
    WORLD_1 = 161,
    WORLD_2 = 162,
    ESCAPE = 256,
    ENTER = 257,
    TAB = 258,
    BACKSPACE = 259,
    INSERT = 260,
    DELETE = 261,
    RIGHT = 262,
    LEFT = 263,
    DOWN = 264,
    UP = 265,
    PAGE_UP = 266,
    PAGE_DOWN = 267,
    HOME = 268,
    END = 269,
    CAPS_LOCK = 280,
    SCROLL_LOCK = 281,
    NUM_LOCK = 282,
    PRINT_SCREEN = 283,
    PAUSE = 284,
    F1 = 290,
    F2 = 291,
    F3 = 292,
    F4 = 293,
    F5 = 294,
    F6 = 295,
    F7 = 296,
    F8 = 297,
    F9 = 298,
    F10 = 299,
    F11 = 300,
    F12 = 301,
    F13 = 302,
    F14 = 303,
    F15 = 304,
    F16 = 305,
    F17 = 306,
    F18 = 307,
    F19 = 308,
    F20 = 309,
    F21 = 310,
    F22 = 311,
    F23 = 312,
    F24 = 313,
    F25 = 314,
    KP_0 = 320,
    KP_1 = 321,
    KP_2 = 322,
    KP_3 = 323,
    KP_4 = 324,
    KP_5 = 325,
    KP_6 = 326,
    KP_7 = 327,
    KP_8 = 328,
    KP_9 = 329,
    KP_DECIMAL = 330,
    KP_DIVIDE = 331,
    KP_MULTIPLY = 332,
    KP_SUBTRACT = 333,
    KP_ADD = 334,
    KP_ENTER = 335,
    KP_EQUAL = 336,
    LEFT_SHIFT = 340,
    LEFT_CONTROL = 341,
    LEFT_ALT = 342,
    LEFT_SUPER = 343,
    RIGHT_SHIFT = 344,
    RIGHT_CONTROL = 345,
    RIGHT_ALT = 346,
    RIGHT_SUPER = 347,
    MENU = 348,
}

/*
    Android specific 'tool type' enum for touch events. This lets the
    application check what type of input device was used for
    touch events.

    NOTE: the values must remain in sync with the corresponding
    Android SDK type, so don't change those.

    See https://developer.android.com/reference/android/view/MotionEvent#TOOL_TYPE_UNKNOWN
*/
Android_Tooltype :: enum i32 {
    UNKNOWN = 0,
    FINGER = 1,
    STYLUS = 2,
    MOUSE = 3,
}

/*
    sapp_touchpoint

    Describes a single touchpoint in a multitouch event (TOUCHES_BEGAN,
    TOUCHES_MOVED, TOUCHES_ENDED).

    Touch points are stored in the nested array sapp_event.touches[],
    and the number of touches is stored in sapp_event.num_touches.
*/
Touchpoint :: struct {
    identifier : c.uintptr_t,
    pos_x : f32,
    pos_y : f32,
    android_tooltype : Android_Tooltype,
    changed : bool,
}

/*
    sapp_mousebutton

    The currently pressed mouse button in the events MOUSE_DOWN
    and MOUSE_UP, stored in the struct field sapp_event.mouse_button.
*/
Mousebutton :: enum i32 {
    LEFT = 0,
    RIGHT = 1,
    MIDDLE = 2,
    INVALID = 256,
}

/*
    These are currently pressed modifier keys (and mouse buttons) which are
    passed in the event struct field sapp_event.modifiers.
*/
MODIFIER_SHIFT :: 1
MODIFIER_CTRL :: 2
MODIFIER_ALT :: 4
MODIFIER_SUPER :: 8
MODIFIER_LMB :: 256
MODIFIER_RMB :: 512
MODIFIER_MMB :: 1024

/*
    sapp_event

    This is an all-in-one event struct passed to the event handler
    user callback function. Note that it depends on the event
    type what struct fields actually contain useful values, so you
    should first check the event type before reading other struct
    fields.
*/
Event :: struct {
    frame_count : u64,
    type : Event_Type,
    key_code : Keycode,
    char_code : u32,
    key_repeat : bool,
    modifiers : u32,
    mouse_button : Mousebutton,
    mouse_x : f32,
    mouse_y : f32,
    mouse_dx : f32,
    mouse_dy : f32,
    scroll_x : f32,
    scroll_y : f32,
    num_touches : c.int,
    touches : [8]Touchpoint,
    window_width : c.int,
    window_height : c.int,
    framebuffer_width : c.int,
    framebuffer_height : c.int,
}

/*
    sg_range

    A general pointer/size-pair struct and constructor macros for passing binary blobs
    into sokol_app.h.
*/
Range :: struct {
    ptr : rawptr,
    size : c.size_t,
}

/*
    sapp_image_desc

    This is used to describe image data to sokol_app.h (window icons and cursor images).

    The pixel format is RGBA8.

    cursor_hotspot_x and _y are used only for cursors, to define which pixel
    of the image should be aligned with the mouse position.
*/
Image_Desc :: struct {
    width : c.int,
    height : c.int,
    cursor_hotspot_x : c.int,
    cursor_hotspot_y : c.int,
    pixels : Range,
}

/*
    sapp_icon_desc

    An icon description structure for use in sapp_desc.icon and
    sapp_set_icon().

    When setting a custom image, the application can provide a number of
    candidates differing in size, and sokol_app.h will pick the image(s)
    closest to the size expected by the platform's window system.

    To set sokol-app's default icon, set .sokol_default to true.

    Otherwise provide candidate images of different sizes in the
    images[] array.

    If both the sokol_default flag is set to true, any image candidates
    will be ignored and the sokol_app.h default icon will be set.
*/
Icon_Desc :: struct {
    sokol_default : bool,
    images : [8]Image_Desc,
}

/*
    sapp_allocator

    Used in sapp_desc to provide custom memory-alloc and -free functions
    to sokol_app.h. If memory management should be overridden, both the
    alloc_fn and free_fn function must be provided (e.g. it's not valid to
    override one function but not the other).
*/
Allocator :: struct {
    alloc_fn : proc "c" (a0: c.size_t, a1: rawptr) -> rawptr,
    free_fn : proc "c" (a0: rawptr, a1: rawptr),
    user_data : rawptr,
}

Log_Item :: enum i32 {
    OK,
    MALLOC_FAILED,
    MACOS_INVALID_NSOPENGL_PROFILE,
    WIN32_LOAD_OPENGL32_DLL_FAILED,
    WIN32_CREATE_HELPER_WINDOW_FAILED,
    WIN32_HELPER_WINDOW_GETDC_FAILED,
    WIN32_DUMMY_CONTEXT_SET_PIXELFORMAT_FAILED,
    WIN32_CREATE_DUMMY_CONTEXT_FAILED,
    WIN32_DUMMY_CONTEXT_MAKE_CURRENT_FAILED,
    WIN32_GET_PIXELFORMAT_ATTRIB_FAILED,
    WIN32_WGL_FIND_PIXELFORMAT_FAILED,
    WIN32_WGL_DESCRIBE_PIXELFORMAT_FAILED,
    WIN32_WGL_SET_PIXELFORMAT_FAILED,
    WIN32_WGL_ARB_CREATE_CONTEXT_REQUIRED,
    WIN32_WGL_ARB_CREATE_CONTEXT_PROFILE_REQUIRED,
    WIN32_WGL_OPENGL_VERSION_NOT_SUPPORTED,
    WIN32_WGL_OPENGL_PROFILE_NOT_SUPPORTED,
    WIN32_WGL_INCOMPATIBLE_DEVICE_CONTEXT,
    WIN32_WGL_CREATE_CONTEXT_ATTRIBS_FAILED_OTHER,
    WIN32_D3D11_CREATE_DEVICE_AND_SWAPCHAIN_WITH_DEBUG_FAILED,
    WIN32_D3D11_GET_IDXGIFACTORY_FAILED,
    WIN32_D3D11_GET_IDXGIADAPTER_FAILED,
    WIN32_D3D11_QUERY_INTERFACE_IDXGIDEVICE1_FAILED,
    WIN32_REGISTER_RAW_INPUT_DEVICES_FAILED_MOUSE_LOCK,
    WIN32_REGISTER_RAW_INPUT_DEVICES_FAILED_MOUSE_UNLOCK,
    WIN32_GET_RAW_INPUT_DATA_FAILED,
    WIN32_DESTROYICON_FOR_CURSOR_FAILED,
    LINUX_GLX_LOAD_LIBGL_FAILED,
    LINUX_GLX_LOAD_ENTRY_POINTS_FAILED,
    LINUX_GLX_EXTENSION_NOT_FOUND,
    LINUX_GLX_QUERY_VERSION_FAILED,
    LINUX_GLX_VERSION_TOO_LOW,
    LINUX_GLX_NO_GLXFBCONFIGS,
    LINUX_GLX_NO_SUITABLE_GLXFBCONFIG,
    LINUX_GLX_GET_VISUAL_FROM_FBCONFIG_FAILED,
    LINUX_GLX_REQUIRED_EXTENSIONS_MISSING,
    LINUX_GLX_CREATE_CONTEXT_FAILED,
    LINUX_GLX_CREATE_WINDOW_FAILED,
    LINUX_X11_CREATE_WINDOW_FAILED,
    LINUX_EGL_BIND_OPENGL_API_FAILED,
    LINUX_EGL_BIND_OPENGL_ES_API_FAILED,
    LINUX_EGL_GET_DISPLAY_FAILED,
    LINUX_EGL_INITIALIZE_FAILED,
    LINUX_EGL_NO_CONFIGS,
    LINUX_EGL_NO_NATIVE_VISUAL,
    LINUX_EGL_GET_VISUAL_INFO_FAILED,
    LINUX_EGL_CREATE_WINDOW_SURFACE_FAILED,
    LINUX_EGL_CREATE_CONTEXT_FAILED,
    LINUX_EGL_MAKE_CURRENT_FAILED,
    LINUX_X11_OPEN_DISPLAY_FAILED,
    LINUX_X11_QUERY_SYSTEM_DPI_FAILED,
    LINUX_X11_DROPPED_FILE_URI_WRONG_SCHEME,
    LINUX_X11_FAILED_TO_BECOME_OWNER_OF_CLIPBOARD,
    ANDROID_UNSUPPORTED_INPUT_EVENT_INPUT_CB,
    ANDROID_UNSUPPORTED_INPUT_EVENT_MAIN_CB,
    ANDROID_READ_MSG_FAILED,
    ANDROID_WRITE_MSG_FAILED,
    ANDROID_MSG_CREATE,
    ANDROID_MSG_RESUME,
    ANDROID_MSG_PAUSE,
    ANDROID_MSG_FOCUS,
    ANDROID_MSG_NO_FOCUS,
    ANDROID_MSG_SET_NATIVE_WINDOW,
    ANDROID_MSG_SET_INPUT_QUEUE,
    ANDROID_MSG_DESTROY,
    ANDROID_UNKNOWN_MSG,
    ANDROID_LOOP_THREAD_STARTED,
    ANDROID_LOOP_THREAD_DONE,
    ANDROID_NATIVE_ACTIVITY_ONSTART,
    ANDROID_NATIVE_ACTIVITY_ONRESUME,
    ANDROID_NATIVE_ACTIVITY_ONSAVEINSTANCESTATE,
    ANDROID_NATIVE_ACTIVITY_ONWINDOWFOCUSCHANGED,
    ANDROID_NATIVE_ACTIVITY_ONPAUSE,
    ANDROID_NATIVE_ACTIVITY_ONSTOP,
    ANDROID_NATIVE_ACTIVITY_ONNATIVEWINDOWCREATED,
    ANDROID_NATIVE_ACTIVITY_ONNATIVEWINDOWDESTROYED,
    ANDROID_NATIVE_ACTIVITY_ONINPUTQUEUECREATED,
    ANDROID_NATIVE_ACTIVITY_ONINPUTQUEUEDESTROYED,
    ANDROID_NATIVE_ACTIVITY_ONCONFIGURATIONCHANGED,
    ANDROID_NATIVE_ACTIVITY_ONLOWMEMORY,
    ANDROID_NATIVE_ACTIVITY_ONDESTROY,
    ANDROID_NATIVE_ACTIVITY_DONE,
    ANDROID_NATIVE_ACTIVITY_ONCREATE,
    ANDROID_CREATE_THREAD_PIPE_FAILED,
    ANDROID_NATIVE_ACTIVITY_CREATE_SUCCESS,
    WGPU_DEVICE_LOST,
    WGPU_DEVICE_LOG,
    WGPU_DEVICE_UNCAPTURED_ERROR,
    WGPU_SWAPCHAIN_CREATE_SURFACE_FAILED,
    WGPU_SWAPCHAIN_SURFACE_GET_CAPABILITIES_FAILED,
    WGPU_SWAPCHAIN_CREATE_DEPTH_STENCIL_TEXTURE_FAILED,
    WGPU_SWAPCHAIN_CREATE_DEPTH_STENCIL_VIEW_FAILED,
    WGPU_SWAPCHAIN_CREATE_MSAA_TEXTURE_FAILED,
    WGPU_SWAPCHAIN_CREATE_MSAA_VIEW_FAILED,
    WGPU_SWAPCHAIN_GETCURRENTTEXTURE_FAILED,
    WGPU_REQUEST_DEVICE_STATUS_ERROR,
    WGPU_REQUEST_DEVICE_STATUS_UNKNOWN,
    WGPU_REQUEST_ADAPTER_STATUS_UNAVAILABLE,
    WGPU_REQUEST_ADAPTER_STATUS_ERROR,
    WGPU_REQUEST_ADAPTER_STATUS_UNKNOWN,
    WGPU_CREATE_INSTANCE_FAILED,
    IMAGE_DATA_SIZE_MISMATCH,
    DROPPED_FILE_PATH_TOO_LONG,
    CLIPBOARD_STRING_TOO_BIG,
}

/*
    sapp_logger

    Used in sapp_desc to provide a logging function. Please be aware that
    without logging function, sokol-app will be completely silent, e.g. it will
    not report errors or warnings. For maximum error verbosity, compile in
    debug mode (e.g. NDEBUG *not* defined) and install a logger (for instance
    the standard logging function from sokol_log.h).
*/
Logger :: struct {
    func : proc "c" (a0: cstring, a1: u32, a2: u32, a3: cstring, a4: u32, a5: cstring, a6: rawptr),
    user_data : rawptr,
}

/*
    sokol-app initialization options, used as return value of sokol_main()
    or sapp_run() argument.
*/
Desc :: struct {
    init_cb : proc "c" (),
    frame_cb : proc "c" (),
    cleanup_cb : proc "c" (),
    event_cb : proc "c" (a0: ^Event),
    user_data : rawptr,
    init_userdata_cb : proc "c" (a0: rawptr),
    frame_userdata_cb : proc "c" (a0: rawptr),
    cleanup_userdata_cb : proc "c" (a0: rawptr),
    event_userdata_cb : proc "c" (a0: ^Event, a1: rawptr),
    width : c.int,
    height : c.int,
    sample_count : c.int,
    swap_interval : c.int,
    high_dpi : bool,
    fullscreen : bool,
    alpha : bool,
    window_title : cstring,
    enable_clipboard : bool,
    clipboard_size : c.int,
    enable_dragndrop : bool,
    max_dropped_files : c.int,
    max_dropped_file_path_length : c.int,
    icon : Icon_Desc,
    allocator : Allocator,
    logger : Logger,
    gl_major_version : c.int,
    gl_minor_version : c.int,
    win32_console_utf8 : bool,
    win32_console_create : bool,
    win32_console_attach : bool,
    html5_canvas_selector : cstring,
    html5_canvas_resize : bool,
    html5_preserve_drawing_buffer : bool,
    html5_premultiplied_alpha : bool,
    html5_ask_leave_site : bool,
    html5_update_document_title : bool,
    html5_bubble_mouse_events : bool,
    html5_bubble_touch_events : bool,
    html5_bubble_wheel_events : bool,
    html5_bubble_key_events : bool,
    html5_bubble_char_events : bool,
    html5_use_emsc_set_main_loop : bool,
    html5_emsc_set_main_loop_simulate_infinite_loop : bool,
    ios_keyboard_resizes_canvas : bool,
}

/*
    HTML5 specific: request and response structs for
      asynchronously loading dropped-file content.
*/
Html5_Fetch_Error :: enum i32 {
    FETCH_ERROR_NO_ERROR,
    FETCH_ERROR_BUFFER_TOO_SMALL,
    FETCH_ERROR_OTHER,
}

Html5_Fetch_Response :: struct {
    succeeded : bool,
    error_code : Html5_Fetch_Error,
    file_index : c.int,
    data : Range,
    buffer : Range,
    user_data : rawptr,
}

Html5_Fetch_Request :: struct {
    dropped_file_index : c.int,
    callback : proc "c" (a0: ^Html5_Fetch_Response),
    buffer : Range,
    user_data : rawptr,
}

/*
    sapp_mouse_cursor

    Predefined cursor image definitions, set with sapp_set_mouse_cursor(sapp_mouse_cursor cursor)
*/
Mouse_Cursor :: enum i32 {
    DEFAULT = 0,
    ARROW,
    IBEAM,
    CROSSHAIR,
    POINTING_HAND,
    RESIZE_EW,
    RESIZE_NS,
    RESIZE_NWSE,
    RESIZE_NESW,
    RESIZE_ALL,
    NOT_ALLOWED,
    CUSTOM_0,
    CUSTOM_1,
    CUSTOM_2,
    CUSTOM_3,
    CUSTOM_4,
    CUSTOM_5,
    CUSTOM_6,
    CUSTOM_7,
    CUSTOM_8,
    CUSTOM_9,
    CUSTOM_10,
    CUSTOM_11,
    CUSTOM_12,
    CUSTOM_13,
    CUSTOM_14,
    CUSTOM_15,
}

