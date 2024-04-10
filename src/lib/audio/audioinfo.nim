import ../../wrapper/vapoursynth4
import ../[libapi,libvsnode]
import std/strformat

# VSAudioInfo
type
  VSAudioInfoObj* = object
    handle*: ptr Vsaudioinfo

proc getAudioInfo*(node:VSNodeObj):VSAudioInfoObj =
  result.handle = api.handle.getAudioInfo(node.handle)

proc format*(info:VSAudioInfoObj):VSAudioFormat =
  info.handle.format

proc sampleRate*(info:VSAudioInfoObj):int =
  info.handle.sampleRate.int

proc numSamples*(info:VSAudioInfoObj):int =
  info.handle.numSamples.int

proc numFrames*(info:VSAudioInfoObj):int =
  info.handle.numFrames.int

proc `$`*(info:VSAudioInfoObj):string =
  result = &"""VSAudioInfoObj:
  format: {info.format}
  sampleRate: {info.sampleRate}
  numSamples: {info.numSamples}
  numFrames:  {info.numFrames}
"""

