import ../../wrapper/vapoursynth4
import ../api/libapi
import ../core/libcore


let core* = api.newCore(0)
let info* = getCoreInfo(api, core)

proc getVersionString*():string =
  var info:VSCoreInfo
  api.handle.getcoreinfo(core.handle, info.unsafeAddr)
  return $info.versionstring


proc getInfoCore*():int =
  var info:VSCoreInfo
  api.handle.getcoreinfo(core.handle, info.unsafeAddr)
  return info.core.int

proc getApiVersion*():int =
  var info:VSCoreInfo
  api.handle.getcoreinfo(core.handle, info.unsafeAddr)
  return info.api.int



proc getInfoNumThreads*():int =
  var info:VSCoreInfo
  api.handle.getcoreinfo(core.handle, info.unsafeAddr)
  return info.numthreads.int

proc getInfoMaxFrameBufferSize*():int =
  var info:VSCoreInfo
  api.handle.getcoreinfo(core.handle, info.unsafeAddr)
  return info.maxframebuffersize.int

proc getInfoUsedFrameBufferSize*():int =
  var info:VSCoreInfo
  api.handle.getcoreinfo(core.handle, info.unsafeAddr)
  return info.usedframebuffersize.int
