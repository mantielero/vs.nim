#[
setMaxCacheSize

setThreadCount
]#
import ../wrapper/vapoursynth4
import libapi
import std/[strutils,strformat]

type
  VSCoreObj* = object
    handle*: ptr Vscore  

proc createCore*(self:VSAPIObj; val:cint):VSCoreObj =
  result.handle = self.handle.createCore(val)

proc `=destroy`*(self: VSCoreObj) =
  echo "[INFO] destroying VSCoreObj instance"
  if not (self.handle == nil):
    #echo api
    api.handle.freecore(self.handle)

# Core Info
proc getCoreInfo*(api:VSApiObj;core:VSCoreObj):VSCoreInfo =
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


proc getVersionString*(api:VSApiObj;core:VSCoreObj):string =
  var info:VSCoreInfo
  api.handle.getcoreinfo(core.handle, info.unsafeAddr)
  return $info.versionstring

proc getApiVersion*(api:VSApiObj):int =
  # the same value as info.api
  api.handle.getapiversion()


