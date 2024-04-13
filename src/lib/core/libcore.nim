#[
setMaxCacheSize

setThreadCount
]#
import ../../wrapper/vapoursynth4
import ../api/libapi
import std/[strutils,strformat] #, os]

type
  VSCoreObj* = object
    handle*: ptr Vscore  
  VSCoreRef* = ref VSCoreObj

proc newCore*(self:VSAPIRef; val:int):VSCoreRef =
  result = new VSCoreRef
  result.handle = self.handle.createCore(val.cint)



# Core Info
proc getCoreInfo*(api:VSApiRef;core:VSCoreRef):VSCoreInfo =
  api.handle.getcoreinfo(core.handle, result.unsafeAddr)



proc `$`*(val:VSCoreInfo):string =
  result = &"""VSCoreInfo:
  Version String:
{indent($val.versionstring,4)}
  core: {$val.core}
  api: {$val.api}
  numthreads: {$val.numthreads}
  maxframebuffersize: {$val.maxframebuffersize}
  usedframebuffersize: {$val.usedframebuffersize}
  """


# proc `=destroy`*(self: VSCoreObj) =
#   echo "[INFO] destroying VSCoreObj instance"
#   if self.handle != nil:
#     #echo repr api.handle
#     echo "ok"
#     echo api.getCoreInfo(self)
#     # sleep(2000)
#     # echo repr api.handle
#     echo self
#     echo api.handle == nil
#     echo self.handle == nil
#     api.handle.freecore(self.handle)
#     echo "ok"

proc getVersionString*(api:VSApiRef;core:VSCoreRef):string =
  var info:VSCoreInfo
  api.handle.getCoreinfo(core.handle, info.unsafeAddr)
  return $info.versionstring

proc getApiVersion*(api:VSApiRef):int =
  # the same value as info.api
  api.handle.getApiVersion()


