package fmod_core

/* ======================================================================================== */
/* FMOD Core API - DSP header file.                                                         */
/* Copyright (c), Firelight Technologies Pty, Ltd. 2004-2023.                               */
/*                                                                                          */
/* Use this header if you are wanting to develop your own DSP plugin to use with FMODs      */
/* dsp system.  With this header you can make your own DSP plugin that FMOD can             */
/* register and use.  See the documentation and examples on how to make a working plugin.   */
/*                                                                                          */
/* For more detail visit:                                                                   */
/* https://fmod.com/docs/2.02/api/plugin-api-dsp.html                                       */
/* =========================================================================================*/



///////////////////////////////////////////////////////////////////////////////////////////////////////
// DSP Constants
//

PLUGIN_SDK_VERSION :: 110
DSP_GETPARAM_VALUESTR_LENGTH :: 32

DSP_PROCESS_OPERATION :: enum i32 {
    DSP_PROCESS_PERFORM,
    DSP_PROCESS_QUERY,
}

DSP_PAN_SURROUND_FLAGS :: enum i32 {
    DSP_PAN_SURROUND_DEFAULT             = 0,
    DSP_PAN_SURROUND_ROTATION_NOT_BIASED = 1,
}

DSP_PARAMETER_TYPE :: enum i32 {
    DSP_PARAMETER_TYPE_FLOAT,
    DSP_PARAMETER_TYPE_INT,
    DSP_PARAMETER_TYPE_BOOL,
    DSP_PARAMETER_TYPE_DATA,
}

DSP_PARAMETER_FLOAT_MAPPING_TYPE :: enum i32 {
    DSP_PARAMETER_FLOAT_MAPPING_TYPE_LINEAR,
    DSP_PARAMETER_FLOAT_MAPPING_TYPE_AUTO,
    DSP_PARAMETER_FLOAT_MAPPING_TYPE_PIECEWISE_LINEAR,
}

DSP_PARAMETER_DATA_TYPE :: enum i32 {
    DSP_PARAMETER_DATA_TYPE_USER               = 0,
    DSP_PARAMETER_DATA_TYPE_OVERALLGAIN        = -1,
    DSP_PARAMETER_DATA_TYPE_3DATTRIBUTES       = -2,
    DSP_PARAMETER_DATA_TYPE_SIDECHAIN          = -3,
    DSP_PARAMETER_DATA_TYPE_FFT                = -4,
    DSP_PARAMETER_DATA_TYPE_3DATTRIBUTES_MULTI = -5,
    DSP_PARAMETER_DATA_TYPE_ATTENUATION_RANGE  = -6,
}



///////////////////////////////////////////////////////////////////////////////////////////////////////
// DSP Callbacks
//

DSP_CREATE_CALLBACK :: #type proc "cdecl" (dsp_state: ^DSP_STATE) -> RESULT

DSP_RELEASE_CALLBACK :: #type proc "cdecl" (dsp_state: ^DSP_STATE) -> RESULT

DSP_RESET_CALLBACK :: #type proc "cdecl" (dsp_state: ^DSP_STATE) -> RESULT

DSP_READ_CALLBACK :: #type proc "cdecl" (
    dsp_state: ^DSP_STATE,
    inbuffer: ^f32,
    outbuffer: ^f32,
    length: u32,
    inchannels: i32,
    outchannels: ^i32,
) -> RESULT

DSP_PROCESS_CALLBACK :: #type proc "cdecl" (
    dsp_state: ^DSP_STATE,
    length: u32,
    #by_ptr inbufferarray: DSP_BUFFER_ARRAY,
    outbufferarray: [^]DSP_BUFFER_ARRAY,
    inputsidle: b32,
    op: DSP_PROCESS_OPERATION,
) -> RESULT

DSP_SETPOSITION_CALLBACK :: #type proc "cdecl" (dsp_state: ^DSP_STATE, pos: u32) -> RESULT

DSP_SHOULDIPROCESS_CALLBACK :: #type proc "cdecl" (
    dsp_state: ^DSP_STATE,
    inputsidle: b32,
    length: u32,
    inmask: CHANNELMASK,
    inchannels: i32,
    speakermode: SPEAKERMODE,
) -> RESULT

DSP_SETPARAM_FLOAT_CALLBACK :: #type proc "cdecl" (dsp_state: ^DSP_STATE, index: i32, value: f32) -> RESULT

DSP_SETPARAM_INT_CALLBACK :: #type proc "cdecl" (dsp_state: ^DSP_STATE, index: i32, value: i32) -> RESULT

DSP_SETPARAM_BOOL_CALLBACK :: #type proc "cdecl" (dsp_state: ^DSP_STATE, index: i32, value: b32) -> RESULT

DSP_SETPARAM_DATA_CALLBACK :: #type proc "cdecl" (
    dsp_state: ^DSP_STATE,
    index: i32,
    data: rawptr,
    length: u32,
) -> RESULT

DSP_GETPARAM_FLOAT_CALLBACK :: #type proc "cdecl" (
    dsp_state: ^DSP_STATE,
    index: i32,
    value: ^f32,
    valuestr: [^]u8,
) -> RESULT

DSP_GETPARAM_INT_CALLBACK :: #type proc "cdecl" (
    dsp_state: ^DSP_STATE,
    index: i32,
    value: ^i32,
    valuestr: [^]u8,
) -> RESULT

DSP_GETPARAM_BOOL_CALLBACK :: #type proc "cdecl" (
    dsp_state: ^DSP_STATE,
    index: i32,
    value: b32,
    valuestr: [^]u8,
) -> RESULT

DSP_GETPARAM_DATA_CALLBACK :: #type proc "cdecl" (
    dsp_state: ^DSP_STATE,
    index: i32,
    data: ^rawptr,
    length: ^u32,
    valuestr: [^]u8,
) -> RESULT

DSP_SYSTEM_REGISTER_CALLBACK :: #type proc "cdecl" (dsp_state: ^DSP_STATE) -> RESULT

DSP_SYSTEM_DEREGISTER_CALLBACK :: #type proc "cdecl" (dsp_state: ^DSP_STATE) -> RESULT

DSP_SYSTEM_MIX_CALLBACK :: #type proc "cdecl" (dsp_state: ^DSP_STATE, stage: i32) -> RESULT



///////////////////////////////////////////////////////////////////////////////////////////////////////
// DSP Functions
//


DSP_ALLOC_FUNC :: #type proc "cdecl" (size: u32, type: MEMORY_TYPE, sourcestr: cstring) -> rawptr

DSP_REALLOC_FUNC :: #type proc "cdecl" (
    ptr: rawptr,
    size: u32,
    type: MEMORY_TYPE,
    sourcestr: cstring,
) -> rawptr

DSP_FREE_FUNC :: #type proc "cdecl" (ptr: rawptr, type: MEMORY_TYPE, sourcestr: cstring)

DSP_LOG_FUNC :: #type proc "cdecl" (
    level: DEBUG_FLAGS,
    file: cstring,
    line: i32,
    function: cstring,
    str: cstring,
    #c_vararg args: ..any,
)

DSP_GETSAMPLERATE_FUNC :: #type proc "cdecl" (dsp_state: ^DSP_STATE, rate: ^i32) -> RESULT
DSP_GETBLOCKSIZE_FUNC :: #type proc "cdecl" (dsp_state: ^DSP_STATE, blocksize: ^u32) -> RESULT

DSP_GETSPEAKERMODE_FUNC :: #type proc "cdecl" (
    dsp_state: ^DSP_STATE,
    speakermode_mixer: ^SPEAKERMODE,
    speakermode_output: ^SPEAKERMODE,
) -> RESULT

DSP_GETCLOCK_FUNC :: #type proc "cdecl" (
    dsp_state: ^DSP_STATE,
    clock: ^uint,
    offset: ^u32,
    length: ^u32,
) -> RESULT

DSP_GETLISTENERATTRIBUTES_FUNC :: #type proc "cdecl" (
    dsp_state: ^DSP_STATE,
    numlisteners: ^i32,
    attributes: ^_3D_ATTRIBUTES,
) -> RESULT

DSP_GETUSERDATA_FUNC :: #type proc "cdecl" (dsp_state: ^DSP_STATE, userdata: ^rawptr) -> RESULT

DSP_DFT_FFTREAL_FUNC :: #type proc "cdecl" (
    dsp_state: ^DSP_STATE,
    size: i32,
    #by_ptr signal: f32,
    dft: ^COMPLEX,
    #by_ptr window: f32,
    signalhop: i32,
) -> RESULT

DSP_DFT_IFFTREAL_FUNC :: #type proc "cdecl" (
    dsp_state: ^DSP_STATE,
    size: i32,
    #by_ptr dft: COMPLEX,
    signal: ^f32,
    #by_ptr window: f32,
    signalhop: i32,
) -> RESULT

DSP_PAN_SUMMONOMATRIX_FUNC :: #type proc "cdecl" (
    dsp_state: ^DSP_STATE,
    sourceSpeakerMode: SPEAKERMODE,
    lowFrequencyGain: f32,
    overallGain: f32,
    _matrix: ^f32,
) -> RESULT

DSP_PAN_SUMSTEREOMATRIX_FUNC :: #type proc "cdecl" (
    dsp_state: ^DSP_STATE,
    sourceSpeakerMode: SPEAKERMODE,
    pan: f32,
    lowFrequencyGain: f32,
    overallGain: f32,
    matrixHop: i32,
    _matrix: ^f32,
) -> RESULT

DSP_PAN_SUMSURROUNDMATRIX_FUNC :: #type proc "cdecl" (
    dsp_state: ^DSP_STATE,
    sourceSpeakerMode: SPEAKERMODE,
    targetSpeakerMode: SPEAKERMODE,
    direction: f32,
    extent: f32,
    rotation: f32,
    lowFrequencyGain: f32,
    overallGain: f32,
    matrixHop: i32,
    _matrix: ^f32,
    flags: DSP_PAN_SURROUND_FLAGS,
) -> RESULT

DSP_PAN_SUMMONOTOSURROUNDMATRIX_FUNC :: #type proc "cdecl" (
    dsp_state: ^DSP_STATE,
    targetSpeakerMode: SPEAKERMODE,
    direction: f32,
    extent: f32,
    lowFrequencyGain: f32,
    overallGain: f32,
    matrixHop: i32,
    _matrix: ^f32,
) -> RESULT

DSP_PAN_SUMSTEREOTOSURROUNDMATRIX_FUNC :: #type proc "cdecl" (
    dsp_state: ^DSP_STATE,
    targetSpeakerMode: SPEAKERMODE,
    direction: f32,
    extent: f32,
    rotation: f32,
    lowFrequencyGain: f32,
    overallGain: f32,
    matrixHop: i32,
    _matrix: ^f32,
) -> RESULT

DSP_PAN_GETROLLOFFGAIN_FUNC :: #type proc "cdecl" (
    dsp_state: ^DSP_STATE,
    rolloff: DSP_PAN_3D_ROLLOFF_TYPE,
    distance: f32,
    mindistance: f32,
    maxdistance: f32,
    gain: ^f32,
) -> RESULT



///////////////////////////////////////////////////////////////////////////////////////////////////////
// DSP Structures
//

DSP_BUFFER_ARRAY :: struct {
    numbuffers:        i32,
    buffernumchannels: ^i32,
    bufferchannelmask: ^CHANNELMASK,
    buffers:           ^^f32,
    speakermode:       SPEAKERMODE,
}

COMPLEX :: struct {
    real: f32,
    imag: f32,
}

DSP_PARAMETER_FLOAT_MAPPING_PIECEWISE_LINEAR :: struct {
    numpoints:        i32,
    pointparamvalues: ^f32,
    pointpositions:   ^f32,
}

DSP_PARAMETER_FLOAT_MAPPING :: struct {
    _type:                  DSP_PARAMETER_FLOAT_MAPPING_TYPE,
    piecewiselinearmapping: DSP_PARAMETER_FLOAT_MAPPING_PIECEWISE_LINEAR,
}

DSP_PARAMETER_DESC_FLOAT :: struct {
    min:        f32,
    max:        f32,
    defaultval: f32,
    mapping:    DSP_PARAMETER_FLOAT_MAPPING,
}

DSP_PARAMETER_DESC_INT :: struct {
    min:        i32,
    max:        i32,
    defaultval: i32,
    goestoinf:  b32,
    valuenames: [^]cstring,
}

DSP_PARAMETER_DESC_BOOL :: struct {
    defaultval: b32,
    valuenames: [^]cstring,
}

DSP_PARAMETER_DESC_DATA :: struct {
    datatype: i32,
}

DSP_PARAMETER_DESC :: struct {
    type:        DSP_PARAMETER_TYPE,
    name:        [16]u8,
    label:       [16]u8,
    description: cstring,
    using data:  struct #raw_union {
        floatdesc: DSP_PARAMETER_DESC_FLOAT,
        intdesc:   DSP_PARAMETER_DESC_INT,
        booldesc:  DSP_PARAMETER_DESC_BOOL,
        datadesc:  DSP_PARAMETER_DESC_DATA,
    },
}

DSP_PARAMETER_OVERALLGAIN :: struct {
    linear_gain:          f32,
    linear_gain_additive: f32,
}

DSP_PARAMETER_3DATTRIBUTES :: struct {
    relative: _3D_ATTRIBUTES,
    absolute: _3D_ATTRIBUTES,
}

DSP_PARAMETER_3DATTRIBUTES_MULTI :: struct {
    numlisteners: i32,
    relative:     [MAX_LISTENERS]_3D_ATTRIBUTES,
    weight:       [MAX_LISTENERS]f32,
    absolute:     _3D_ATTRIBUTES,
}

DSP_PARAMETER_ATTENUATION_RANGE :: struct {
    min: f32,
    max: f32,
}

DSP_PARAMETER_SIDECHAIN :: struct {
    sidechainenable: b32,
}

DSP_PARAMETER_FFT :: struct {
    length:      i32,
    numchannels: i32,
    spectrum:    [32]^f32,
}

DSP_DESCRIPTION :: struct {
    pluginsdkversion:  u32,
    name:              [32]u8,
    version:           u32,
    numinputbuffers:   i32,
    numoutputbuffers:  i32,
    create:            DSP_CREATE_CALLBACK,
    release:           DSP_RELEASE_CALLBACK,
    reset:             DSP_RESET_CALLBACK,
    read:              DSP_READ_CALLBACK,
    process:           DSP_PROCESS_CALLBACK,
    setposition:       DSP_SETPOSITION_CALLBACK,
    numparameters:     i32,
    paramdesc:         ^^DSP_PARAMETER_DESC,
    setparameterfloat: DSP_SETPARAM_FLOAT_CALLBACK,
    setparameterint:   DSP_SETPARAM_INT_CALLBACK,
    setparameterbool:  DSP_SETPARAM_BOOL_CALLBACK,
    setparameterdata:  DSP_SETPARAM_DATA_CALLBACK,
    getparameterfloat: DSP_GETPARAM_FLOAT_CALLBACK,
    getparameterint:   DSP_GETPARAM_INT_CALLBACK,
    getparameterbool:  DSP_GETPARAM_BOOL_CALLBACK,
    getparameterdata:  DSP_GETPARAM_DATA_CALLBACK,
    shouldiprocess:    DSP_SHOULDIPROCESS_CALLBACK,
    userdata:          rawptr,
    sys_register:      DSP_SYSTEM_REGISTER_CALLBACK,
    sys_deregister:    DSP_SYSTEM_DEREGISTER_CALLBACK,
    sys_mix:           DSP_SYSTEM_MIX_CALLBACK,
}

DSP_STATE_DFT_FUNCTIONS :: struct {
    fftreal:        DSP_DFT_FFTREAL_FUNC,
    inversefftreal: DSP_DFT_IFFTREAL_FUNC,
}

DSP_STATE_PAN_FUNCTIONS :: struct {
    summonomatrix:             DSP_PAN_SUMMONOMATRIX_FUNC,
    sumstereomatrix:           DSP_PAN_SUMSTEREOMATRIX_FUNC,
    sumsurroundmatrix:         DSP_PAN_SUMSURROUNDMATRIX_FUNC,
    summonotosurroundmatrix:   DSP_PAN_SUMMONOTOSURROUNDMATRIX_FUNC,
    sumstereotosurroundmatrix: DSP_PAN_SUMSTEREOTOSURROUNDMATRIX_FUNC,
    getrolloffgain:            DSP_PAN_GETROLLOFFGAIN_FUNC,
}

DSP_STATE_FUNCTIONS :: struct {
    alloc:                 DSP_ALLOC_FUNC,
    realloc:               DSP_REALLOC_FUNC,
    free:                  DSP_FREE_FUNC,
    getsamplerate:         DSP_GETSAMPLERATE_FUNC,
    getblocksize:          DSP_GETBLOCKSIZE_FUNC,
    dft:                   ^DSP_STATE_DFT_FUNCTIONS,
    pan:                   ^DSP_STATE_PAN_FUNCTIONS,
    getspeakermode:        DSP_GETSPEAKERMODE_FUNC,
    getclock:              DSP_GETCLOCK_FUNC,
    getlistenerattributes: DSP_GETLISTENERATTRIBUTES_FUNC,
    log:                   DSP_LOG_FUNC,
    getuserdata:           DSP_GETUSERDATA_FUNC,
}

DSP_STATE :: struct {
    instance:           rawptr,
    plugindata:         rawptr,
    channelmask:        CHANNELMASK,
    source_speakermode: SPEAKERMODE,
    sidechaindata:      ^f32,
    sidechainchannels:  i32,
    functions:          [^]DSP_STATE_FUNCTIONS,
    systemobject:       i32,
}

DSP_METERING_INFO :: struct {
    numsamples:  i32,
    peaklevel:   [32]f32,
    rmslevel:    [32]f32,
    numchannels: i16,
}



///////////////////////////////////////////////////////////////////////////////////////////////////////
// DSP Macros
//

/*
#define DSP_INIT_PARAMDESC_FLOAT(_paramstruct, _name, _label, _description, _min, _max, _defaultval) \
    memset(&(_paramstruct), 0, sizeof(_paramstruct)), \
    (_paramstruct).type         = DSP_PARAMETER_TYPE_FLOAT, \
    strncpy((_paramstruct).name,  _name,  15), \
    strncpy((_paramstruct).label, _label, 15), \
    (_paramstruct).description  = _description, \
    (_paramstruct).floatdesc.min          = _min, \
    (_paramstruct).floatdesc.max          = _max, \
    (_paramstruct).floatdesc.defaultval   = _defaultval, \
    (_paramstruct).floatdesc.mapping.type = DSP_PARAMETER_FLOAT_MAPPING_TYPE_AUTO,

#define DSP_INIT_PARAMDESC_FLOAT_WITH_MAPPING(_paramstruct, _name, _label, _description, _defaultval, _values, _positions), \
    memset(&(_paramstruct), 0, sizeof(_paramstruct)), \
    (_paramstruct).type         = DSP_PARAMETER_TYPE_FLOAT, \
    strncpy((_paramstruct).name,  _name , 15), \
    strncpy((_paramstruct).label, _label, 15), \
    (_paramstruct).description  = _description, \
    (_paramstruct).floatdesc.min          = _values[0], \
    (_paramstruct).floatdesc.max          = _values[sizeof(_values) / sizeof(f32) - 1], \
    (_paramstruct).floatdesc.defaultval   = _defaultval, \
    (_paramstruct).floatdesc.mapping.type = DSP_PARAMETER_FLOAT_MAPPING_TYPE_PIECEWISE_LINEAR, \
    (_paramstruct).floatdesc.mapping.piecewiselinearmapping.numpoints = sizeof(_values) / sizeof(f32), \
    (_paramstruct).floatdesc.mapping.piecewiselinearmapping.pointparamvalues = _values, \
    (_paramstruct).floatdesc.mapping.piecewiselinearmapping.pointpositions = _positions,

#define DSP_INIT_PARAMDESC_INT(_paramstruct, _name, _label, _description, _min, _max, _defaultval, _goestoinf, _valuenames) \
    memset(&(_paramstruct), 0, sizeof(_paramstruct)), \
    (_paramstruct).type         = DSP_PARAMETER_TYPE_INT, \
    strncpy((_paramstruct).name,  _name , 15), \
    strncpy((_paramstruct).label, _label, 15), \
    (_paramstruct).description  = _description, \
    (_paramstruct).intdesc.min          = _min, \
    (_paramstruct).intdesc.max          = _max, \
    (_paramstruct).intdesc.defaultval   = _defaultval, \
    (_paramstruct).intdesc.goestoinf    = _goestoinf, \
    (_paramstruct).intdesc.valuenames   = _valuenames,

#define DSP_INIT_PARAMDESC_INT_ENUMERATED(_paramstruct, _name, _label, _description, _defaultval, _valuenames) \
    memset(&(_paramstruct), 0, sizeof(_paramstruct)), \
    (_paramstruct).type         = DSP_PARAMETER_TYPE_INT, \
    strncpy((_paramstruct).name,  _name , 15), \
    strncpy((_paramstruct).label, _label, 15), \
    (_paramstruct).description  = _description, \
    (_paramstruct).intdesc.min          = 0, \
    (_paramstruct).intdesc.max          = sizeof(_valuenames) / sizeof(u8*) - 1, \
    (_paramstruct).intdesc.defaultval   = _defaultval, \
    (_paramstruct).intdesc.goestoinf    = false, \
    (_paramstruct).intdesc.valuenames   = _valuenames,

#define DSP_INIT_PARAMDESC_BOOL(_paramstruct, _name, _label, _description, _defaultval, _valuenames) \
    memset(&(_paramstruct), 0, sizeof(_paramstruct)), \
    (_paramstruct).type         = DSP_PARAMETER_TYPE_BOOL, \
    strncpy((_paramstruct).name,  _name , 15), \
    strncpy((_paramstruct).label, _label, 15), \
    (_paramstruct).description  = _description, \
    (_paramstruct).booldesc.defaultval   = _defaultval, \
    (_paramstruct).booldesc.valuenames   = _valuenames,

#define DSP_INIT_PARAMDESC_DATA(_paramstruct, _name, _label, _description, _datatype) \
    memset(&(_paramstruct), 0, sizeof(_paramstruct)), \
    (_paramstruct).type         = DSP_PARAMETER_TYPE_DATA, \
    strncpy((_paramstruct).name,  _name , 15), \
    strncpy((_paramstruct).label, _label, 15), \
    (_paramstruct).description  = _description, \
    (_paramstruct).datadesc.datatype     = _datatype,

#define DSP_ALLOC(_state, _size) \
    (_state)->functions->alloc(_size, MEMORY_NORMAL, __FILE__)
#define DSP_REALLOC(_state, _ptr, _size) \
    (_state)->functions->realloc(_ptr, _size, MEMORY_NORMAL, __FILE__)
#define DSP_FREE(_state, _ptr) \
    (_state)->functions->free(_ptr, MEMORY_NORMAL, __FILE__)
#define DSP_LOG(_state, _level, _location, _format, #c_vararg args: ..any) \
    (_state)->functions->log(_level, __FILE__, __LINE__, _location, _format, __VA_ARGS__)
#define DSP_GETSAMPLERATE(_state, _rate) \
    (_state)->functions->getsamplerate(_state, _rate)
#define DSP_GETBLOCKSIZE(_state, _blocksize) \
    (_state)->functions->getblocksize(_state, _blocksize)
#define DSP_GETSPEAKERMODE(_state, _speakermodemix, _speakermodeout) \
    (_state)->functions->getspeakermode(_state, _speakermodemix, _speakermodeout)
#define DSP_GETCLOCK(_state, _clock, _offset, _length) \
    (_state)->functions->getclock(_state, _clock, _offset, _length)
#define DSP_GETLISTENERATTRIBUTES(_state, _numlisteners, _attributes) \
    (_state)->functions->getlistenerattributes(_state, _numlisteners, _attributes)
#define DSP_GETUSERDATA(_state, _userdata) \
    (_state)->functions->getuserdata(_state, _userdata)
#define DSP_DFT_FFTREAL(_state, _size, _signal, _dft, _window, _signalhop) \
    (_state)->functions->dft->fftreal(_state, _size, _signal, _dft, _window, _signalhop)
#define DSP_DFT_IFFTREAL(_state, _size, _dft, _signal, _window, _signalhop) \
    (_state)->functions->dft->inversefftreal(_state, _size, _dft, _signal, _window, _signalhop)
#define DSP_PAN_SUMMONOMATRIX(_state, _sourcespeakermode, _lowfrequencygain, _overallgain, _matrix) \
    (_state)->functions->pan->summonomatrix(_state, _sourcespeakermode, _lowfrequencygain, _overallgain, _matrix)
#define DSP_PAN_SUMSTEREOMATRIX(_state, _sourcespeakermode, _pan, _lowfrequencygain, _overallgain, _matrixhop, _matrix) \
    (_state)->functions->pan->sumstereomatrix(_state, _sourcespeakermode, _pan, _lowfrequencygain, _overallgain, _matrixhop, _matrix)
#define DSP_PAN_SUMSURROUNDMATRIX(_state, _sourcespeakermode, _targetspeakermode, _direction, _extent, _rotation, _lowfrequencygain, _overallgain, _matrixhop, _matrix, _flags) \
    (_state)->functions->pan->sumsurroundmatrix(_state, _sourcespeakermode, _targetspeakermode, _direction, _extent, _rotation, _lowfrequencygain, _overallgain, _matrixhop, _matrix, _flags)
#define DSP_PAN_SUMMONOTOSURROUNDMATRIX(_state, _targetspeakermode, _direction, _extent, _lowfrequencygain, _overallgain, _matrixhop, _matrix) \
    (_state)->functions->pan->summonotosurroundmatrix(_state, _targetspeakermode, _direction, _extent, _lowfrequencygain, _overallgain, _matrixhop, _matrix)
#define DSP_PAN_SUMSTEREOTOSURROUNDMATRIX(_state, _targetspeakermode, _direction, _extent, _rotation, _lowfrequencygain, _overallgain, matrixhop, _matrix) \
    (_state)->functions->pan->sumstereotosurroundmatrix(_state, _targetspeakermode, _direction, _extent, _rotation, _lowfrequencygain, _overallgain, matrixhop, _matrix)
#define DSP_PAN_GETROLLOFFGAIN(_state, _rolloff, _distance, _mindistance, _maxdistance, _gain) \
    (_state)->functions->pan->getrolloffgain(_state, _rolloff, _distance, _mindistance, _maxdistance, _gain)

#endif

*/
