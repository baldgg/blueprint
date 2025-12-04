package fmod_core

/* ======================================================================================== */
/* FMOD Core API - output development header file.                                          */
/* Copyright (c), Firelight Technologies Pty, Ltd. 2004-2023.                               */
/*                                                                                          */
/* Use this header if you are wanting to develop your own output plugin to use with         */
/* FMOD's output system.  With this header you can make your own output plugin that FMOD    */
/* can register and use.  See the documentation and examples on how to make a working       */
/* plugin.                                                                                  */
/*                                                                                          */
/* For more detail visit:                                                                   */
/* https://fmod.com/docs/2.02/api/plugin-api-output.html                                    */
/* ======================================================================================== */



///////////////////////////////////////////////////////////////////////////////////////////////////////
// Output constants
//

OUTPUT_PLUGIN_VERSION :: 5

OUTPUT_METHOD :: enum u32 {
    MIX_DIRECT   = 0,
    MIX_BUFFERED = 1,
}



///////////////////////////////////////////////////////////////////////////////////////////////////////
// Output callbacks
//

OUTPUT_GETNUMDRIVERS_CALLBACK :: #type proc "cdecl" (
    output_state: ^OUTPUT_STATE,
    numdrivers: ^i32,
) -> RESULT

OUTPUT_GETDRIVERINFO_CALLBACK :: #type proc "cdecl" (
    output_state: ^OUTPUT_STATE,
    id: i32,
    name: [^]u8,
    namelen: i32,
    guid: ^GUID,
    systemrate: ^i32,
    speakermode: ^SPEAKERMODE,
    speakermodechannels: ^i32,
) -> RESULT

OUTPUT_INIT_CALLBACK :: #type proc "cdecl" (
    output_state: ^OUTPUT_STATE,
    selecteddriver: i32,
    flags: INITFLAGS,
    outputrate: ^i32,
    speakermode: ^SPEAKERMODE,
    speakermodechannels: ^i32,
    outputformat: ^SOUND_FORMAT,
    dspbufferlength: i32,
    dspnumbuffers: ^i32,
    dspnumadditionalbuffers: ^i32,
    extradriverdata: rawptr,
) -> RESULT

OUTPUT_START_CALLBACK :: #type proc "cdecl" (output_state: ^OUTPUT_STATE) -> RESULT
OUTPUT_STOP_CALLBACK :: #type proc "cdecl" (output_state: ^OUTPUT_STATE) -> RESULT
OUTPUT_CLOSE_CALLBACK :: #type proc "cdecl" (output_state: ^OUTPUT_STATE) -> RESULT
OUTPUT_UPDATE_CALLBACK :: #type proc "cdecl" (output_state: ^OUTPUT_STATE) -> RESULT
OUTPUT_GETHANDLE_CALLBACK :: #type proc "cdecl" (output_state: ^OUTPUT_STATE, handle: ^rawptr) -> RESULT
OUTPUT_MIXER_CALLBACK :: #type proc "cdecl" (output_state: ^OUTPUT_STATE) -> RESULT

OUTPUT_OBJECT3DGETINFO_CALLBACK :: #type proc "cdecl" (
    output_state: ^OUTPUT_STATE,
    maxhardwareobjects: ^i32,
) -> RESULT

OUTPUT_OBJECT3DALLOC_CALLBACK :: #type proc "cdecl" (
    output_state: ^OUTPUT_STATE,
    object3d: ^rawptr,
) -> RESULT

OUTPUT_OBJECT3DFREE_CALLBACK :: #type proc "cdecl" (
    output_state: ^OUTPUT_STATE,
    object3d: rawptr,
) -> RESULT

OUTPUT_OBJECT3DUPDATE_CALLBACK :: #type proc "cdecl" (
    output_state: ^OUTPUT_STATE,
    object3d: rawptr,
    #by_ptr info: OUTPUT_OBJECT3DINFO,
) -> RESULT

OUTPUT_OPENPORT_CALLBACK :: #type proc "cdecl" (
    output_state: ^OUTPUT_STATE,
    portType: PORT_TYPE,
    portIndex: PORT_INDEX,
    portId: ^i32,
    portRate: ^i32,
    portChannels: ^i32,
    portFormat: ^SOUND_FORMAT,
) -> RESULT

OUTPUT_CLOSEPORT_CALLBACK :: #type proc "cdecl" (output_state: ^OUTPUT_STATE, portId: i32) -> RESULT
OUTPUT_DEVICELISTCHANGED_CALLBACK :: #type proc "cdecl" (output_state: ^OUTPUT_STATE) -> RESULT

OUTPUT_READFROMMIXER_FUNC :: #type proc "cdecl" (
    output_state: ^OUTPUT_STATE,
    buffer: rawptr,
    length: u32,
) -> RESULT

OUTPUT_COPYPORT_FUNC :: #type proc "cdecl" (
    output_state: ^OUTPUT_STATE,
    portId: i32,
    buffer: rawptr,
    length: u32,
) -> RESULT

OUTPUT_REQUESTRESET_FUNC :: #type proc "cdecl" (output_state: ^OUTPUT_STATE) -> RESULT
OUTPUT_ALLOC_FUNC :: #type proc "cdecl" (size: u32, align: u32, file: cstring, line: i32) -> rawptr
OUTPUT_FREE_FUNC :: #type proc "cdecl" (ptr: rawptr, file: cstring, line: i32)

OUTPUT_LOG_FUNC :: #type proc "cdecl" (
    level: DEBUG_FLAGS,
    file: cstring,
    line: i32,
    function: cstring,
    str: cstring,
    #c_vararg args: ..any,
)



///////////////////////////////////////////////////////////////////////////////////////////////////////
// Output structures
//

OUTPUT_DESCRIPTION :: struct {
    apiversion:        u32,
    name:              cstring,
    version:           u32,
    method:            OUTPUT_METHOD,
    getnumdrivers:     OUTPUT_GETNUMDRIVERS_CALLBACK,
    getdriverinfo:     OUTPUT_GETDRIVERINFO_CALLBACK,
    init:              OUTPUT_INIT_CALLBACK,
    start:             OUTPUT_START_CALLBACK,
    stop:              OUTPUT_STOP_CALLBACK,
    close:             OUTPUT_CLOSE_CALLBACK,
    update:            OUTPUT_UPDATE_CALLBACK,
    gethandle:         OUTPUT_GETHANDLE_CALLBACK,
    mixer:             OUTPUT_MIXER_CALLBACK,
    object3dgetinfo:   OUTPUT_OBJECT3DGETINFO_CALLBACK,
    object3dalloc:     OUTPUT_OBJECT3DALLOC_CALLBACK,
    object3dfree:      OUTPUT_OBJECT3DFREE_CALLBACK,
    object3dupdate:    OUTPUT_OBJECT3DUPDATE_CALLBACK,
    openport:          OUTPUT_OPENPORT_CALLBACK,
    closeport:         OUTPUT_CLOSEPORT_CALLBACK,
    devicelistchanged: OUTPUT_DEVICELISTCHANGED_CALLBACK,
}

OUTPUT_STATE :: struct {
    plugindata:    rawptr,
    readfrommixer: OUTPUT_READFROMMIXER_FUNC,
    alloc:         OUTPUT_ALLOC_FUNC,
    free:          OUTPUT_FREE_FUNC,
    log:           OUTPUT_LOG_FUNC,
    copyport:      OUTPUT_COPYPORT_FUNC,
    requestreset:  OUTPUT_REQUESTRESET_FUNC,
}

OUTPUT_OBJECT3DINFO :: struct {
    buffer:       [^]f32,
    bufferlength: u32,
    position:     VECTOR,
    gain:         f32,
    spread:       f32,
    priority:     f32,
}



///////////////////////////////////////////////////////////////////////////////////////////////////////
// Output macros
//

/*
#define OUTPUT_READFROMMIXER(_state, _buffer, _length) \
    (_state)->readfrommixer(_state, _buffer, _length)
#define OUTPUT_ALLOC(_state, _size, _align) \
    (_state)->alloc(_size, _align, __FILE__, __LINE__)
#define OUTPUT_FREE(_state, _ptr) \
    (_state)->free(_ptr, __FILE__, __LINE__)
#define OUTPUT_LOG(_state, _level, _location, _format, ...) \
    (_state)->log(_level, __FILE__, __LINE__, _location, _format, ##__VA_ARGS__)
#define OUTPUT_COPYPORT(_state, _id, _buffer, _length) \
    (_state)->copyport(_state, _id, _buffer, _length)
#define OUTPUT_REQUESTRESET(_state) \
    (_state)->requestreset(_state)
*/
