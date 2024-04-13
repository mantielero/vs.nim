import ../../wrapper/vapoursynth4
import ../api/libapi
import ../node/libvsnode
import std/strformat

# VSAudioInfo
type
  VSAudioInfoObj = object
    handle*: ptr Vsaudioinfo
  VSAudioInfoRef* = ref VSAudioInfoObj
  

proc getAudioInfo*(node:VSNodeRef):VSAudioInfoRef =
  result = new VSAudioInfoRef
  result.handle = api.handle.getAudioInfo(node.handle)

proc format*(info:VSAudioInfoRef):VSAudioFormat =
  info.handle.format

proc sampleRate*(info:VSAudioInfoRef):int =
  info.handle.sampleRate.int

proc numSamples*(info:VSAudioInfoRef):int =
  info.handle.numSamples.int

proc numFrames*(info:VSAudioInfoRef):int =
  info.handle.numFrames.int

proc `$`*(info:VSAudioInfoRef):string =
  result = &"""VSAudioInfoRef:
  format: {info.format}
  sampleRate: {info.sampleRate}
  numSamples: {info.numSamples}
  numFrames:  {info.numFrames}
"""

