package fmod_core

// ========================================================================================
// FMOD Core API - C header file.                                                          
// Copyright (c), Firelight Technologies Pty, Ltd. 2004-2023.                              
//                                                                                         
// Use this header in conjunction with fmod_common.h (which contains all the constants /   
// callbacks) to develop using the C interface                                             
//                                                                                         
// For more detail visit:                                                                  
// https://fmod.com/docs/2.02/api/core-api.html                                            
// ========================================================================================

LOGGING_ENABLED :: #config(FMOD_LOGGING_ENABLED, ODIN_DEBUG)

when ODIN_OS == .Windows {
    when LOGGING_ENABLED {
        foreign import lib "lib/windows/x64/fmodL_vc.lib"
    } else {
        foreign import lib "lib/windows/x64/fmod_vc.lib"
    }
}
when ODIN_OS == .Darwin {
    when LOGGING_ENABLED {
        foreign import lib "lib/darwin/libfmodL.dylib"
    } else {
        foreign import lib "lib/darwin/libfmod.dylib"
    }
}
when ODIN_OS == .Linux {
    when LOGGING_ENABLED {
        foreign import lib "lib/linux/libfmodL.so"
    } else {
        foreign import lib "lib/linux/libfmod.so"
    }
}

@(default_calling_convention = "c", link_prefix = "FMOD_")
foreign lib {
    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // FMOD global system functions (optional).
    //

    Memory_Initialize :: proc(poolmem: rawptr, poollen: i32, useralloc: MEMORY_ALLOC_CALLBACK, userrealloc: MEMORY_REALLOC_CALLBACK, userfree: MEMORY_FREE_CALLBACK, memtypeflags: MEMORY_TYPE) -> RESULT ---
    Memory_GetStats :: proc(currentalloced: ^i32, maxalloced: ^i32, blocking: b32) -> RESULT ---
    Debug_Initialize :: proc(flags: DEBUG_FLAGS, mode: DEBUG_MODE, callback: DEBUG_CALLBACK, filename: cstring) -> RESULT ---
    File_SetDiskBusy :: proc(busy: i32) -> RESULT ---
    File_GetDiskBusy :: proc(busy: ^i32) -> RESULT ---
    Thread_SetAttributes :: proc(_type: THREAD_TYPE, affinity: THREAD_AFFINITY, priority: THREAD_PRIORITY, stacksize: THREAD_STACK_SIZE) -> RESULT ---



    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // FMOD System factory functions.  Use this to create an FMOD System Instance.  below you will see System_Init/Close to get started.
    //
    System_Create :: proc(system: ^^SYSTEM, headerversion: u32) -> RESULT ---
    System_Release :: proc(system: ^SYSTEM) -> RESULT ---



    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // 'System' API
    //

    // Setup functions.
    System_SetOutput :: proc(system: ^SYSTEM, output: OUTPUTTYPE) -> RESULT ---
    System_GetOutput :: proc(system: ^SYSTEM, output: ^OUTPUTTYPE) -> RESULT ---
    System_GetNumDrivers :: proc(system: ^SYSTEM, numdrivers: ^i32) -> RESULT ---
    System_GetDriverInfo :: proc(system: ^SYSTEM, id: i32, name: ^u8, namelen: i32, guid: ^GUID, systemrate: ^i32, speakermode: ^SPEAKERMODE, speakermodechannels: ^i32) -> RESULT ---
    System_SetDriver :: proc(system: ^SYSTEM, driver: i32) -> RESULT ---
    System_GetDriver :: proc(system: ^SYSTEM, driver: ^i32) -> RESULT ---
    System_SetSoftwareChannels :: proc(system: ^SYSTEM, numsoftwarechannels: i32) -> RESULT ---
    System_GetSoftwareChannels :: proc(system: ^SYSTEM, numsoftwarechannels: ^i32) -> RESULT ---
    System_SetSoftwareFormat :: proc(system: ^SYSTEM, samplerate: i32, speakermode: SPEAKERMODE, numrawspeakers: i32) -> RESULT ---
    System_GetSoftwareFormat :: proc(system: ^SYSTEM, samplerate: ^i32, speakermode: ^SPEAKERMODE, numrawspeakers: ^i32) -> RESULT ---
    System_SetDSPBufferSize :: proc(system: ^SYSTEM, bufferlength: u32, numbuffers: i32) -> RESULT ---
    System_GetDSPBufferSize :: proc(system: ^SYSTEM, bufferlength: ^u32, numbuffers: ^i32) -> RESULT ---
    System_SetFileSystem :: proc(system: ^SYSTEM, useropen: FILE_OPEN_CALLBACK, userclose: FILE_CLOSE_CALLBACK, userread: FILE_READ_CALLBACK, userseek: FILE_SEEK_CALLBACK, userasyncread: FILE_ASYNCREAD_CALLBACK, userasynccancel: FILE_ASYNCCANCEL_CALLBACK, blockalign: i32) -> RESULT ---
    System_AttachFileSystem :: proc(system: ^SYSTEM, useropen: FILE_OPEN_CALLBACK, userclose: FILE_CLOSE_CALLBACK, userread: FILE_READ_CALLBACK, userseek: FILE_SEEK_CALLBACK) -> RESULT ---
    System_SetAdvancedSettings :: proc(system: ^SYSTEM, settings: ^ADVANCEDSETTINGS) -> RESULT ---
    System_GetAdvancedSettings :: proc(system: ^SYSTEM, settings: ^ADVANCEDSETTINGS) -> RESULT ---
    System_SetCallback :: proc(system: ^SYSTEM, callback: SYSTEM_CALLBACK, callbackmask: SYSTEM_CALLBACK_TYPE) -> RESULT ---

    // Plug-in support.
    System_SetPluginPath :: proc(system: ^SYSTEM, path: cstring) -> RESULT ---
    System_LoadPlugin :: proc(system: ^SYSTEM, filename: cstring, handle: ^u32, priority: u32) -> RESULT ---
    System_UnloadPlugin :: proc(system: ^SYSTEM, handle: u32) -> RESULT ---
    System_GetNumNestedPlugins :: proc(system: ^SYSTEM, handle: u32, count: ^i32) -> RESULT ---
    System_GetNestedPlugin :: proc(system: ^SYSTEM, handle: u32, index: i32, nestedhandle: ^u32) -> RESULT ---
    System_GetNumPlugins :: proc(system: ^SYSTEM, plugintype: PLUGINTYPE, numplugins: ^i32) -> RESULT ---
    System_GetPluginHandle :: proc(system: ^SYSTEM, plugintype: PLUGINTYPE, index: i32, handle: ^u32) -> RESULT ---
    System_GetPluginInfo :: proc(system: ^SYSTEM, handle: u32, plugintype: ^PLUGINTYPE, name: ^u8, namelen: i32, version: ^u32) -> RESULT ---
    System_SetOutputByPlugin :: proc(system: ^SYSTEM, handle: u32) -> RESULT ---
    System_GetOutputByPlugin :: proc(system: ^SYSTEM, handle: ^u32) -> RESULT ---
    System_CreateDSPByPlugin :: proc(system: ^SYSTEM, handle: u32, dsp: ^^DSP) -> RESULT ---
    System_GetDSPInfoByPlugin :: proc(system: ^SYSTEM, handle: u32, description: ^^DSP_DESCRIPTION) -> RESULT ---
    System_RegisterCodec :: proc(system: ^SYSTEM, description: ^CODEC_DESCRIPTION, handle: ^u32, priority: u32) -> RESULT ---
    System_RegisterDSP :: proc(system: ^SYSTEM, #by_ptr description: DSP_DESCRIPTION, handle: ^u32) -> RESULT ---
    System_RegisterOutput :: proc(system: ^SYSTEM, #by_ptr description: OUTPUT_DESCRIPTION, handle: ^u32) -> RESULT ---

    // Init/Close.
    System_Init :: proc(system: ^SYSTEM, maxchannels: i32, flags: INITFLAGS, extradriverdata: rawptr) -> RESULT ---
    System_Close :: proc(system: ^SYSTEM) -> RESULT ---

    // General post-init system functions.
    System_Update :: proc(system: ^SYSTEM) -> RESULT ---
    System_SetSpeakerPosition :: proc(system: ^SYSTEM, speaker: SPEAKER, x: f32, y: f32, active: b32) -> RESULT ---
    System_GetSpeakerPosition :: proc(system: ^SYSTEM, speaker: SPEAKER, x: ^f32, y: ^f32, active: ^b32) -> RESULT ---
    System_SetStreamBufferSize :: proc(system: ^SYSTEM, filebuffersize: u32, filebuffersizetype: TIMEUNIT) -> RESULT ---
    System_GetStreamBufferSize :: proc(system: ^SYSTEM, filebuffersize: ^u32, filebuffersizetype: ^TIMEUNIT) -> RESULT ---
    System_Set3DSettings :: proc(system: ^SYSTEM, dopplerscale: f32, distancefactor: f32, rolloffscale: f32) -> RESULT ---
    System_Get3DSettings :: proc(system: ^SYSTEM, dopplerscale: ^f32, distancefactor: ^f32, rolloffscale: ^f32) -> RESULT ---
    System_Set3DNumListeners :: proc(system: ^SYSTEM, numlisteners: i32) -> RESULT ---
    System_Get3DNumListeners :: proc(system: ^SYSTEM, numlisteners: ^i32) -> RESULT ---
    System_Set3DListenerAttributes :: proc(system: ^SYSTEM, listener: i32, #by_ptr pos: VECTOR, #by_ptr vel: VECTOR, #by_ptr forward: VECTOR, #by_ptr up: VECTOR) -> RESULT ---
    System_Get3DListenerAttributes :: proc(system: ^SYSTEM, listener: i32, pos: ^VECTOR, vel: ^VECTOR, forward: ^VECTOR, up: ^VECTOR) -> RESULT ---
    System_Set3DRolloffCallback :: proc(system: ^SYSTEM, callback: _3D_ROLLOFF_CALLBACK) -> RESULT ---
    System_MixerSuspend :: proc(system: ^SYSTEM) -> RESULT ---
    System_MixerResume :: proc(system: ^SYSTEM) -> RESULT ---
    System_GetDefaultMixMatrix :: proc(system: ^SYSTEM, sourcespeakermode: SPEAKERMODE, targetspeakermode: SPEAKERMODE, _matrix: ^f32, matrixhop: i32) -> RESULT ---
    System_GetSpeakerModeChannels :: proc(system: ^SYSTEM, mode: SPEAKERMODE, channels: ^i32) -> RESULT ---

    // System information functions.
    System_GetVersion :: proc(system: ^SYSTEM, version: ^u32) -> RESULT ---
    System_GetOutputHandle :: proc(system: ^SYSTEM, handle: ^rawptr) -> RESULT ---
    System_GetChannelsPlaying :: proc(system: ^SYSTEM, channels: ^i32, realchannels: ^i32) -> RESULT ---
    System_GetCPUUsage :: proc(system: ^SYSTEM, usage: ^CPU_USAGE) -> RESULT ---
    System_GetFileUsage :: proc(system: ^SYSTEM, sampleBytesRead: ^int, streamBytesRead: ^int, otherBytesRead: ^int) -> RESULT ---

    // Sound/DSP/Channel/FX creation and retrieval.
    System_CreateSound :: proc(system: ^SYSTEM, name_or_data: cstring, mode: MODE, exinfo: ^CREATESOUNDEXINFO, sound: ^^SOUND) -> RESULT ---
    System_CreateStream :: proc(system: ^SYSTEM, name_or_data: cstring, mode: MODE, exinfo: ^CREATESOUNDEXINFO, sound: ^^SOUND) -> RESULT ---
    System_CreateDSP :: proc(system: ^SYSTEM, #by_ptr description: DSP_DESCRIPTION, dsp: ^^DSP) -> RESULT ---
    System_CreateDSPByType :: proc(system: ^SYSTEM, _type: DSP_TYPE, dsp: ^^DSP) -> RESULT ---
    System_CreateChannelGroup :: proc(system: ^SYSTEM, name: cstring, channelgroup: ^^CHANNELGROUP) -> RESULT ---
    System_CreateSoundGroup :: proc(system: ^SYSTEM, name: cstring, soundgroup: ^^SOUNDGROUP) -> RESULT ---
    System_CreateReverb3D :: proc(system: ^SYSTEM, reverb: ^^REVERB3D) -> RESULT ---
    System_PlaySound :: proc(system: ^SYSTEM, sound: ^SOUND, channelgroup: ^CHANNELGROUP, paused: b32, channel: ^^CHANNEL) -> RESULT ---
    System_PlayDSP :: proc(system: ^SYSTEM, dsp: ^DSP, channelgroup: ^CHANNELGROUP, paused: b32, channel: ^^CHANNEL) -> RESULT ---
    System_GetChannel :: proc(system: ^SYSTEM, channelid: i32, channel: ^^CHANNEL) -> RESULT ---
    System_GetDSPInfoByType :: proc(system: ^SYSTEM, _type: DSP_TYPE, description: ^^DSP_DESCRIPTION) -> RESULT ---
    System_GetMasterChannelGroup :: proc(system: ^SYSTEM, channelgroup: ^^CHANNELGROUP) -> RESULT ---
    System_GetMasterSoundGroup :: proc(system: ^SYSTEM, soundgroup: ^^SOUNDGROUP) -> RESULT ---

    // Routing to ports.
    System_AttachChannelGroupToPort :: proc(system: ^SYSTEM, portType: PORT_TYPE, portIndex: PORT_INDEX, channelgroup: ^CHANNELGROUP, passThru: b32) -> RESULT ---
    System_DetachChannelGroupFromPort :: proc(system: ^SYSTEM, channelgroup: ^CHANNELGROUP) -> RESULT ---

    // Reverb API.
    System_SetReverbProperties :: proc(system: ^SYSTEM, instance: i32, #by_ptr prop: REVERB_PROPERTIES) -> RESULT ---
    System_GetReverbProperties :: proc(system: ^SYSTEM, instance: i32, prop: ^REVERB_PROPERTIES) -> RESULT ---

    // System level DSP functionality.
    System_LockDSP :: proc(system: ^SYSTEM) -> RESULT ---
    System_UnlockDSP :: proc(system: ^SYSTEM) -> RESULT ---

    // Recording API.
    System_GetRecordNumDrivers :: proc(system: ^SYSTEM, numdrivers: ^i32, numconnected: ^i32) -> RESULT ---
    System_GetRecordDriverInfo :: proc(system: ^SYSTEM, id: i32, name: ^u8, namelen: i32, guid: ^GUID, systemrate: ^i32, speakermode: ^SPEAKERMODE, speakermodechannels: ^i32, state: ^DRIVER_STATE) -> RESULT ---
    System_GetRecordPosition :: proc(system: ^SYSTEM, id: i32, position: ^u32) -> RESULT ---
    System_RecordStart :: proc(system: ^SYSTEM, id: i32, sound: ^SOUND, loop: b32) -> RESULT ---
    System_RecordStop :: proc(system: ^SYSTEM, id: i32) -> RESULT ---
    System_IsRecording :: proc(system: ^SYSTEM, id: i32, recording: ^b32) -> RESULT ---

    // Geometry API.
    System_CreateGeometry :: proc(system: ^SYSTEM, maxpolygons: i32, maxvertices: i32, geometry: ^^GEOMETRY) -> RESULT ---
    System_SetGeometrySettings :: proc(system: ^SYSTEM, maxworldsize: f32) -> RESULT ---
    System_GetGeometrySettings :: proc(system: ^SYSTEM, maxworldsize: ^f32) -> RESULT ---
    System_LoadGeometry :: proc(system: ^SYSTEM, data: rawptr, datasize: i32, geometry: ^^GEOMETRY) -> RESULT ---
    System_GetGeometryOcclusion :: proc(system: ^SYSTEM, #by_ptr listener: VECTOR, #by_ptr source: VECTOR, direct: ^f32, reverb: ^f32) -> RESULT ---

    // Network functions.
    System_SetNetworkProxy :: proc(system: ^SYSTEM, proxy: cstring) -> RESULT ---
    System_GetNetworkProxy :: proc(system: ^SYSTEM, proxy: ^u8, proxylen: i32) -> RESULT ---
    System_SetNetworkTimeout :: proc(system: ^SYSTEM, timeout: i32) -> RESULT ---
    System_GetNetworkTimeout :: proc(system: ^SYSTEM, timeout: ^i32) -> RESULT ---

    // Userdata set/get.
    System_SetUserData :: proc(system: ^SYSTEM, userdata: rawptr) -> RESULT ---
    System_GetUserData :: proc(system: ^SYSTEM, userdata: ^rawptr) -> RESULT ---

    // Sound API
    Sound_Release :: proc(sound: ^SOUND) -> RESULT ---
    Sound_GetSystemObject :: proc(sound: ^SOUND, system: ^^SYSTEM) -> RESULT ---



    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // Standard sound manipulation functions.
    //

    Sound_Lock :: proc(sound: ^SOUND, offset: u32, length: u32, ptr1: ^rawptr, ptr2: ^rawptr, len1: ^u32, len2: ^u32) -> RESULT ---
    Sound_Unlock :: proc(sound: ^SOUND, ptr1: rawptr, ptr2: rawptr, len1: u32, len2: u32) -> RESULT ---
    Sound_SetDefaults :: proc(sound: ^SOUND, frequency: f32, priority: i32) -> RESULT ---
    Sound_GetDefaults :: proc(sound: ^SOUND, frequency: ^f32, priority: ^i32) -> RESULT ---
    Sound_Set3DMinMaxDistance :: proc(sound: ^SOUND, min: f32, max: f32) -> RESULT ---
    Sound_Get3DMinMaxDistance :: proc(sound: ^SOUND, min: ^f32, max: ^f32) -> RESULT ---
    Sound_Set3DConeSettings :: proc(sound: ^SOUND, insideconeangle: f32, outsideconeangle: f32, outsidevolume: f32) -> RESULT ---
    Sound_Get3DConeSettings :: proc(sound: ^SOUND, insideconeangle: ^f32, outsideconeangle: ^f32, outsidevolume: ^f32) -> RESULT ---
    Sound_Set3DCustomRolloff :: proc(sound: ^SOUND, points: ^VECTOR, numpoints: i32) -> RESULT ---
    Sound_Get3DCustomRolloff :: proc(sound: ^SOUND, points: ^^VECTOR, numpoints: ^i32) -> RESULT ---
    Sound_GetSubSound :: proc(sound: ^SOUND, index: i32, subsound: ^^SOUND) -> RESULT ---
    Sound_GetSubSoundParent :: proc(sound: ^SOUND, parentsound: ^^SOUND) -> RESULT ---
    Sound_GetName :: proc(sound: ^SOUND, name: ^u8, namelen: i32) -> RESULT ---
    Sound_GetLength :: proc(sound: ^SOUND, length: ^u32, lengthtype: TIMEUNIT) -> RESULT ---
    Sound_GetFormat :: proc(sound: ^SOUND, _type: ^SOUND_TYPE, format: ^SOUND_FORMAT, channels: ^i32, bits: ^i32) -> RESULT ---
    Sound_GetNumSubSounds :: proc(sound: ^SOUND, numsubsounds: ^i32) -> RESULT ---
    Sound_GetNumTags :: proc(sound: ^SOUND, numtags: ^i32, numtagsupdated: ^i32) -> RESULT ---
    Sound_GetTag :: proc(sound: ^SOUND, name: cstring, index: i32, tag: ^TAG) -> RESULT ---
    Sound_GetOpenState :: proc(sound: ^SOUND, openstate: ^OPENSTATE, percentbuffered: ^u32, starving: ^b32, diskbusy: ^b32) -> RESULT ---
    Sound_ReadData :: proc(sound: ^SOUND, buffer: rawptr, length: u32, read: ^u32) -> RESULT ---
    Sound_SeekData :: proc(sound: ^SOUND, pcm: u32) -> RESULT ---

    Sound_SetSoundGroup :: proc(sound: ^SOUND, soundgroup: ^SOUNDGROUP) -> RESULT ---
    Sound_GetSoundGroup :: proc(sound: ^SOUND, soundgroup: ^^SOUNDGROUP) -> RESULT ---



    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // Synchronization poAPI: i32.  These points can come from markers embedded in wav files, and can also generate channel callbacks.
    //

    Sound_GetNumSyncPoints :: proc(sound: ^SOUND, numsyncpoints: ^i32) -> RESULT ---
    Sound_GetSyncPoint :: proc(sound: ^SOUND, index: i32, point: ^^SYNCPOINT) -> RESULT ---
    Sound_GetSyncPointInfo :: proc(sound: ^SOUND, point: ^SYNCPOINT, name: ^u8, namelen: i32, offset: ^u32, offsettype: TIMEUNIT) -> RESULT ---
    Sound_AddSyncPoint :: proc(sound: ^SOUND, offset: u32, offsettype: TIMEUNIT, name: cstring, point: ^^SYNCPOINT) -> RESULT ---
    Sound_DeleteSyncPoint :: proc(sound: ^SOUND, point: ^SYNCPOINT) -> RESULT ---



    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // Functions also in Channel class but here they are the 'default' to save having to change it in Channel all the time.
    //

    Sound_SetMode :: proc(sound: ^SOUND, mode: MODE) -> RESULT ---
    Sound_GetMode :: proc(sound: ^SOUND, mode: ^MODE) -> RESULT ---
    Sound_SetLoopCount :: proc(sound: ^SOUND, loopcount: i32) -> RESULT ---
    Sound_GetLoopCount :: proc(sound: ^SOUND, loopcount: ^i32) -> RESULT ---
    Sound_SetLoopPoints :: proc(sound: ^SOUND, loopstart: u32, loopstarttype: TIMEUNIT, loopend: u32, loopendtype: TIMEUNIT) -> RESULT ---
    Sound_GetLoopPoints :: proc(sound: ^SOUND, loopstart: ^u32, loopstarttype: TIMEUNIT, loopend: ^u32, loopendtype: TIMEUNIT) -> RESULT ---



    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // For MOD/S3M/XM/IT/MID sequenced formats only.
    //

    Sound_GetMusicNumChannels :: proc(sound: ^SOUND, numchannels: ^i32) -> RESULT ---
    Sound_SetMusicChannelVolume :: proc(sound: ^SOUND, channel: i32, volume: f32) -> RESULT ---
    Sound_GetMusicChannelVolume :: proc(sound: ^SOUND, channel: i32, volume: ^f32) -> RESULT ---
    Sound_SetMusicSpeed :: proc(sound: ^SOUND, speed: f32) -> RESULT ---
    Sound_GetMusicSpeed :: proc(sound: ^SOUND, speed: ^f32) -> RESULT ---



    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // Userdata set/get.
    //

    Sound_SetUserData :: proc(sound: ^SOUND, userdata: rawptr) -> RESULT ---
    Sound_GetUserData :: proc(sound: ^SOUND, userdata: ^rawptr) -> RESULT ---



    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // 'Channel' API
    //

    Channel_GetSystemObject :: proc(channel: ^CHANNEL, system: ^^SYSTEM) -> RESULT ---



    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // General control functionality for Channels and ChannelGroups.
    //

    Channel_Stop :: proc(channel: ^CHANNEL) -> RESULT ---
    Channel_SetPaused :: proc(channel: ^CHANNEL, paused: b32) -> RESULT ---
    Channel_GetPaused :: proc(channel: ^CHANNEL, paused: ^b32) -> RESULT ---
    Channel_SetVolume :: proc(channel: ^CHANNEL, volume: f32) -> RESULT ---
    Channel_GetVolume :: proc(channel: ^CHANNEL, volume: ^f32) -> RESULT ---
    Channel_SetVolumeRamp :: proc(channel: ^CHANNEL, ramp: b32) -> RESULT ---
    Channel_GetVolumeRamp :: proc(channel: ^CHANNEL, ramp: ^b32) -> RESULT ---
    Channel_GetAudibility :: proc(channel: ^CHANNEL, audibility: ^f32) -> RESULT ---
    Channel_SetPitch :: proc(channel: ^CHANNEL, pitch: f32) -> RESULT ---
    Channel_GetPitch :: proc(channel: ^CHANNEL, pitch: ^f32) -> RESULT ---
    Channel_SetMute :: proc(channel: ^CHANNEL, mute: b32) -> RESULT ---
    Channel_GetMute :: proc(channel: ^CHANNEL, mute: ^b32) -> RESULT ---
    Channel_SetReverbProperties :: proc(channel: ^CHANNEL, instance: i32, wet: f32) -> RESULT ---
    Channel_GetReverbProperties :: proc(channel: ^CHANNEL, instance: i32, wet: ^f32) -> RESULT ---
    Channel_SetLowPassGain :: proc(channel: ^CHANNEL, gain: f32) -> RESULT ---
    Channel_GetLowPassGain :: proc(channel: ^CHANNEL, gain: ^f32) -> RESULT ---
    Channel_SetMode :: proc(channel: ^CHANNEL, mode: MODE) -> RESULT ---
    Channel_GetMode :: proc(channel: ^CHANNEL, mode: ^MODE) -> RESULT ---
    Channel_SetCallback :: proc(channel: ^CHANNEL, callback: CHANNELCONTROL_CALLBACK) -> RESULT ---
    Channel_IsPlaying :: proc(channel: ^CHANNEL, isplaying: ^b32) -> RESULT ---



    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // Note all 'set' functions alter a final _matrix, this is why the only get function is getMixMatrix, to avoid other get functions returning incorrect/obsolete values.
    //

    Channel_SetPan :: proc(channel: ^CHANNEL, pan: f32) -> RESULT ---
    Channel_SetMixLevelsOutput :: proc(channel: ^CHANNEL, frontleft: f32, frontright: f32, center: f32, lfe: f32, surroundleft: f32, surroundright: f32, backleft: f32, backright: f32) -> RESULT ---
    Channel_SetMixLevelsInput :: proc(channel: ^CHANNEL, levels: ^f32, numlevels: i32) -> RESULT ---
    Channel_SetMixMatrix :: proc(channel: ^CHANNEL, _matrix: ^f32, outchannels: i32, inchannels: i32, inchannel_hop: i32) -> RESULT ---
    Channel_GetMixMatrix :: proc(channel: ^CHANNEL, _matrix: ^f32, outchannels: ^i32, inchannels: ^i32, inchannel_hop: i32) -> RESULT ---



    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // Clock based functionality.
    //

    Channel_GetDSPClock :: proc(channel: ^CHANNEL, dspclock: ^uint, parentclock: ^uint) -> RESULT ---
    Channel_SetDelay :: proc(channel: ^CHANNEL, dspclock_start: uint, dspclock_end: uint, stopchannels: b32) -> RESULT ---
    Channel_GetDelay :: proc(channel: ^CHANNEL, dspclock_start: ^uint, dspclock_end: ^uint, stopchannels: ^b32) -> RESULT ---
    Channel_AddFadePoint :: proc(channel: ^CHANNEL, dspclock: uint, volume: f32) -> RESULT ---
    Channel_SetFadePointRamp :: proc(channel: ^CHANNEL, dspclock: uint, volume: f32) -> RESULT ---
    Channel_RemoveFadePoints :: proc(channel: ^CHANNEL, dspclock_start: uint, dspclock_end: uint) -> RESULT ---
    Channel_GetFadePoints :: proc(channel: ^CHANNEL, numpoints: ^u32, point_dspclock: ^uint, point_volume: ^f32) -> RESULT ---



    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // DSP effects.
    //

    Channel_GetDSP :: proc(channel: ^CHANNEL, index: i32, dsp: ^^DSP) -> RESULT ---
    Channel_AddDSP :: proc(channel: ^CHANNEL, index: i32, dsp: ^DSP) -> RESULT ---
    Channel_RemoveDSP :: proc(channel: ^CHANNEL, dsp: ^DSP) -> RESULT ---
    Channel_GetNumDSPs :: proc(channel: ^CHANNEL, numdsps: ^i32) -> RESULT ---
    Channel_SetDSPIndex :: proc(channel: ^CHANNEL, dsp: ^DSP, index: i32) -> RESULT ---
    Channel_GetDSPIndex :: proc(channel: ^CHANNEL, dsp: ^DSP, index: ^i32) -> RESULT ---



    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // 3D functionality.
    //

    Channel_Set3DAttributes :: proc(channel: ^CHANNEL, #by_ptr pos: VECTOR, #by_ptr vel: VECTOR) -> RESULT ---
    Channel_Get3DAttributes :: proc(channel: ^CHANNEL, pos: ^VECTOR, vel: ^VECTOR) -> RESULT ---
    Channel_Set3DMinMaxDistance :: proc(channel: ^CHANNEL, mindistance: f32, maxdistance: f32) -> RESULT ---
    Channel_Get3DMinMaxDistance :: proc(channel: ^CHANNEL, mindistance: ^f32, maxdistance: ^f32) -> RESULT ---
    Channel_Set3DConeSettings :: proc(channel: ^CHANNEL, insideconeangle: f32, outsideconeangle: f32, outsidevolume: f32) -> RESULT ---
    Channel_Get3DConeSettings :: proc(channel: ^CHANNEL, insideconeangle: ^f32, outsideconeangle: ^f32, outsidevolume: ^f32) -> RESULT ---
    Channel_Set3DConeOrientation :: proc(channel: ^CHANNEL, orientation: ^VECTOR) -> RESULT ---
    Channel_Get3DConeOrientation :: proc(channel: ^CHANNEL, orientation: ^VECTOR) -> RESULT ---
    Channel_Set3DCustomRolloff :: proc(channel: ^CHANNEL, points: ^VECTOR, numpoints: i32) -> RESULT ---
    Channel_Get3DCustomRolloff :: proc(channel: ^CHANNEL, points: ^^VECTOR, numpoints: ^i32) -> RESULT ---
    Channel_Set3DOcclusion :: proc(channel: ^CHANNEL, directocclusion: f32, reverbocclusion: f32) -> RESULT ---
    Channel_Get3DOcclusion :: proc(channel: ^CHANNEL, directocclusion: ^f32, reverbocclusion: ^f32) -> RESULT ---
    Channel_Set3DSpread :: proc(channel: ^CHANNEL, angle: f32) -> RESULT ---
    Channel_Get3DSpread :: proc(channel: ^CHANNEL, angle: ^f32) -> RESULT ---
    Channel_Set3DLevel :: proc(channel: ^CHANNEL, level: f32) -> RESULT ---
    Channel_Get3DLevel :: proc(channel: ^CHANNEL, level: ^f32) -> RESULT ---
    Channel_Set3DDopplerLevel :: proc(channel: ^CHANNEL, level: f32) -> RESULT ---
    Channel_Get3DDopplerLevel :: proc(channel: ^CHANNEL, level: ^f32) -> RESULT ---
    Channel_Set3DDistanceFilter :: proc(channel: ^CHANNEL, custom: b32, customLevel: f32, centerFreq: f32) -> RESULT ---
    Channel_Get3DDistanceFilter :: proc(channel: ^CHANNEL, custom: ^b32, customLevel: ^f32, centerFreq: ^f32) -> RESULT ---



    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // Userdata set/get.
    //

    Channel_SetUserData :: proc(channel: ^CHANNEL, userdata: rawptr) -> RESULT ---
    Channel_GetUserData :: proc(channel: ^CHANNEL, userdata: ^rawptr) -> RESULT ---



    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // Channel specific control functionality.
    //

    Channel_SetFrequency :: proc(channel: ^CHANNEL, frequency: f32) -> RESULT ---
    Channel_GetFrequency :: proc(channel: ^CHANNEL, frequency: ^f32) -> RESULT ---
    Channel_SetPriority :: proc(channel: ^CHANNEL, priority: i32) -> RESULT ---
    Channel_GetPriority :: proc(channel: ^CHANNEL, priority: ^i32) -> RESULT ---
    Channel_SetPosition :: proc(channel: ^CHANNEL, position: u32, postype: TIMEUNIT) -> RESULT ---
    Channel_GetPosition :: proc(channel: ^CHANNEL, position: ^u32, postype: TIMEUNIT) -> RESULT ---
    Channel_SetChannelGroup :: proc(channel: ^CHANNEL, channelgroup: ^CHANNELGROUP) -> RESULT ---
    Channel_GetChannelGroup :: proc(channel: ^CHANNEL, channelgroup: ^^CHANNELGROUP) -> RESULT ---
    Channel_SetLoopCount :: proc(channel: ^CHANNEL, loopcount: i32) -> RESULT ---
    Channel_GetLoopCount :: proc(channel: ^CHANNEL, loopcount: ^i32) -> RESULT ---
    Channel_SetLoopPoints :: proc(channel: ^CHANNEL, loopstart: u32, loopstarttype: TIMEUNIT, loopend: u32, loopendtype: TIMEUNIT) -> RESULT ---
    Channel_GetLoopPoints :: proc(channel: ^CHANNEL, loopstart: ^u32, loopstarttype: TIMEUNIT, loopend: ^u32, loopendtype: TIMEUNIT) -> RESULT ---



    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // Information only functions.
    //

    Channel_IsVirtual :: proc(channel: ^CHANNEL, isvirtual: ^b32) -> RESULT ---
    Channel_GetCurrentSound :: proc(channel: ^CHANNEL, sound: ^^SOUND) -> RESULT ---
    Channel_GetIndex :: proc(channel: ^CHANNEL, index: ^i32) -> RESULT ---



    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // 'ChannelGroup' API
    //

    ChannelGroup_GetSystemObject :: proc(channelgroup: ^CHANNELGROUP, system: ^^SYSTEM) -> RESULT ---



    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // General control functionality for Channels and ChannelGroups.
    //

    ChannelGroup_Stop :: proc(channelgroup: ^CHANNELGROUP) -> RESULT ---
    ChannelGroup_SetPaused :: proc(channelgroup: ^CHANNELGROUP, paused: b32) -> RESULT ---
    ChannelGroup_GetPaused :: proc(channelgroup: ^CHANNELGROUP, paused: ^b32) -> RESULT ---
    ChannelGroup_SetVolume :: proc(channelgroup: ^CHANNELGROUP, volume: f32) -> RESULT ---
    ChannelGroup_GetVolume :: proc(channelgroup: ^CHANNELGROUP, volume: ^f32) -> RESULT ---
    ChannelGroup_SetVolumeRamp :: proc(channelgroup: ^CHANNELGROUP, ramp: b32) -> RESULT ---
    ChannelGroup_GetVolumeRamp :: proc(channelgroup: ^CHANNELGROUP, ramp: ^b32) -> RESULT ---
    ChannelGroup_GetAudibility :: proc(channelgroup: ^CHANNELGROUP, audibility: ^f32) -> RESULT ---
    ChannelGroup_SetPitch :: proc(channelgroup: ^CHANNELGROUP, pitch: f32) -> RESULT ---
    ChannelGroup_GetPitch :: proc(channelgroup: ^CHANNELGROUP, pitch: ^f32) -> RESULT ---
    ChannelGroup_SetMute :: proc(channelgroup: ^CHANNELGROUP, mute: b32) -> RESULT ---
    ChannelGroup_GetMute :: proc(channelgroup: ^CHANNELGROUP, mute: ^b32) -> RESULT ---
    ChannelGroup_SetReverbProperties :: proc(channelgroup: ^CHANNELGROUP, instance: i32, wet: f32) -> RESULT ---
    ChannelGroup_GetReverbProperties :: proc(channelgroup: ^CHANNELGROUP, instance: i32, wet: ^f32) -> RESULT ---
    ChannelGroup_SetLowPassGain :: proc(channelgroup: ^CHANNELGROUP, gain: f32) -> RESULT ---
    ChannelGroup_GetLowPassGain :: proc(channelgroup: ^CHANNELGROUP, gain: ^f32) -> RESULT ---
    ChannelGroup_SetMode :: proc(channelgroup: ^CHANNELGROUP, mode: MODE) -> RESULT ---
    ChannelGroup_GetMode :: proc(channelgroup: ^CHANNELGROUP, mode: ^MODE) -> RESULT ---
    ChannelGroup_SetCallback :: proc(channelgroup: ^CHANNELGROUP, callback: CHANNELCONTROL_CALLBACK) -> RESULT ---
    ChannelGroup_IsPlaying :: proc(channelgroup: ^CHANNELGROUP, isplaying: ^b32) -> RESULT ---



    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // Note all 'set' functions alter a final _matrix, this is why the only get function is getMixMatrix, to avoid other get functions returning incorrect/obsolete values.
    //

    ChannelGroup_SetPan :: proc(channelgroup: ^CHANNELGROUP, pan: f32) -> RESULT ---
    ChannelGroup_SetMixLevelsOutput :: proc(channelgroup: ^CHANNELGROUP, frontleft: f32, frontright: f32, center: f32, lfe: f32, surroundleft: f32, surroundright: f32, backleft: f32, backright: f32) -> RESULT ---
    ChannelGroup_SetMixLevelsInput :: proc(channelgroup: ^CHANNELGROUP, levels: ^f32, numlevels: i32) -> RESULT ---
    ChannelGroup_SetMixMatrix :: proc(channelgroup: ^CHANNELGROUP, _matrix: ^f32, outchannels: i32, inchannels: i32, inchannel_hop: i32) -> RESULT ---
    ChannelGroup_GetMixMatrix :: proc(channelgroup: ^CHANNELGROUP, _matrix: ^f32, outchannels: ^i32, inchannels: ^i32, inchannel_hop: i32) -> RESULT ---



    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // Clock based functionality.
    //

    ChannelGroup_GetDSPClock :: proc(channelgroup: ^CHANNELGROUP, dspclock: ^uint, parentclock: ^uint) -> RESULT ---
    ChannelGroup_SetDelay :: proc(channelgroup: ^CHANNELGROUP, dspclock_start: uint, dspclock_end: uint, stopchannels: b32) -> RESULT ---
    ChannelGroup_GetDelay :: proc(channelgroup: ^CHANNELGROUP, dspclock_start: ^uint, dspclock_end: ^uint, stopchannels: ^b32) -> RESULT ---
    ChannelGroup_AddFadePoint :: proc(channelgroup: ^CHANNELGROUP, dspclock: uint, volume: f32) -> RESULT ---
    ChannelGroup_SetFadePointRamp :: proc(channelgroup: ^CHANNELGROUP, dspclock: uint, volume: f32) -> RESULT ---
    ChannelGroup_RemoveFadePoints :: proc(channelgroup: ^CHANNELGROUP, dspclock_start: uint, dspclock_end: uint) -> RESULT ---
    ChannelGroup_GetFadePoints :: proc(channelgroup: ^CHANNELGROUP, numpoints: ^u32, point_dspclock: ^uint, point_volume: ^f32) -> RESULT ---



    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // DSP effects.
    //

    ChannelGroup_GetDSP :: proc(channelgroup: ^CHANNELGROUP, index: i32, dsp: ^^DSP) -> RESULT ---
    ChannelGroup_AddDSP :: proc(channelgroup: ^CHANNELGROUP, index: i32, dsp: ^DSP) -> RESULT ---
    ChannelGroup_RemoveDSP :: proc(channelgroup: ^CHANNELGROUP, dsp: ^DSP) -> RESULT ---
    ChannelGroup_GetNumDSPs :: proc(channelgroup: ^CHANNELGROUP, numdsps: ^i32) -> RESULT ---
    ChannelGroup_SetDSPIndex :: proc(channelgroup: ^CHANNELGROUP, dsp: ^DSP, index: i32) -> RESULT ---
    ChannelGroup_GetDSPIndex :: proc(channelgroup: ^CHANNELGROUP, dsp: ^DSP, index: ^i32) -> RESULT ---



    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // 3D functionality.
    //

    ChannelGroup_Set3DAttributes :: proc(channelgroup: ^CHANNELGROUP, #by_ptr pos: VECTOR, #by_ptr vel: VECTOR) -> RESULT ---
    ChannelGroup_Get3DAttributes :: proc(channelgroup: ^CHANNELGROUP, pos: ^VECTOR, vel: ^VECTOR) -> RESULT ---
    ChannelGroup_Set3DMinMaxDistance :: proc(channelgroup: ^CHANNELGROUP, mindistance: f32, maxdistance: f32) -> RESULT ---
    ChannelGroup_Get3DMinMaxDistance :: proc(channelgroup: ^CHANNELGROUP, mindistance: ^f32, maxdistance: ^f32) -> RESULT ---
    ChannelGroup_Set3DConeSettings :: proc(channelgroup: ^CHANNELGROUP, insideconeangle: f32, outsideconeangle: f32, outsidevolume: f32) -> RESULT ---
    ChannelGroup_Get3DConeSettings :: proc(channelgroup: ^CHANNELGROUP, insideconeangle: ^f32, outsideconeangle: ^f32, outsidevolume: ^f32) -> RESULT ---
    ChannelGroup_Set3DConeOrientation :: proc(channelgroup: ^CHANNELGROUP, orientation: ^VECTOR) -> RESULT ---
    ChannelGroup_Get3DConeOrientation :: proc(channelgroup: ^CHANNELGROUP, orientation: ^VECTOR) -> RESULT ---
    ChannelGroup_Set3DCustomRolloff :: proc(channelgroup: ^CHANNELGROUP, points: ^VECTOR, numpoints: i32) -> RESULT ---
    ChannelGroup_Get3DCustomRolloff :: proc(channelgroup: ^CHANNELGROUP, points: ^^VECTOR, numpoints: ^i32) -> RESULT ---
    ChannelGroup_Set3DOcclusion :: proc(channelgroup: ^CHANNELGROUP, directocclusion: f32, reverbocclusion: f32) -> RESULT ---
    ChannelGroup_Get3DOcclusion :: proc(channelgroup: ^CHANNELGROUP, directocclusion: ^f32, reverbocclusion: ^f32) -> RESULT ---
    ChannelGroup_Set3DSpread :: proc(channelgroup: ^CHANNELGROUP, angle: f32) -> RESULT ---
    ChannelGroup_Get3DSpread :: proc(channelgroup: ^CHANNELGROUP, angle: ^f32) -> RESULT ---
    ChannelGroup_Set3DLevel :: proc(channelgroup: ^CHANNELGROUP, level: f32) -> RESULT ---
    ChannelGroup_Get3DLevel :: proc(channelgroup: ^CHANNELGROUP, level: ^f32) -> RESULT ---
    ChannelGroup_Set3DDopplerLevel :: proc(channelgroup: ^CHANNELGROUP, level: f32) -> RESULT ---
    ChannelGroup_Get3DDopplerLevel :: proc(channelgroup: ^CHANNELGROUP, level: ^f32) -> RESULT ---
    ChannelGroup_Set3DDistanceFilter :: proc(channelgroup: ^CHANNELGROUP, custom: b32, customLevel: f32, centerFreq: f32) -> RESULT ---
    ChannelGroup_Get3DDistanceFilter :: proc(channelgroup: ^CHANNELGROUP, custom: ^b32, customLevel: ^f32, centerFreq: ^f32) -> RESULT ---



    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // Userdata set/get.
    //

    ChannelGroup_SetUserData :: proc(channelgroup: ^CHANNELGROUP, userdata: rawptr) -> RESULT ---
    ChannelGroup_GetUserData :: proc(channelgroup: ^CHANNELGROUP, userdata: ^rawptr) -> RESULT ---

    ChannelGroup_Release :: proc(channelgroup: ^CHANNELGROUP) -> RESULT ---



    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // Nested channel groups.
    //

    ChannelGroup_AddGroup :: proc(channelgroup: ^CHANNELGROUP, group: ^CHANNELGROUP, propagatedspclock: b32, connection: ^^DSPCONNECTION) -> RESULT ---
    ChannelGroup_GetNumGroups :: proc(channelgroup: ^CHANNELGROUP, numgroups: ^i32) -> RESULT ---
    ChannelGroup_GetGroup :: proc(channelgroup: ^CHANNELGROUP, index: i32, group: ^^CHANNELGROUP) -> RESULT ---
    ChannelGroup_GetParentGroup :: proc(channelgroup: ^CHANNELGROUP, group: ^^CHANNELGROUP) -> RESULT ---



    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // Information only functions.
    //

    ChannelGroup_GetName :: proc(channelgroup: ^CHANNELGROUP, name: ^u8, namelen: i32) -> RESULT ---
    ChannelGroup_GetNumChannels :: proc(channelgroup: ^CHANNELGROUP, numchannels: ^i32) -> RESULT ---
    ChannelGroup_GetChannel :: proc(channelgroup: ^CHANNELGROUP, index: i32, channel: ^^CHANNEL) -> RESULT ---



    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // 'SoundGroup' API
    //

    SoundGroup_Release :: proc(soundgroup: ^SOUNDGROUP) -> RESULT ---
    SoundGroup_GetSystemObject :: proc(soundgroup: ^SOUNDGROUP, system: ^^SYSTEM) -> RESULT ---



    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // SoundGroup control functions.
    //

    SoundGroup_SetMaxAudible :: proc(soundgroup: ^SOUNDGROUP, maxaudible: i32) -> RESULT ---
    SoundGroup_GetMaxAudible :: proc(soundgroup: ^SOUNDGROUP, maxaudible: ^i32) -> RESULT ---
    SoundGroup_SetMaxAudibleBehavior :: proc(soundgroup: ^SOUNDGROUP, behavior: SOUNDGROUP_BEHAVIOR) -> RESULT ---
    SoundGroup_GetMaxAudibleBehavior :: proc(soundgroup: ^SOUNDGROUP, behavior: ^SOUNDGROUP_BEHAVIOR) -> RESULT ---
    SoundGroup_SetMuteFadeSpeed :: proc(soundgroup: ^SOUNDGROUP, speed: f32) -> RESULT ---
    SoundGroup_GetMuteFadeSpeed :: proc(soundgroup: ^SOUNDGROUP, speed: ^f32) -> RESULT ---
    SoundGroup_SetVolume :: proc(soundgroup: ^SOUNDGROUP, volume: f32) -> RESULT ---
    SoundGroup_GetVolume :: proc(soundgroup: ^SOUNDGROUP, volume: ^f32) -> RESULT ---
    SoundGroup_Stop :: proc(soundgroup: ^SOUNDGROUP) -> RESULT ---



    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // Information only functions.
    //

    SoundGroup_GetName :: proc(soundgroup: ^SOUNDGROUP, name: ^u8, namelen: i32) -> RESULT ---
    SoundGroup_GetNumSounds :: proc(soundgroup: ^SOUNDGROUP, numsounds: ^i32) -> RESULT ---
    SoundGroup_GetSound :: proc(soundgroup: ^SOUNDGROUP, index: i32, sound: ^^SOUND) -> RESULT ---
    SoundGroup_GetNumPlaying :: proc(soundgroup: ^SOUNDGROUP, numplaying: ^i32) -> RESULT ---



    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // Userdata set/get.
    //

    SoundGroup_SetUserData :: proc(soundgroup: ^SOUNDGROUP, userdata: rawptr) -> RESULT ---
    SoundGroup_GetUserData :: proc(soundgroup: ^SOUNDGROUP, userdata: ^rawptr) -> RESULT ---



    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // 'DSP' API
    //

    DSP_Release :: proc(dsp: ^DSP) -> RESULT ---
    DSP_GetSystemObject :: proc(dsp: ^DSP, system: ^^SYSTEM) -> RESULT ---



    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // Connection / disconnection / input and output enumeration.
    //

    DSP_AddInput :: proc(dsp: ^DSP, input: ^DSP, connection: ^^DSPCONNECTION, _type: DSPCONNECTION_TYPE) -> RESULT ---
    DSP_DisconnectFrom :: proc(dsp: ^DSP, target: ^DSP, connection: ^DSPCONNECTION) -> RESULT ---
    DSP_DisconnectAll :: proc(dsp: ^DSP, inputs: b32, outputs: b32) -> RESULT ---
    DSP_GetNumInputs :: proc(dsp: ^DSP, numinputs: ^i32) -> RESULT ---
    DSP_GetNumOutputs :: proc(dsp: ^DSP, numoutputs: ^i32) -> RESULT ---
    DSP_GetInput :: proc(dsp: ^DSP, index: i32, input: ^^DSP, inputconnection: ^^DSPCONNECTION) -> RESULT ---
    DSP_GetOutput :: proc(dsp: ^DSP, index: i32, output: ^^DSP, outputconnection: ^^DSPCONNECTION) -> RESULT ---



    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // DSP unit control.
    //

    DSP_SetActive :: proc(dsp: ^DSP, active: b32) -> RESULT ---
    DSP_GetActive :: proc(dsp: ^DSP, active: ^b32) -> RESULT ---
    DSP_SetBypass :: proc(dsp: ^DSP, bypass: b32) -> RESULT ---
    DSP_GetBypass :: proc(dsp: ^DSP, bypass: ^b32) -> RESULT ---
    DSP_SetWetDryMix :: proc(dsp: ^DSP, prewet: f32, postwet: f32, dry: f32) -> RESULT ---
    DSP_GetWetDryMix :: proc(dsp: ^DSP, prewet: ^f32, postwet: ^f32, dry: ^f32) -> RESULT ---
    DSP_SetChannelFormat :: proc(dsp: ^DSP, channelmask: CHANNELMASK, numchannels: i32, source_speakermode: SPEAKERMODE) -> RESULT ---
    DSP_GetChannelFormat :: proc(dsp: ^DSP, channelmask: ^CHANNELMASK, numchannels: ^i32, source_speakermode: ^SPEAKERMODE) -> RESULT ---
    DSP_GetOutputChannelFormat :: proc(dsp: ^DSP, inmask: CHANNELMASK, inchannels: i32, inspeakermode: SPEAKERMODE, outmask: ^CHANNELMASK, outchannels: ^i32, outspeakermode: ^SPEAKERMODE) -> RESULT ---
    DSP_Reset :: proc(dsp: ^DSP) -> RESULT ---
    DSP_SetCallback :: proc(dsp: ^DSP, callback: DSP_CALLBACK) -> RESULT ---



    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // DSP parameter control.
    //

    DSP_SetParameterf32 :: proc(dsp: ^DSP, index: i32, value: f32) -> RESULT ---
    DSP_SetParameterInt :: proc(dsp: ^DSP, index: i32, value: i32) -> RESULT ---
    DSP_SetParameterb32 :: proc(dsp: ^DSP, index: i32, value: b32) -> RESULT ---
    DSP_SetParameterData :: proc(dsp: ^DSP, index: i32, data: rawptr, length: u32) -> RESULT ---
    DSP_GetParameterf32 :: proc(dsp: ^DSP, index: i32, value: ^f32, valuestr: ^u8, valuestrlen: i32) -> RESULT ---
    DSP_GetParameterInt :: proc(dsp: ^DSP, index: i32, value: ^i32, valuestr: ^u8, valuestrlen: i32) -> RESULT ---
    DSP_GetParameterb32 :: proc(dsp: ^DSP, index: i32, value: ^b32, valuestr: ^u8, valuestrlen: i32) -> RESULT ---
    DSP_GetParameterData :: proc(dsp: ^DSP, index: i32, data: ^rawptr, length: ^u32, valuestr: ^u8, valuestrlen: i32) -> RESULT ---
    DSP_GetNumParameters :: proc(dsp: ^DSP, numparams: ^i32) -> RESULT ---
    DSP_GetParameterInfo :: proc(dsp: ^DSP, index: i32, desc: ^^DSP_PARAMETER_DESC) -> RESULT ---
    DSP_GetDataParameterIndex :: proc(dsp: ^DSP, datatype: i32, index: ^i32) -> RESULT ---
    DSP_ShowConfigDialog :: proc(dsp: ^DSP, hwnd: rawptr, show: b32) -> RESULT ---



    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // DSP attributes.
    //

    DSP_GetInfo :: proc(dsp: ^DSP, name: ^u8, version: ^u32, channels: ^i32, configwidth: ^i32, configheight: ^i32) -> RESULT ---
    DSP_GetType :: proc(dsp: ^DSP, _type: ^DSP_TYPE) -> RESULT ---
    DSP_GetIdle :: proc(dsp: ^DSP, idle: ^b32) -> RESULT ---



    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // Userdata set/get.
    //

    DSP_SetUserData :: proc(dsp: ^DSP, userdata: rawptr) -> RESULT ---
    DSP_GetUserData :: proc(dsp: ^DSP, userdata: ^rawptr) -> RESULT ---



    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // Metering.
    //

    DSP_SetMeteringEnabled :: proc(dsp: ^DSP, inputEnabled: b32, outputEnabled: b32) -> RESULT ---
    DSP_GetMeteringEnabled :: proc(dsp: ^DSP, inputEnabled: ^b32, outputEnabled: ^b32) -> RESULT ---
    DSP_GetMeteringInfo :: proc(dsp: ^DSP, inputInfo: ^DSP_METERING_INFO, outputInfo: ^DSP_METERING_INFO) -> RESULT ---
    DSP_GetCPUUsage :: proc(dsp: ^DSP, exclusive: ^u32, inclusive: ^u32) -> RESULT ---



    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // 'DSPConnection' API
    //

    DSPConnection_GetInput :: proc(dspconnection: ^DSPCONNECTION, input: ^^DSP) -> RESULT ---
    DSPConnection_GetOutput :: proc(dspconnection: ^DSPCONNECTION, output: ^^DSP) -> RESULT ---
    DSPConnection_SetMix :: proc(dspconnection: ^DSPCONNECTION, volume: f32) -> RESULT ---
    DSPConnection_GetMix :: proc(dspconnection: ^DSPCONNECTION, volume: ^f32) -> RESULT ---
    DSPConnection_SetMixMatrix :: proc(dspconnection: ^DSPCONNECTION, _matrix: ^f32, outchannels: i32, inchannels: i32, inchannel_hop: i32) -> RESULT ---
    DSPConnection_GetMixMatrix :: proc(dspconnection: ^DSPCONNECTION, _matrix: ^f32, outchannels: ^i32, inchannels: ^i32, inchannel_hop: i32) -> RESULT ---
    DSPConnection_GetType :: proc(dspconnection: ^DSPCONNECTION, _type: ^DSPCONNECTION_TYPE) -> RESULT ---



    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // Userdata set/get.
    //

    DSPConnection_SetUserData :: proc(dspconnection: ^DSPCONNECTION, userdata: rawptr) -> RESULT ---
    DSPConnection_GetUserData :: proc(dspconnection: ^DSPCONNECTION, userdata: ^rawptr) -> RESULT ---



    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // 'Geometry' API
    //

    Geometry_Release :: proc(geometry: ^GEOMETRY) -> RESULT ---



    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // Polygon manipulation.
    //

    Geometry_AddPolygon :: proc(geometry: ^GEOMETRY, directocclusion: f32, reverbocclusion: f32, doublesided: b32, numvertices: i32, #by_ptr vertices: VECTOR, polygonindex: ^i32) -> RESULT ---
    Geometry_GetNumPolygons :: proc(geometry: ^GEOMETRY, numpolygons: ^i32) -> RESULT ---
    Geometry_GetMaxPolygons :: proc(geometry: ^GEOMETRY, maxpolygons: ^i32, maxvertices: ^i32) -> RESULT ---
    Geometry_GetPolygonNumVertices :: proc(geometry: ^GEOMETRY, index: i32, numvertices: ^i32) -> RESULT ---
    Geometry_SetPolygonVertex :: proc(geometry: ^GEOMETRY, index: i32, vertexindex: i32, #by_ptr vertex: VECTOR) -> RESULT ---
    Geometry_GetPolygonVertex :: proc(geometry: ^GEOMETRY, index: i32, vertexindex: i32, vertex: ^VECTOR) -> RESULT ---
    Geometry_SetPolygonAttributes :: proc(geometry: ^GEOMETRY, index: i32, directocclusion: f32, reverbocclusion: f32, doublesided: b32) -> RESULT ---
    Geometry_GetPolygonAttributes :: proc(geometry: ^GEOMETRY, index: i32, directocclusion: ^f32, reverbocclusion: ^f32, doublesided: ^b32) -> RESULT ---



    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // Object manipulation.
    //

    Geometry_SetActive :: proc(geometry: ^GEOMETRY, active: b32) -> RESULT ---
    Geometry_GetActive :: proc(geometry: ^GEOMETRY, active: ^b32) -> RESULT ---
    Geometry_SetRotation :: proc(geometry: ^GEOMETRY, #by_ptr forward: VECTOR, #by_ptr up: VECTOR) -> RESULT ---
    Geometry_GetRotation :: proc(geometry: ^GEOMETRY, forward: ^VECTOR, up: ^VECTOR) -> RESULT ---
    Geometry_SetPosition :: proc(geometry: ^GEOMETRY, #by_ptr position: VECTOR) -> RESULT ---
    Geometry_GetPosition :: proc(geometry: ^GEOMETRY, position: ^VECTOR) -> RESULT ---
    Geometry_SetScale :: proc(geometry: ^GEOMETRY, #by_ptr scale: VECTOR) -> RESULT ---
    Geometry_GetScale :: proc(geometry: ^GEOMETRY, scale: ^VECTOR) -> RESULT ---
    Geometry_Save :: proc(geometry: ^GEOMETRY, data: rawptr, datasize: ^i32) -> RESULT ---



    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // Userdata set/get.
    //

    Geometry_SetUserData :: proc(geometry: ^GEOMETRY, userdata: rawptr) -> RESULT ---
    Geometry_GetUserData :: proc(geometry: ^GEOMETRY, userdata: ^rawptr) -> RESULT ---



    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // 'Reverb3D' API
    //

    Reverb3D_Release :: proc(reverb3d: ^REVERB3D) -> RESULT ---



    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // Reverb manipulation.
    //

    Reverb3D_Set3DAttributes :: proc(reverb3d: ^REVERB3D, #by_ptr position: VECTOR, mindistance: f32, maxdistance: f32) -> RESULT ---
    Reverb3D_Get3DAttributes :: proc(reverb3d: ^REVERB3D, position: ^VECTOR, mindistance: ^f32, maxdistance: ^f32) -> RESULT ---
    Reverb3D_SetProperties :: proc(reverb3d: ^REVERB3D, #by_ptr properties: REVERB_PROPERTIES) -> RESULT ---
    Reverb3D_GetProperties :: proc(reverb3d: ^REVERB3D, properties: ^REVERB_PROPERTIES) -> RESULT ---
    Reverb3D_SetActive :: proc(reverb3d: ^REVERB3D, active: b32) -> RESULT ---
    Reverb3D_GetActive :: proc(reverb3d: ^REVERB3D, active: ^b32) -> RESULT ---



    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // Userdata set/get.
    //

    Reverb3D_SetUserData :: proc(reverb3d: ^REVERB3D, userdata: rawptr) -> RESULT ---
    Reverb3D_GetUserData :: proc(reverb3d: ^REVERB3D, userdata: ^rawptr) -> RESULT ---

}
