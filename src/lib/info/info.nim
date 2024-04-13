import ../api/libapi
import ../node/libvsnode
import ../frame/libvsframe
import ../../wrapper/vapoursynth4

type
  VSVideoInfoObj = object
    handle*: ptr Vsvideoinfo
  VSVideoInfoRef* = ref VSVideoInfoObj

proc getVideoInfo*(node:VSNodeRef):VSVideoInfoRef =
  result = new VSVideoInfoRef
  result.handle = api.handle.getVideoInfo(node.handle)
  

proc format*(info:VSVideoInfoRef):VSVideoFormat =
  info.handle.format

proc fpsnum*(info:VSVideoInfoRef):int =
  info.handle.fpsnum

proc fpsden*(info:VSVideoInfoRef):int =
  info.handle.fpsden

proc width*(info:VSVideoInfoRef):int =
  info.handle.width

proc height*(info:VSVideoInfoRef):int =
  info.handle.height

proc numFrames*(info:VSVideoInfoRef):int =
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
  VSVideoFormatObj = object
    handle*: ptr Vsvideoformat
  VSVideoFormatRef* = ref VSVideoFormatObj

proc getVideoFrameFormat*(frame: VSFrameRef):VSVideoFormatRef =
  result = new VSVideoFormatRef
  result.handle = api.handle.getVideoFrameFormat(frame.handle)

proc colorFamily*(vf:VSVideoFormatRef): VSColorFamily =
  vf.handle.colorFamily.VSColorFamily

proc sampleType*(vf:VSVideoFormatRef): int =
  vf.handle.sampleType.int

proc bitsPerSample*(vf:VSVideoFormatRef): int =
  vf.handle.bitsPerSample.int

proc bytesPerSample*(vf:VSVideoFormatRef): int =
  vf.handle.bytesPerSample.int

proc subSamplingW*(vf:VSVideoFormatRef): int =
  vf.handle.subSamplingW.int

proc numPlanes*(vf:VSVideoFormatRef): int =
  vf.handle.numPlanes.int