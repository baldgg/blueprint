package fmod_core

/* ======================================================================================== */
/* FMOD Core API - Codec development header file.                                           */
/* Copyright (c), Firelight Technologies Pty, Ltd. 2004-2023.                               */
/*                                                                                          */
/* Use this header if you are wanting to develop your own file format plugin to use with    */
/* FMOD's codec system.  With this header you can make your own fileformat plugin that FMOD */
/* can register and use.  See the documentation and examples on how to make a working       */
/* plugin.                                                                                  */
/*                                                                                          */
/* For more detail visit:                                                                   */
/* https://fmod.com/docs/2.02/api/core-api.html                                             */
/* ======================================================================================== */



///////////////////////////////////////////////////////////////////////////////////////////////////////
// Codec constants
//

CODEC_PLUGIN_VERSION :: 1

CODEC_SEEK_METHOD :: enum i32 {
    SET     = 0,
    CURRENT = 1,
    END     = 2,
}



///////////////////////////////////////////////////////////////////////////////////////////////////////
// Codec callbacks
//

CODEC_OPEN_CALLBACK :: #type proc "cdecl" (
    codec_state: ^CODEC_STATE,
    usermode: MODE,
    userexinfo: ^CREATESOUNDEXINFO,
) -> RESULT

CODEC_CLOSE_CALLBACK :: #type proc "cdecl" (codec_state: ^CODEC_STATE) -> RESULT

CODEC_READ_CALLBACK :: #type proc "cdecl" (
    codec_state: ^CODEC_STATE,
    buffer: rawptr,
    samples_in: u32,
    samples_out: ^u32,
) -> RESULT

CODEC_GETLENGTH_CALLBACK :: #type proc "cdecl" (
    codec_state: ^CODEC_STATE,
    length: ^u32,
    lengthtype: TIMEUNIT,
) -> RESULT

CODEC_SETPOSITION_CALLBACK :: #type proc "cdecl" (
    codec_state: ^CODEC_STATE,
    subsound: i32,
    position: u32,
    postype: TIMEUNIT,
) -> RESULT

CODEC_GETPOSITION_CALLBACK :: #type proc "cdecl" (
    codec_state: ^CODEC_STATE,
    position: ^u32,
    postype: TIMEUNIT,
) -> RESULT

CODEC_SOUNDCREATE_CALLBACK :: #type proc "cdecl" (
    codec_state: ^CODEC_STATE,
    subsound: i32,
    sound: ^SOUND,
) -> RESULT

CODEC_GETWAVEFORMAT_CALLBACK :: #type proc "cdecl" (
    codec_state: ^CODEC_STATE,
    index: i32,
    waveformat: ^CODEC_WAVEFORMAT,
) -> RESULT



///////////////////////////////////////////////////////////////////////////////////////////////////////
// Codec functions
//

CODEC_METADATA_FUNC :: #type proc "cdecl" (
    codec_state: ^CODEC_STATE,
    tagtype: TAGTYPE,
    name: [^]u8,
    data: rawptr,
    datalen: u32,
    datatype: TAGDATATYPE,
    unique: i32,
) -> RESULT

CODEC_ALLOC_FUNC :: #type proc "cdecl" (size: u32, align: u32, file: cstring, line: i32) -> rawptr
CODEC_FREE_FUNC :: #type proc "cdecl" (ptr: rawptr, file: cstring, line: i32)

CODEC_LOG_FUNC :: #type proc "cdecl" (
    level: DEBUG_FLAGS,
    file: cstring,
    line: i32,
    function: cstring,
    str: cstring,
    #c_vararg args: ..any,
)

CODEC_FILE_READ_FUNC :: #type proc "cdecl" (
    codec_state: ^CODEC_STATE,
    buffer: rawptr,
    sizebytes: u32,
    bytesread: ^u32,
) -> RESULT

CODEC_FILE_SEEK_FUNC :: #type proc "cdecl" (
    codec_state: ^CODEC_STATE,
    pos: u32,
    method: CODEC_SEEK_METHOD,
) -> RESULT

CODEC_FILE_TELL_FUNC :: #type proc "cdecl" (codec_state: ^CODEC_STATE, pos: ^u32) -> RESULT
CODEC_FILE_SIZE_FUNC :: #type proc "cdecl" (codec_state: ^CODEC_STATE, size: ^u32) -> RESULT



///////////////////////////////////////////////////////////////////////////////////////////////////////
// Codec structures
//

CODEC_DESCRIPTION :: struct {
    apiversion:      u32,
    name:            cstring,
    version:         u32,
    defaultasstream: i32,
    timeunits:       TIMEUNIT,
    open:            CODEC_OPEN_CALLBACK,
    close:           CODEC_CLOSE_CALLBACK,
    read:            CODEC_READ_CALLBACK,
    getlength:       CODEC_GETLENGTH_CALLBACK,
    setposition:     CODEC_SETPOSITION_CALLBACK,
    getposition:     CODEC_GETPOSITION_CALLBACK,
    soundcreate:     CODEC_SOUNDCREATE_CALLBACK,
    getwaveformat:   CODEC_GETWAVEFORMAT_CALLBACK,
}

CODEC_WAVEFORMAT :: struct {
    name:         cstring,
    format:       SOUND_FORMAT,
    channels:     i32,
    frequency:    i32,
    lengthbytes:  u32,
    lengthpcm:    u32,
    pcmblocksize: u32,
    loopstart:    i32,
    loopend:      i32,
    mode:         MODE,
    channelmask:  CHANNELMASK,
    channelorder: CHANNELORDER,
    peakvolume:   f32,
}

CODEC_STATE_FUNCTIONS :: struct {
    metadata: CODEC_METADATA_FUNC,
    alloc:    CODEC_ALLOC_FUNC,
    free:     CODEC_FREE_FUNC,
    log:      CODEC_LOG_FUNC,
    read:     CODEC_FILE_READ_FUNC,
    seek:     CODEC_FILE_SEEK_FUNC,
    tell:     CODEC_FILE_TELL_FUNC,
    size:     CODEC_FILE_SIZE_FUNC,
}

CODEC_STATE :: struct {
    plugindata:   rawptr,
    waveformat:   ^CODEC_WAVEFORMAT,
    functions:    ^CODEC_STATE_FUNCTIONS,
    numsubsounds: i32,
}



///////////////////////////////////////////////////////////////////////////////////////////////////////
// Codec macros
//

/*
#define CODEC_METADATA(_state, _tagtype, _name, _data, _datalen, _datatype, _unique) \
    (_state)->functions->metadata(_state, _tagtype, _name, _data, _datalen, _datatype, _unique)
#define CODEC_ALLOC(_state, _size, _align) \
    (_state)->functions->alloc(_size, _align, __FILE__, __LINE__)
#define CODEC_FREE(_state, _ptr) \
    (_state)->functions->free(_ptr, __FILE__, __LINE__)
#define CODEC_LOG(_state, _level, _location, _format, ...) \
    (_state)->functions->log(_level, __FILE__, __LINE__, _location, _format, __VA_ARGS__)
#define CODEC_FILE_READ(_state, _buffer, _sizebytes, _bytesread) \
    (_state)->functions->read(_state, _buffer, _sizebytes, _bytesread)
#define CODEC_FILE_SEEK(_state, _pos, _method) \
    (_state)->functions->seek(_state, _pos, _method)
#define CODEC_FILE_TELL(_state, _pos) \
    (_state)->functions->tell(_state, _pos)
#define CODEC_FILE_SIZE(_state, _size) \
    (_state)->functions->size(_state, _size)
*/
