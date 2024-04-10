import ../wrapper/vapoursynth4
import libapi 

type
  VSFunctionObj* = object
    handle*:ptr VSFunction

proc `=destroy`*(value: VSFunctionObj) =
  api.handle.freeFunction(value.handle)