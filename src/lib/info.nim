import libapi, libvsnode, libvsframe
import ../wrapper/vapoursynth4

type
  VSVideoInfoObj* = object
    handle*: ptr Vsvideoinfo

proc getVideoInfo*(node:VSNodeObj):VSVideoInfoObj =
  result.handle = api.handle.getVideoInfo(node.handle)
  

proc format*(info:VSVideoInfoObj):VSVideoFormat =
  info.handle.format

proc fpsnum*(info:VSVideoInfoObj):int =
  info.handle.fpsnum

proc fpsden*(info:VSVideoInfoObj):int =
  info.handle.fpsden

proc width*(info:VSVideoInfoObj):int =
  info.handle.width

proc height*(info:VSVideoInfoObj):int =
  info.handle.height

proc numFrames*(info:VSVideoInfoObj):int =
  info.handle.numFrames
#[
  structvsvideoinfo* {.pure, inheritable, bycopy.} = object
    format*: Vsvideoformat   ## Generated based on /usr/include/vapoursynth/VapourSynth4.h:247:16
    fpsnum*: int64
    fpsden*: int64
    width*: cint
    height*: cint
    numframes*: cint
]#

# VSVideoFormat
proc colorFamily*(vf:VSVideoFormat): VSColorFamily =
  vf.colorFamily.VSColorFamily




#[
  structvsvideoformat* {.pure, inheritable, bycopy.} = object
    colorfamily*: cint       ## Generated based on /usr/include/vapoursynth/VapourSynth4.h:165:16
    sampletype*: cint
    bitspersample*: cint
    bytespersample*: cint
    subsamplingw*: cint
    subsamplingh*: cint
    numplanes*: cint
]#


# Frame Format
type
  VSVideoFormatObj* = object
    handle*: ptr Vsvideoformat

proc getVideoFrameFormat*(frame: VSFrameObj):VSVideoFormatObj =
  result.handle = api.handle.getVideoFrameFormat(frame.handle)

proc colorFamily*(vf:VSVideoFormatObj): VSColorFamily =
  vf.handle.colorFamily.VSColorFamily

proc sampleType*(vf:VSVideoFormatObj): int =
  vf.handle.sampleType.int

proc bitsPerSample*(vf:VSVideoFormatObj): int =
  vf.handle.bitsPerSample.int

proc bytesPerSample*(vf:VSVideoFormatObj): int =
  vf.handle.bytesPerSample.int

proc subSamplingW*(vf:VSVideoFormatObj): int =
  vf.handle.subSamplingW.int

proc numPlanes*(vf:VSVideoFormatObj): int =
  vf.handle.numPlanes.int