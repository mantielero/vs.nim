import ../../wrapper/vapoursynth4
import ../api/libapi
import std/strformat

type
  VSAudioFormatObj = object
    handle*: ptr VSAudioFormat
  VSAudioFormatRef* = ref VSAudioFormatObj

# VSAudioFormatObj
proc sampleType*(format: VSAudioFormatRef):VSSampleType =
  return format.handle.sampleType.VSSampleType

proc bitsPerSample*(format: VSAudioFormatRef):int =
  return format.handle.bitsPerSample.int

proc bytesPerSample*(format: VSAudioFormatRef):int =
  return format.handle.bytesPerSample.int

proc numChannels*(format: VSAudioFormatRef):int =
  return format.handle.numChannels.int

proc channelLayout*(format: VSAudioFormatRef):int =
  return format.handle.channelLayout.int

proc getAudioFormatName*(format:VSAudioFormatRef):string =
  var ret = api.handle.getAudioFormatName(format.handle, result.cstring)

# VSAudioFormat
proc sampleType*(format: VSAudioFormat):VSSampleType =
  return format.sampleType.VSSampleType

proc bitsPerSample*(format: VSAudioFormat):int =
  return format.bitsPerSample.int

proc bytesPerSample*(format: VSAudioFormat):int =
  return format.bytesPerSample.int

proc numChannels*(format: VSAudioFormat):int =
  return format.numChannels.int

proc channelLayout*(format: VSAudioFormat):int =
  return format.channelLayout.int

proc getAudioFormatName*(format:VSAudioFormat):string =
  var ret = api.handle.getAudioFormatName(format.unsafeAddr, result.cstring)
  #if ret 

proc `$`*(format: VSAudioFormat):string =
  result = &"VSAudioFormat(sampleType: {format.sampleType}, "
  result &= &"bitsPerSample: {format.bitsPerSample}, "
  result &= &"bytesPerSample: {format.bytesPerSample}, "
  result &= &"numChannels: {format.numChannels}, "
  result &= &"channelLayout: {format.channelLayout})"