package fmod_studio

/* ======================================================================================== */
/* FMOD Studio API - C header file.                                                         */
/* Copyright (c), Firelight Technologies Pty, Ltd. 2004-2023.                               */
/*                                                                                          */
/* Use this header in conjunction with fmod_studio_common.h (which contains all the         */
/* constants / callbacks) to develop using the C language.                                  */
/*                                                                                          */
/* For more detail visit:                                                                   */
/* https://fmod.com/docs/2.02/api/studio-api.html                                           */
/* ======================================================================================== */

import fmod "../core"

when ODIN_OS == .Windows {
    when fmod.LOGGING_ENABLED {
        foreign import lib "lib/windows/x64/fmodstudioL_vc.lib"
    } else {
        foreign import lib "lib/windows/x64/fmodstudio_vc.lib"
    }
}

when ODIN_OS == .Darwin {
    when fmod.LOGGING_ENABLED {
        foreign import lib "lib/darwin/libfmodstudioL.dylib"
    } else {
        foreign import lib "lib/darwin/libfmodstudio.dylib"
    }
}

when ODIN_OS == .Linux {
    when fmod.LOGGING_ENABLED {
        foreign import lib "lib/linux/libfmodstudioL.so"
    } else {
        foreign import lib "lib/linux/libfmodstudio.so"
    }
}

@(default_calling_convention = "c", link_prefix = "FMOD_Studio_")
foreign lib {

    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // Global
    //

    ParseID :: proc(idstring: cstring, id: ^fmod.GUID) -> fmod.RESULT ---
    System_Create :: proc(system: ^^SYSTEM, headerversion: u32) -> fmod.RESULT ---



    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // System
    //

    System_IsValid :: proc(system: ^SYSTEM) -> b32 ---
    System_SetAdvancedSettings :: proc(system: ^SYSTEM, settings: ^ADVANCEDSETTINGS) -> fmod.RESULT ---
    System_GetAdvancedSettings :: proc(system: ^SYSTEM, settings: ^ADVANCEDSETTINGS) -> fmod.RESULT ---
    System_Initialize :: proc(system: ^SYSTEM, maxchannels: i32, studioflags: INITFLAGS, flags: fmod.INITFLAGS, extradriverdata: rawptr) -> fmod.RESULT ---
    System_Release :: proc(system: ^SYSTEM) -> fmod.RESULT ---
    System_Update :: proc(system: ^SYSTEM) -> fmod.RESULT ---
    System_GetCoreSystem :: proc(system: ^SYSTEM, coresystem: ^^fmod.SYSTEM) -> fmod.RESULT ---
    System_GetEvent :: proc(system: ^SYSTEM, pathOrID: cstring, event: ^^EVENTDESCRIPTION) -> fmod.RESULT ---
    System_GetBus :: proc(system: ^SYSTEM, pathOrID: cstring, bus: ^^BUS) -> fmod.RESULT ---
    System_GetVCA :: proc(system: ^SYSTEM, pathOrID: cstring, vca: ^^VCA) -> fmod.RESULT ---
    System_GetBank :: proc(system: ^SYSTEM, pathOrID: cstring, bank: ^^BANK) -> fmod.RESULT ---
    System_GetEventByID :: proc(system: ^SYSTEM, #by_ptr id: fmod.GUID, event: ^^EVENTDESCRIPTION) -> fmod.RESULT ---
    System_GetBusByID :: proc(system: ^SYSTEM, #by_ptr id: fmod.GUID, bus: ^^BUS) -> fmod.RESULT ---
    System_GetVCAByID :: proc(system: ^SYSTEM, #by_ptr id: fmod.GUID, vca: ^^VCA) -> fmod.RESULT ---
    System_GetBankByID :: proc(system: ^SYSTEM, #by_ptr id: fmod.GUID, bank: ^^BANK) -> fmod.RESULT ---
    System_GetSoundInfo :: proc(system: ^SYSTEM, key: cstring, info: ^SOUND_INFO) -> fmod.RESULT ---
    System_GetParameterDescriptionByName :: proc(system: ^SYSTEM, name: cstring, parameter: ^PARAMETER_DESCRIPTION) -> fmod.RESULT ---
    System_GetParameterDescriptionByID :: proc(system: ^SYSTEM, id: PARAMETER_ID, parameter: ^PARAMETER_DESCRIPTION) -> fmod.RESULT ---
    System_GetParameterLabelByName :: proc(system: ^SYSTEM, name: cstring, labelindex: i32, label: ^u8, size: i32, retrieved: ^i32) -> fmod.RESULT ---
    System_GetParameterLabelByID :: proc(system: ^SYSTEM, id: PARAMETER_ID, labelindex: i32, label: ^u8, size: i32, retrieved: ^i32) -> fmod.RESULT ---
    System_GetParameterByID :: proc(system: ^SYSTEM, id: PARAMETER_ID, value: ^f32, finalvalue: ^f32) -> fmod.RESULT ---
    System_SetParameterByID :: proc(system: ^SYSTEM, id: PARAMETER_ID, value: f32, ignoreseekspeed: b32) -> fmod.RESULT ---
    System_SetParameterByIDWithLabel :: proc(system: ^SYSTEM, id: PARAMETER_ID, label: cstring, ignoreseekspeed: b32) -> fmod.RESULT ---
    System_SetParametersByIDs :: proc(system: ^SYSTEM, #by_ptr ids: PARAMETER_ID, values: ^f32, count: i32, ignoreseekspeed: b32) -> fmod.RESULT ---
    System_GetParameterByName :: proc(system: ^SYSTEM, name: cstring, value: ^f32, finalvalue: ^f32) -> fmod.RESULT ---
    System_SetParameterByName :: proc(system: ^SYSTEM, name: cstring, value: f32, ignoreseekspeed: b32) -> fmod.RESULT ---
    System_SetParameterByNameWithLabel :: proc(system: ^SYSTEM, name: cstring, label: cstring, ignoreseekspeed: b32) -> fmod.RESULT ---
    System_LookupID :: proc(system: ^SYSTEM, path: cstring, id: ^fmod.GUID) -> fmod.RESULT ---
    System_LookupPath :: proc(system: ^SYSTEM, #by_ptr id: fmod.GUID, path: ^u8, size: i32, retrieved: ^i32) -> fmod.RESULT ---
    System_GetNumListeners :: proc(system: ^SYSTEM, numlisteners: ^i32) -> fmod.RESULT ---
    System_SetNumListeners :: proc(system: ^SYSTEM, numlisteners: i32) -> fmod.RESULT ---
    System_GetListenerAttributes :: proc(system: ^SYSTEM, index: i32, attributes: ^fmod._3D_ATTRIBUTES, attenuationposition: ^fmod.VECTOR) -> fmod.RESULT ---
    System_SetListenerAttributes :: proc(system: ^SYSTEM, index: i32, #by_ptr attributes: fmod._3D_ATTRIBUTES, attenuationposition: ^fmod.VECTOR) -> fmod.RESULT ---
    System_GetListenerWeight :: proc(system: ^SYSTEM, index: i32, weight: ^f32) -> fmod.RESULT ---
    System_SetListenerWeight :: proc(system: ^SYSTEM, index: i32, weight: f32) -> fmod.RESULT ---
    System_LoadBankFile :: proc(system: ^SYSTEM, filename: cstring, flags: LOAD_BANK_FLAGS, bank: ^^BANK) -> fmod.RESULT ---
    System_LoadBankMemory :: proc(system: ^SYSTEM, buffer: cstring, length: i32, mode: LOAD_MEMORY_MODE, flags: LOAD_BANK_FLAGS, bank: ^^BANK) -> fmod.RESULT ---
    System_LoadBankCustom :: proc(system: ^SYSTEM, #by_ptr info: BANK_INFO, flags: LOAD_BANK_FLAGS, bank: ^^BANK) -> fmod.RESULT ---
    System_RegisterPlugin :: proc(system: ^SYSTEM, #by_ptr description: fmod.DSP_DESCRIPTION) -> fmod.RESULT ---
    System_UnregisterPlugin :: proc(system: ^SYSTEM, name: cstring) -> fmod.RESULT ---
    System_UnloadAll :: proc(system: ^SYSTEM) -> fmod.RESULT ---
    System_FlushCommands :: proc(system: ^SYSTEM) -> fmod.RESULT ---
    System_FlushSampleLoading :: proc(system: ^SYSTEM) -> fmod.RESULT ---
    System_StartCommandCapture :: proc(system: ^SYSTEM, filename: cstring, flags: COMMANDCAPTURE_FLAGS) -> fmod.RESULT ---
    System_StopCommandCapture :: proc(system: ^SYSTEM) -> fmod.RESULT ---
    System_LoadCommandReplay :: proc(system: ^SYSTEM, filename: cstring, flags: COMMANDREPLAY_FLAGS, replay: ^^COMMANDREPLAY) -> fmod.RESULT ---
    System_GetBankCount :: proc(system: ^SYSTEM, count: ^i32) -> fmod.RESULT ---
    System_GetBankList :: proc(system: ^SYSTEM, array: ^^BANK, capacity: i32, count: ^i32) -> fmod.RESULT ---
    System_GetParameterDescriptionCount :: proc(system: ^SYSTEM, count: ^i32) -> fmod.RESULT ---
    System_GetParameterDescriptionList :: proc(system: ^SYSTEM, array: ^PARAMETER_DESCRIPTION, capacity: i32, count: ^i32) -> fmod.RESULT ---
    System_GetCPUUsage :: proc(system: ^SYSTEM, usage: ^CPU_USAGE, usage_core: ^fmod.CPU_USAGE) -> fmod.RESULT ---
    System_GetBufferUsage :: proc(system: ^SYSTEM, usage: ^BUFFER_USAGE) -> fmod.RESULT ---
    System_ResetBufferUsage :: proc(system: ^SYSTEM) -> fmod.RESULT ---
    System_SetCallback :: proc(system: ^SYSTEM, callback: SYSTEM_CALLBACK, callbackmask: SYSTEM_CALLBACK_TYPE) -> fmod.RESULT ---
    System_SetUserData :: proc(system: ^SYSTEM, userdata: rawptr) -> fmod.RESULT ---
    System_GetUserData :: proc(system: ^SYSTEM, userdata: ^rawptr) -> fmod.RESULT ---
    System_GetMemoryUsage :: proc(system: ^SYSTEM, memoryusage: ^MEMORY_USAGE) -> fmod.RESULT ---



    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // EventDescription
    //

    EventDescription_IsValid :: proc(eventdescription: ^EVENTDESCRIPTION) -> b32 ---
    EventDescription_GetID :: proc(eventdescription: ^EVENTDESCRIPTION, id: ^fmod.GUID) -> fmod.RESULT ---
    EventDescription_GetPath :: proc(eventdescription: ^EVENTDESCRIPTION, path: ^u8, size: i32, retrieved: ^i32) -> fmod.RESULT ---
    EventDescription_GetParameterDescriptionCount :: proc(eventdescription: ^EVENTDESCRIPTION, count: ^i32) -> fmod.RESULT ---
    EventDescription_GetParameterDescriptionByIndex :: proc(eventdescription: ^EVENTDESCRIPTION, index: i32, parameter: ^PARAMETER_DESCRIPTION) -> fmod.RESULT ---
    EventDescription_GetParameterDescriptionByName :: proc(eventdescription: ^EVENTDESCRIPTION, name: cstring, parameter: ^PARAMETER_DESCRIPTION) -> fmod.RESULT ---
    EventDescription_GetParameterDescriptionByID :: proc(eventdescription: ^EVENTDESCRIPTION, id: PARAMETER_ID, parameter: ^PARAMETER_DESCRIPTION) -> fmod.RESULT ---
    EventDescription_GetParameterLabelByIndex :: proc(eventdescription: ^EVENTDESCRIPTION, index: i32, labelindex: i32, label: ^u8, size: i32, retrieved: ^i32) -> fmod.RESULT ---
    EventDescription_GetParameterLabelByName :: proc(eventdescription: ^EVENTDESCRIPTION, name: cstring, labelindex: i32, label: ^u8, size: i32, retrieved: ^i32) -> fmod.RESULT ---
    EventDescription_GetParameterLabelByID :: proc(eventdescription: ^EVENTDESCRIPTION, id: PARAMETER_ID, labelindex: i32, label: ^u8, size: i32, retrieved: ^i32) -> fmod.RESULT ---
    EventDescription_GetUserPropertyCount :: proc(eventdescription: ^EVENTDESCRIPTION, count: ^i32) -> fmod.RESULT ---
    EventDescription_GetUserPropertyByIndex :: proc(eventdescription: ^EVENTDESCRIPTION, index: i32, property: ^USER_PROPERTY) -> fmod.RESULT ---
    EventDescription_GetUserProperty :: proc(eventdescription: ^EVENTDESCRIPTION, name: cstring, property: ^USER_PROPERTY) -> fmod.RESULT ---
    EventDescription_GetLength :: proc(eventdescription: ^EVENTDESCRIPTION, length: ^i32) -> fmod.RESULT ---
    EventDescription_GetMinMaxDistance :: proc(eventdescription: ^EVENTDESCRIPTION, min: ^f32, max: ^f32) -> fmod.RESULT ---
    EventDescription_GetSoundSize :: proc(eventdescription: ^EVENTDESCRIPTION, size: ^f32) -> fmod.RESULT ---
    EventDescription_IsSnapshot :: proc(eventdescription: ^EVENTDESCRIPTION, snapshot: ^b32) -> fmod.RESULT ---
    EventDescription_IsOneshot :: proc(eventdescription: ^EVENTDESCRIPTION, oneshot: ^b32) -> fmod.RESULT ---
    EventDescription_IsStream :: proc(eventdescription: ^EVENTDESCRIPTION, isStream: ^b32) -> fmod.RESULT ---
    EventDescription_Is3D :: proc(eventdescription: ^EVENTDESCRIPTION, is3D: ^b32) -> fmod.RESULT ---
    EventDescription_IsDopplerEnabled :: proc(eventdescription: ^EVENTDESCRIPTION, doppler: ^b32) -> fmod.RESULT ---
    EventDescription_HasSustainPoint :: proc(eventdescription: ^EVENTDESCRIPTION, sustainPoint: ^b32) -> fmod.RESULT ---
    EventDescription_CreateInstance :: proc(eventdescription: ^EVENTDESCRIPTION, instance: ^^EVENTINSTANCE) -> fmod.RESULT ---
    EventDescription_GetInstanceCount :: proc(eventdescription: ^EVENTDESCRIPTION, count: ^i32) -> fmod.RESULT ---
    EventDescription_GetInstanceList :: proc(eventdescription: ^EVENTDESCRIPTION, array: ^^EVENTINSTANCE, capacity: i32, count: ^i32) -> fmod.RESULT ---
    EventDescription_LoadSampleData :: proc(eventdescription: ^EVENTDESCRIPTION) -> fmod.RESULT ---
    EventDescription_UnloadSampleData :: proc(eventdescription: ^EVENTDESCRIPTION) -> fmod.RESULT ---
    EventDescription_GetSampleLoadingState :: proc(eventdescription: ^EVENTDESCRIPTION, state: ^LOADING_STATE) -> fmod.RESULT ---
    EventDescription_ReleaseAllInstances :: proc(eventdescription: ^EVENTDESCRIPTION) -> fmod.RESULT ---
    EventDescription_SetCallback :: proc(eventdescription: ^EVENTDESCRIPTION, callback: EVENT_CALLBACK, callbackmask: EVENT_CALLBACK_TYPE) -> fmod.RESULT ---
    EventDescription_GetUserData :: proc(eventdescription: ^EVENTDESCRIPTION, userdata: ^rawptr) -> fmod.RESULT ---
    EventDescription_SetUserData :: proc(eventdescription: ^EVENTDESCRIPTION, userdata: rawptr) -> fmod.RESULT ---



    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // EventInstance
    //

    EventInstance_IsValid :: proc(eventinstance: ^EVENTINSTANCE) -> b32 ---
    EventInstance_GetDescription :: proc(eventinstance: ^EVENTINSTANCE, description: ^^EVENTDESCRIPTION) -> fmod.RESULT ---
    EventInstance_GetVolume :: proc(eventinstance: ^EVENTINSTANCE, volume: ^f32, finalvolume: ^f32) -> fmod.RESULT ---
    EventInstance_SetVolume :: proc(eventinstance: ^EVENTINSTANCE, volume: f32) -> fmod.RESULT ---
    EventInstance_GetPitch :: proc(eventinstance: ^EVENTINSTANCE, pitch: ^f32, finalpitch: ^f32) -> fmod.RESULT ---
    EventInstance_SetPitch :: proc(eventinstance: ^EVENTINSTANCE, pitch: f32) -> fmod.RESULT ---
    EventInstance_Get3DAttributes :: proc(eventinstance: ^EVENTINSTANCE, attributes: ^fmod._3D_ATTRIBUTES) -> fmod.RESULT ---
    EventInstance_Set3DAttributes :: proc(eventinstance: ^EVENTINSTANCE, attributes: ^fmod._3D_ATTRIBUTES) -> fmod.RESULT ---
    EventInstance_GetListenerMask :: proc(eventinstance: ^EVENTINSTANCE, mask: ^u32) -> fmod.RESULT ---
    EventInstance_SetListenerMask :: proc(eventinstance: ^EVENTINSTANCE, mask: u32) -> fmod.RESULT ---
    EventInstance_GetProperty :: proc(eventinstance: ^EVENTINSTANCE, index: EVENT_PROPERTY, value: ^f32) -> fmod.RESULT ---
    EventInstance_SetProperty :: proc(eventinstance: ^EVENTINSTANCE, index: EVENT_PROPERTY, value: f32) -> fmod.RESULT ---
    EventInstance_GetReverbLevel :: proc(eventinstance: ^EVENTINSTANCE, index: i32, level: ^f32) -> fmod.RESULT ---
    EventInstance_SetReverbLevel :: proc(eventinstance: ^EVENTINSTANCE, index: i32, level: f32) -> fmod.RESULT ---
    EventInstance_GetPaused :: proc(eventinstance: ^EVENTINSTANCE, paused: ^b32) -> fmod.RESULT ---
    EventInstance_SetPaused :: proc(eventinstance: ^EVENTINSTANCE, paused: b32) -> fmod.RESULT ---
    EventInstance_Start :: proc(eventinstance: ^EVENTINSTANCE) -> fmod.RESULT ---
    EventInstance_Stop :: proc(eventinstance: ^EVENTINSTANCE, mode: STOP_MODE) -> fmod.RESULT ---
    EventInstance_GetTimelinePosition :: proc(eventinstance: ^EVENTINSTANCE, position: ^i32) -> fmod.RESULT ---
    EventInstance_SetTimelinePosition :: proc(eventinstance: ^EVENTINSTANCE, position: i32) -> fmod.RESULT ---
    EventInstance_GetPlaybackState :: proc(eventinstance: ^EVENTINSTANCE, state: ^PLAYBACK_STATE) -> fmod.RESULT ---
    EventInstance_GetChannelGroup :: proc(eventinstance: ^EVENTINSTANCE, group: ^^fmod.CHANNELGROUP) -> fmod.RESULT ---
    EventInstance_GetMinMaxDistance :: proc(eventinstance: ^EVENTINSTANCE, min: ^f32, max: ^f32) -> fmod.RESULT ---
    EventInstance_Release :: proc(eventinstance: ^EVENTINSTANCE) -> fmod.RESULT ---
    EventInstance_IsVirtual :: proc(eventinstance: ^EVENTINSTANCE, virtualstate: ^b32) -> fmod.RESULT ---
    EventInstance_GetParameterByName :: proc(eventinstance: ^EVENTINSTANCE, name: cstring, value: ^f32, finalvalue: ^f32) -> fmod.RESULT ---
    EventInstance_SetParameterByName :: proc(eventinstance: ^EVENTINSTANCE, name: cstring, value: f32, ignoreseekspeed: b32) -> fmod.RESULT ---
    EventInstance_SetParameterByNameWithLabel :: proc(eventinstance: ^EVENTINSTANCE, name: cstring, label: cstring, ignoreseekspeed: b32) -> fmod.RESULT ---
    EventInstance_GetParameterByID :: proc(eventinstance: ^EVENTINSTANCE, id: PARAMETER_ID, value: ^f32, finalvalue: ^f32) -> fmod.RESULT ---
    EventInstance_SetParameterByID :: proc(eventinstance: ^EVENTINSTANCE, id: PARAMETER_ID, value: f32, ignoreseekspeed: b32) -> fmod.RESULT ---
    EventInstance_SetParameterByIDWithLabel :: proc(eventinstance: ^EVENTINSTANCE, id: PARAMETER_ID, label: cstring, ignoreseekspeed: b32) -> fmod.RESULT ---
    EventInstance_SetParametersByIDs :: proc(eventinstance: ^EVENTINSTANCE, #by_ptr ids: PARAMETER_ID, values: ^f32, count: i32, ignoreseekspeed: b32) -> fmod.RESULT ---
    EventInstance_KeyOff :: proc(eventinstance: ^EVENTINSTANCE) -> fmod.RESULT ---
    EventInstance_SetCallback :: proc(eventinstance: ^EVENTINSTANCE, callback: EVENT_CALLBACK, callbackmask: EVENT_CALLBACK_TYPE) -> fmod.RESULT ---
    EventInstance_GetUserData :: proc(eventinstance: ^EVENTINSTANCE, userdata: ^rawptr) -> fmod.RESULT ---
    EventInstance_SetUserData :: proc(eventinstance: ^EVENTINSTANCE, userdata: rawptr) -> fmod.RESULT ---
    EventInstance_GetCPUUsage :: proc(eventinstance: ^EVENTINSTANCE, exclusive: ^u32, inclusive: ^u32) -> fmod.RESULT ---
    EventInstance_GetMemoryUsage :: proc(eventinstance: ^EVENTINSTANCE, memoryusage: ^MEMORY_USAGE) -> fmod.RESULT ---



    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // Bus
    //

    Bus_IsValid :: proc(bus: ^BUS) -> b32 ---
    Bus_GetID :: proc(bus: ^BUS, id: ^fmod.GUID) -> fmod.RESULT ---
    Bus_GetPath :: proc(bus: ^BUS, path: [^]u8, size: i32, retrieved: ^i32) -> fmod.RESULT ---
    Bus_GetVolume :: proc(bus: ^BUS, volume: ^f32, finalvolume: ^f32) -> fmod.RESULT ---
    Bus_SetVolume :: proc(bus: ^BUS, volume: f32) -> fmod.RESULT ---
    Bus_GetPaused :: proc(bus: ^BUS, paused: ^b32) -> fmod.RESULT ---
    Bus_SetPaused :: proc(bus: ^BUS, paused: b32) -> fmod.RESULT ---
    Bus_GetMute :: proc(bus: ^BUS, mute: ^b32) -> fmod.RESULT ---
    Bus_SetMute :: proc(bus: ^BUS, mute: b32) -> fmod.RESULT ---
    Bus_StopAllEvents :: proc(bus: ^BUS, mode: STOP_MODE) -> fmod.RESULT ---
    Bus_GetPortIndex :: proc(bus: ^BUS, index: ^fmod.PORT_INDEX) -> fmod.RESULT ---
    Bus_SetPortIndex :: proc(bus: ^BUS, index: fmod.PORT_INDEX) -> fmod.RESULT ---
    Bus_LockChannelGroup :: proc(bus: ^BUS) -> fmod.RESULT ---
    Bus_UnlockChannelGroup :: proc(bus: ^BUS) -> fmod.RESULT ---
    Bus_GetChannelGroup :: proc(bus: ^BUS, group: ^^fmod.CHANNELGROUP) -> fmod.RESULT ---
    Bus_GetCPUUsage :: proc(bus: ^BUS, exclusive: ^u32, inclusive: ^u32) -> fmod.RESULT ---
    Bus_GetMemoryUsage :: proc(bus: ^BUS, memoryusage: ^MEMORY_USAGE) -> fmod.RESULT ---



    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // VCA
    //

    VCA_IsValid :: proc(vca: ^VCA) -> b32 ---
    VCA_GetID :: proc(vca: ^VCA, id: ^fmod.GUID) -> fmod.RESULT ---
    VCA_GetPath :: proc(vca: ^VCA, path: ^u8, size: i32, retrieved: ^i32) -> fmod.RESULT ---
    VCA_GetVolume :: proc(vca: ^VCA, volume: ^f32, finalvolume: ^f32) -> fmod.RESULT ---
    VCA_SetVolume :: proc(vca: ^VCA, volume: f32) -> fmod.RESULT ---



    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // Bank
    //

    Bank_IsValid :: proc(bank: ^BANK) -> b32 ---
    Bank_GetID :: proc(bank: ^BANK, id: ^fmod.GUID) -> fmod.RESULT ---
    Bank_GetPath :: proc(bank: ^BANK, path: ^u8, size: i32, retrieved: ^i32) -> fmod.RESULT ---
    Bank_Unload :: proc(bank: ^BANK) -> fmod.RESULT ---
    Bank_LoadSampleData :: proc(bank: ^BANK) -> fmod.RESULT ---
    Bank_UnloadSampleData :: proc(bank: ^BANK) -> fmod.RESULT ---
    Bank_GetLoadingState :: proc(bank: ^BANK, state: ^LOADING_STATE) -> fmod.RESULT ---
    Bank_GetSampleLoadingState :: proc(bank: ^BANK, state: ^LOADING_STATE) -> fmod.RESULT ---
    Bank_GetStringCount :: proc(bank: ^BANK, count: ^i32) -> fmod.RESULT ---
    Bank_GetStringInfo :: proc(bank: ^BANK, index: i32, id: ^fmod.GUID, path: ^u8, size: i32, retrieved: ^i32) -> fmod.RESULT ---
    Bank_GetEventCount :: proc(bank: ^BANK, count: ^i32) -> fmod.RESULT ---
    Bank_GetEventList :: proc(bank: ^BANK, array: ^^EVENTDESCRIPTION, capacity: i32, count: ^i32) -> fmod.RESULT ---
    Bank_GetBusCount :: proc(bank: ^BANK, count: ^i32) -> fmod.RESULT ---
    Bank_GetBusList :: proc(bank: ^BANK, array: ^^BUS, capacity: i32, count: ^i32) -> fmod.RESULT ---
    Bank_GetVCACount :: proc(bank: ^BANK, count: ^i32) -> fmod.RESULT ---
    Bank_GetVCAList :: proc(bank: ^BANK, array: ^^VCA, capacity: i32, count: ^i32) -> fmod.RESULT ---
    Bank_GetUserData :: proc(bank: ^BANK, userdata: ^rawptr) -> fmod.RESULT ---
    Bank_SetUserData :: proc(bank: ^BANK, userdata: rawptr) -> fmod.RESULT ---



    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // Command playback information
    //

    CommandReplay_IsValid :: proc(replay: ^COMMANDREPLAY) -> b32 ---
    CommandReplay_GetSystem :: proc(replay: ^COMMANDREPLAY, system: ^^SYSTEM) -> fmod.RESULT ---
    CommandReplay_GetLength :: proc(replay: ^COMMANDREPLAY, length: ^f32) -> fmod.RESULT ---
    CommandReplay_GetCommandCount :: proc(replay: ^COMMANDREPLAY, count: ^i32) -> fmod.RESULT ---
    CommandReplay_GetCommandInfo :: proc(replay: ^COMMANDREPLAY, commandindex: i32, info: ^COMMAND_INFO) -> fmod.RESULT ---
    CommandReplay_GetCommandString :: proc(replay: ^COMMANDREPLAY, commandindex: i32, buffer: ^u8, length: i32) -> fmod.RESULT ---
    CommandReplay_GetCommandAtTime :: proc(replay: ^COMMANDREPLAY, time: f32, commandindex: ^i32) -> fmod.RESULT ---
    CommandReplay_SetBankPath :: proc(replay: ^COMMANDREPLAY, bankPath: cstring) -> fmod.RESULT ---
    CommandReplay_Start :: proc(replay: ^COMMANDREPLAY) -> fmod.RESULT ---
    CommandReplay_Stop :: proc(replay: ^COMMANDREPLAY) -> fmod.RESULT ---
    CommandReplay_SeekToTime :: proc(replay: ^COMMANDREPLAY, time: f32) -> fmod.RESULT ---
    CommandReplay_SeekToCommand :: proc(replay: ^COMMANDREPLAY, commandindex: i32) -> fmod.RESULT ---
    CommandReplay_GetPaused :: proc(replay: ^COMMANDREPLAY, paused: ^b32) -> fmod.RESULT ---
    CommandReplay_SetPaused :: proc(replay: ^COMMANDREPLAY, paused: b32) -> fmod.RESULT ---
    CommandReplay_GetPlaybackState :: proc(replay: ^COMMANDREPLAY, state: ^PLAYBACK_STATE) -> fmod.RESULT ---
    CommandReplay_GetCurrentCommand :: proc(replay: ^COMMANDREPLAY, commandindex: ^i32, currenttime: ^f32) -> fmod.RESULT ---
    CommandReplay_Release :: proc(replay: ^COMMANDREPLAY) -> fmod.RESULT ---
    CommandReplay_SetFrameCallback :: proc(replay: ^COMMANDREPLAY, callback: COMMANDREPLAY_FRAME_CALLBACK) -> fmod.RESULT ---
    CommandReplay_SetLoadBankCallback :: proc(replay: ^COMMANDREPLAY, callback: COMMANDREPLAY_LOAD_BANK_CALLBACK) -> fmod.RESULT ---
    CommandReplay_SetCreateInstanceCallback :: proc(replay: ^COMMANDREPLAY, callback: COMMANDREPLAY_CREATE_INSTANCE_CALLBACK) -> fmod.RESULT ---
    CommandReplay_GetUserData :: proc(replay: ^COMMANDREPLAY, userdata: ^rawptr) -> fmod.RESULT ---
    CommandReplay_SetUserData :: proc(replay: ^COMMANDREPLAY, userdata: rawptr) -> fmod.RESULT ---
}
