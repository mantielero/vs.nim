

import ../../wrapper/vapoursynth4
import ../api/libapi 
import std/[strformat]


type
  VSNodeObj = object
    handle*:ptr VSNode
  VSNodeRef* = ref VSNodeObj

proc `=destroy`*(value: VSNodeObj) =
  api.handle.freeNode(value.handle)


proc `$`*(val: VSNodeRef):string =
  return "VSNodeObj ()"