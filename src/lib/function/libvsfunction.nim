import ../../wrapper/vapoursynth4
import ../api/libapi 

type
  VSFunctionObj = object
    handle*:ptr VSFunction
  VSFunctionRef* = ref VSFunctionObj

proc `=destroy`*(value: VSFunctionObj) =
  api.handle.freeFunction(value.handle)