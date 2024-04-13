
import ../../wrapper/vapoursynth4
import ../api/libapi
import ../node/libvsnode
import ../audio/audioformat

type
  VSFrameObj = object
    handle*:ptr VSFrame
  VSFrameRef* = ref VSFrameObj
  

proc `=destroy`*(value: VSFrameObj) =
  if value.handle != nil:
    api.handle.freeFrame(value.handle)


proc width*(frame:VSFrameRef; plane:int):int =
  api.handle.getFrameWidth(frame.handle, plane.cint)


proc height*(frame:VSFrameRef; plane:int):int =
  api.handle.getFrameHeight(frame.handle, plane.cint)


proc getReadPtr*(frame:VSFrameRef; plane:int):uint =
  ## returns a read-only pointer to a plane or channel 
  ## of a frame. Returns NULL if an invalid plane or 
  ## channel number is passed.
  cast[uint](api.handle.getReadPtr(frame.handle, plane.cint))  # ptr uint8

# proc getReadPtrInt*(frame:VSFrameRef; plane:int):iint =
#   cast[int](api.handle.getReadPtr(frame.handle, plane.cint)) 

proc getStride*(frame:VSFrameRef; plane:int):uint =
  ## returns the distance in bytes between two consecutive 
  ## lines of a plane of a video frame. The stride is always 
  ## positive. Returns 0 if the requested plane doesn’t exist 
  ## or if it isn’t a video frame.
  api.handle.getStride(frame.handle, plane.cint).uint   # clong

#      getstride*: proc (a0: ptr Vsframe; a1: cint): ptrdifft {.cdecl.} 

proc getFrame*(node:VSNodeRef; frame_number:int):VSFrameRef =
  ## http://www.vapoursynth.com/doc/api/vapoursynth.h.html#getframe
  let errorSize = 256
  var errorMsg = newString(errorSize)
  result = new VSFrameRef
  result.handle = api.handle.getFrame(frame_number.cint, 
                                      node.handle, 
                                      unsafeAddr(errorMsg[0]), 
                                      errorSize.cint) #nil, 0 )

  if result.handle == nil:
    raise newException( ValueError, "failed: {errorMsg}")


# AUDIO
proc getAudioFrameFormat*(frame: VSFrameRef): VSAudioFormatRef =
  result = new VSAudioFormatRef  
  result.handle = api.handle.getAudioFrameFormat(frame.handle)


proc getFrameLength*(frame: VSFrameRef):int =
  api.handle.getFrameLength(frame.handle).int
