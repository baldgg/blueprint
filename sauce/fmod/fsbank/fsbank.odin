package fmod_fsbank

///////////////////////////////////////////////////////////////////////////////////////////////////////
// FSBank types
//

INITFLAGS :: distinct u32

INIT_NORMAL :: 0x00000000
INIT_IGNOREERRORS :: 0x00000001
INIT_WARNINGSASERRORS :: 0x00000002
INIT_CREATEINCLUDEHEADER :: 0x00000004
INIT_DONTLOADCACHEFILES :: 0x00000008
INIT_GENERATEPROGRESSITEMS :: 0x00000010

BUILDFLAGS :: distinct u32
BUILD_DEFAULT :: 0x00000000
BUILD_DISABLESYNCPOINTS :: 0x00000001
BUILD_DONTLOOP :: 0x00000002
BUILD_FILTERHIGHFREQ :: 0x00000004
BUILD_DISABLESEEKING :: 0x00000008
BUILD_OPTIMIZESAMPLERATE :: 0x00000010
BUILD_FSB5_DONTWRITENAMES :: 0x00000080
BUILD_NOGUID :: 0x00000100
BUILD_WRITEPEAKVOLUME :: 0x00000200

BUILD_OVERRIDE_MASK ::
    (BUILD_DISABLESYNCPOINTS |
        BUILD_DONTLOOP |
        BUILD_FILTERHIGHFREQ |
        BUILD_DISABLESEEKING |
        BUILD_OPTIMIZESAMPLERATE |
        BUILD_WRITEPEAKVOLUME)
BUILD_CACHE_VALIDATION_MASK :: (BUILD_DONTLOOP | BUILD_FILTERHIGHFREQ | BUILD_OPTIMIZESAMPLERATE)

RESULT :: enum i32 {
    OK,
    ERR_CACHE_CHUNKNOTFOUND,
    ERR_CANCELLED,
    ERR_CANNOT_CONTINUE,
    ERR_ENCODER,
    ERR_ENCODER_INIT,
    ERR_ENCODER_NOTSUPPORTED,
    ERR_FILE_OS,
    ERR_FILE_NOTFOUND,
    ERR_FMOD,
    ERR_INITIALIZED,
    ERR_INVALID_FORMAT,
    ERR_INVALID_PARAM,
    ERR_MEMORY,
    ERR_UNINITIALIZED,
    ERR_WRITER_FORMAT,
    WARN_CANNOTLOOP,
    WARN_IGNORED_FILTERHIGHFREQ,
    WARN_IGNORED_DISABLESEEKING,
    WARN_FORCED_DONTWRITENAMES,
    ERR_ENCODER_FILE_NOTFOUND,
    ERR_ENCODER_FILE_BAD,
}

FORMAT :: enum i32 {
    FORMAT_PCM,
    FORMAT_XMA,
    FORMAT_AT9,
    FORMAT_VORBIS,
    FORMAT_FADPCM,
    FORMAT_OPUS,
}

FSBVERSION :: enum i32 {
    FSBVERSION_FSB5,
}

STATE :: enum i32 {
    STATE_DECODING,
    STATE_ANALYSING,
    STATE_PREPROCESSING,
    STATE_ENCODING,
    STATE_WRITING,
    STATE_FINISHED,
    STATE_FAILED,
    STATE_WARNING,
}

SUBSOUND :: struct {
    fileNames:            [^]cstring,
    fileData:             [^]rawptr,
    fileDataLengths:      [^]u32,
    numFiles:             u32,
    overrideFlags:        BUILDFLAGS,
    overrideQuality:      u32,
    desiredSampleRate:    f32,
    percentOptimizedRate: f32,
}

PROGRESSITEM :: struct {
    subSoundIndex: int,
    threadIndex:   int,
    state:         STATE,
    stateData:     rawptr,
}

STATEDATA_FAILED :: struct {
    errorCode:   RESULT,
    errorString: [256]u8,
}

STATEDATA_WARNING :: struct {
    warnCode:      RESULT,
    warningString: [256]u8,
}

MEMORY_ALLOC_CALLBACK :: #type proc(size: u32, type: u32, sourceStr: cstring) -> rawptr
MEMORY_REALLOC_CALLBACK :: #type proc(ptr: rawptr, size: u32, type: u32, sourceStr: cstring) -> rawptr
MEMORY_FREE_CALLBACK :: #type proc(ptr: rawptr, type: u32, sourceStr: cstring)

when ODIN_OS == .Windows {
	foreign import lib "lib/windows/x64/fsbank_vs.lib"
}

when ODIN_OS == .Darwin {
	when fmod.LOGGING_ENABLED {
		foreign import lib "lib/darwin/libfsbankL.dylib"
	} else {
		foreign import lib "lib/darwin/libfsbank.dylib"
	}
}

when ODIN_OS == .Linux {
	when fmod.LOGGING_ENABLED {
		foreign import lib "lib/linux/libfsbankL.so"
	} else {
		foreign import lib "lib/linux/libfsbank.so"
	}
}

@(default_calling_convention = "c", link_prefix = "FSBank_")
foreign lib {
    MemoryInit :: proc(userAlloc: MEMORY_ALLOC_CALLBACK, userRealloc: MEMORY_REALLOC_CALLBACK, userFree: MEMORY_FREE_CALLBACK) -> RESULT ---
    Init :: proc(version: FSBVERSION, flags: INITFLAGS, numSimultaneousJobs: u32, cacheDirectory: cstring) -> RESULT ---
    Release :: proc() -> RESULT ---
    Build :: proc(subSounds: [^]SUBSOUND, numSubSounds: u32, encodeFormat: FORMAT, buildFlags: BUILDFLAGS, quality: u32, encryptKey: cstring, outputFileName: cstring) -> RESULT ---
    FetchFSBMemory :: proc(data: ^rawptr, length: ^u32) -> RESULT ---
    BuildCancel :: proc() -> RESULT ---
    FetchNextProgressItem :: proc(progressItem: ^^PROGRESSITEM) -> RESULT ---
    ReleaseProgressItem :: proc(#by_ptr progressItem: PROGRESSITEM) -> RESULT ---
    MemoryGetStats :: proc(currentAllocated: ^u32, maximumAllocated: ^u32) -> RESULT ---
}
