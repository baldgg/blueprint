package fmod_studio

/* ======================================================================================== */
/* FMOD Studio API - Common C/C++ header file.                                              */
/* Copyright (c), Firelight Technologies Pty, Ltd. 2004-2023.                               */
/*                                                                                          */
/* This header defines common enumerations, structs and callbacks that are shared between   */
/* the C and C++ i32erfaces.                                                                */
/*                                                                                          */
/* For more detail visit:                                                                   */
/* https://fmod.com/docs/2.02/api/studio-api.html                                           */
/* ======================================================================================== */

import fmod "../core"



///////////////////////////////////////////////////////////////////////////////////////////////////////
// FMOD Studio types
//

SYSTEM :: struct {}
EVENTDESCRIPTION :: struct {}
EVENTINSTANCE :: struct {}
BUS :: struct {}
VCA :: struct {}
BANK :: struct {}
COMMANDREPLAY :: struct {}



///////////////////////////////////////////////////////////////////////////////////////////////////////
// FMOD Studio constants
//

LOAD_MEMORY_ALIGNMENT :: 32

INITFLAGS :: distinct u32
INIT_NORMAL :: 0x00000000
INIT_LIVEUPDATE :: 0x00000001
INIT_ALLOW_MISSING_PLUGINS :: 0x00000002
INIT_SYNCHRONOUS_UPDATE :: 0x00000004
INIT_DEFERRED_CALLBACKS :: 0x00000008
INIT_LOAD_FROM_UPDATE :: 0x00000010
INIT_MEMORY_TRACKING :: 0x00000020

PARAMETER_FLAGS :: distinct u32
PARAMETER_READONLY :: 0x00000001
PARAMETER_AUTOMATIC :: 0x00000002
PARAMETER_GLOBAL :: 0x00000004
PARAMETER_DISCRETE :: 0x00000008
PARAMETER_LABELED :: 0x00000010

SYSTEM_CALLBACK_TYPE :: distinct u32
SYSTEM_CALLBACK_PREUPDATE :: 0x00000001
SYSTEM_CALLBACK_POSTUPDATE :: 0x00000002
SYSTEM_CALLBACK_BANK_UNLOAD :: 0x00000004
SYSTEM_CALLBACK_LIVEUPDATE_CONNECTED :: 0x00000008
SYSTEM_CALLBACK_LIVEUPDATE_DISCONNECTED :: 0x00000010
SYSTEM_CALLBACK_ALL :: 0xFFFFFFFF

EVENT_CALLBACK_TYPE :: distinct u32
EVENT_CALLBACK_CREATED :: 0x00000001
EVENT_CALLBACK_DESTROYED :: 0x00000002
EVENT_CALLBACK_STARTING :: 0x00000004
EVENT_CALLBACK_STARTED :: 0x00000008
EVENT_CALLBACK_RESTARTED :: 0x00000010
EVENT_CALLBACK_STOPPED :: 0x00000020
EVENT_CALLBACK_START_FAILED :: 0x00000040
EVENT_CALLBACK_CREATE_PROGRAMMER_SOUND :: 0x00000080
EVENT_CALLBACK_DESTROY_PROGRAMMER_SOUND :: 0x00000100
EVENT_CALLBACK_PLUGIN_CREATED :: 0x00000200
EVENT_CALLBACK_PLUGIN_DESTROYED :: 0x00000400
EVENT_CALLBACK_TIMELINE_MARKER :: 0x00000800
EVENT_CALLBACK_TIMELINE_BEAT :: 0x00001000
EVENT_CALLBACK_SOUND_PLAYED :: 0x00002000
EVENT_CALLBACK_SOUND_STOPPED :: 0x00004000
EVENT_CALLBACK_REAL_TO_VIRTUAL :: 0x00008000
EVENT_CALLBACK_VIRTUAL_TO_REAL :: 0x00010000
EVENT_CALLBACK_START_EVENT_COMMAND :: 0x00020000
EVENT_CALLBACK_NESTED_TIMELINE_BEAT :: 0x00040000
EVENT_CALLBACK_ALL :: 0xFFFFFFFF

LOAD_BANK_FLAGS :: distinct u32
LOAD_BANK_NORMAL :: 0x00000000
LOAD_BANK_NONBLOCKING :: 0x00000001
LOAD_BANK_DECOMPRESS_SAMPLES :: 0x00000002
LOAD_BANK_UNENCRYPTED :: 0x00000004

COMMANDCAPTURE_FLAGS :: distinct u32
COMMANDCAPTURE_NORMAL :: 0x00000000
COMMANDCAPTURE_FILEFLUSH :: 0x00000001
COMMANDCAPTURE_SKIP_INITIAL_STATE :: 0x00000002

COMMANDREPLAY_FLAGS :: distinct u32
COMMANDREPLAY_NORMAL :: 0x00000000
COMMANDREPLAY_SKIP_CLEANUP :: 0x00000001
COMMANDREPLAY_FAST_FORWARD :: 0x00000002
COMMANDREPLAY_SKIP_BANK_LOAD :: 0x00000004

LOADING_STATE :: enum i32 {
    LOADING_STATE_UNLOADING,
    LOADING_STATE_UNLOADED,
    LOADING_STATE_LOADING,
    LOADING_STATE_LOADED,
    LOADING_STATE_ERROR,
}

LOAD_MEMORY_MODE :: enum i32 {
    LOAD_MEMORY,
    LOAD_MEMORY_POINT,
}

PARAMETER_TYPE :: enum i32 {
    PARAMETER_GAME_CONTROLLED,
    PARAMETER_AUTOMATIC_DISTANCE,
    PARAMETER_AUTOMATIC_EVENT_CONE_ANGLE,
    PARAMETER_AUTOMATIC_EVENT_ORIENTATION,
    PARAMETER_AUTOMATIC_DIRECTION,
    PARAMETER_AUTOMATIC_ELEVATION,
    PARAMETER_AUTOMATIC_LISTENER_ORIENTATION,
    PARAMETER_AUTOMATIC_SPEED,
    PARAMETER_AUTOMATIC_SPEED_ABSOLUTE,
    PARAMETER_AUTOMATIC_DISTANCE_NORMALIZED,
}

USER_PROPERTY_TYPE :: enum i32 {
    USER_PROPERTY_TYPE_INTEGER,
    USER_PROPERTY_TYPE_BOOLEAN,
    USER_PROPERTY_TYPE_FLOAT,
    USER_PROPERTY_TYPE_STRING,
}

EVENT_PROPERTY :: enum i32 {
    EVENT_PROPERTY_CHANNELPRIORITY,
    EVENT_PROPERTY_SCHEDULE_DELAY,
    EVENT_PROPERTY_SCHEDULE_LOOKAHEAD,
    EVENT_PROPERTY_MINIMUM_DISTANCE,
    EVENT_PROPERTY_MAXIMUM_DISTANCE,
    EVENT_PROPERTY_COOLDOWN,
    EVENT_PROPERTY_MAX,
}

PLAYBACK_STATE :: enum i32 {
    PLAYBACK_PLAYING,
    PLAYBACK_SUSTAINING,
    PLAYBACK_STOPPED,
    PLAYBACK_STARTING,
    PLAYBACK_STOPPING,
}

STOP_MODE :: enum i32 {
    STOP_ALLOWFADEOUT,
    STOP_IMMEDIATE,
}

INSTANCETYPE :: enum i32 {
    INSTANCETYPE_NONE,
    INSTANCETYPE_SYSTEM,
    INSTANCETYPE_EVENTDESCRIPTION,
    INSTANCETYPE_EVENTINSTANCE,
    INSTANCETYPE_PARAMETERINSTANCE,
    INSTANCETYPE_BUS,
    INSTANCETYPE_VCA,
    INSTANCETYPE_BANK,
    INSTANCETYPE_COMMANDREPLAY,
}



///////////////////////////////////////////////////////////////////////////////////////////////////////
// FMOD Studio structures
//

BANK_INFO :: struct {
    size:           i32,
    userdata:       rawptr,
    userdatalength: i32,
    opencallback:   fmod.FILE_OPEN_CALLBACK,
    closecallback:  fmod.FILE_CLOSE_CALLBACK,
    readcallback:   fmod.FILE_READ_CALLBACK,
    seekcallback:   fmod.FILE_SEEK_CALLBACK,
}

PARAMETER_ID :: struct {
    data1: u32,
    data2: u32,
}

PARAMETER_DESCRIPTION :: struct {
    name:         cstring,
    id:           PARAMETER_ID,
    minimum:      f32,
    maximum:      f32,
    defaultvalue: f32,
    type:         PARAMETER_TYPE,
    flags:        PARAMETER_FLAGS,
    guid:         fmod.GUID,
}

USER_PROPERTY :: struct {
    name:       cstring,
    type:       USER_PROPERTY_TYPE,
    using data: struct #raw_union {
        i32value:    i32,
        boolvalue:   b32,
        f32value:    f32,
        stringvalue: cstring,
    },
}

PROGRAMMER_SOUND_PROPERTIES :: struct {
    name:          cstring,
    sound:         ^fmod.SOUND,
    subsoundIndex: i32,
}

PLUGIN_INSTANCE_PROPERTIES :: struct {
    name: cstring,
    dsp:  ^fmod.DSP,
}

TIMELINE_MARKER_PROPERTIES :: struct {
    name:     cstring,
    position: i32,
}

TIMELINE_BEAT_PROPERTIES :: struct {
    bar:                i32,
    beat:               i32,
    position:           i32,
    tempo:              f32,
    timesignatureupper: i32,
    timesignaturelower: i32,
}

TIMELINE_NESTED_BEAT_PROPERTIES :: struct {
    eventid:    fmod.GUID,
    properties: TIMELINE_BEAT_PROPERTIES,
}

ADVANCEDSETTINGS :: struct {
    cbsize:                 i32,
    commandqueuesize:       u32,
    handleinitialsize:      u32,
    studioupdateperiod:     i32,
    idlesampledatapoolsize: i32,
    streamingscheduledelay: u32,
    encryptionkey:          cstring,
}

CPU_USAGE :: struct {
    update: f32,
}

BUFFER_INFO :: struct {
    currentusage: i32,
    peakusage:    i32,
    capacity:     i32,
    stallcount:   i32,
    stalltime:    f32,
}

BUFFER_USAGE :: struct {
    studiocommandqueue: BUFFER_INFO,
    studiohandle:       BUFFER_INFO,
}

SOUND_INFO :: struct {
    name_or_data:  cstring,
    mode:          fmod.MODE,
    exinfo:        fmod.CREATESOUNDEXINFO,
    subsoundindex: i32,
}

COMMAND_INFO :: struct {
    commandname:        cstring,
    parentcommandindex: i32,
    framenumber:        i32,
    frametime:          f32,
    instancetype:       INSTANCETYPE,
    outputtype:         INSTANCETYPE,
    instancehandle:     u32,
    outputhandle:       u32,
}

MEMORY_USAGE :: struct {
    exclusive:  i32,
    inclusive:  i32,
    sampledata: i32,
}



///////////////////////////////////////////////////////////////////////////////////////////////////////
// FMOD Studio callbacks.
//


SYSTEM_CALLBACK :: #type proc(
    system: ^SYSTEM,
    _type: SYSTEM_CALLBACK_TYPE,
    commanddata: rawptr,
    userdata: rawptr,
) -> fmod.RESULT

EVENT_CALLBACK :: #type proc(
    _type: EVENT_CALLBACK_TYPE,
    event: ^EVENTINSTANCE,
    parameters: rawptr,
) -> fmod.RESULT

COMMANDREPLAY_FRAME_CALLBACK :: #type proc(
    replay: ^COMMANDREPLAY,
    commandindex: i32,
    currenttime: f32,
    userdata: rawptr,
) -> fmod.RESULT

COMMANDREPLAY_LOAD_BANK_CALLBACK :: #type proc(
    replay: ^COMMANDREPLAY,
    commandindex: i32,
    #by_ptr bankguid: fmod.GUID,
    bankfilename: cstring,
    flags: LOAD_BANK_FLAGS,
    bank: ^^BANK,
    userdata: rawptr,
) -> fmod.RESULT

COMMANDREPLAY_CREATE_INSTANCE_CALLBACK :: #type proc(
    replay: ^COMMANDREPLAY,
    commandindex: i32,
    eventdescription: ^EVENTDESCRIPTION,
    instance: ^^EVENTINSTANCE,
    userdata: rawptr,
) -> fmod.RESULT
