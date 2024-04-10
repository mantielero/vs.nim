

import ../wrapper/vapoursynth4
import libapi 
import std/[strformat]


type
  VSNodeObj* = object
    handle*:ptr VSNode


proc `=destroy`*(value: VSNodeObj) =
  api.handle.freeNode(value.handle)


