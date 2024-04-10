

import ../wrapper/vapoursynth4
import libapi, libvsnode

type
  VSAudioNodeObj* = VSNodeObj#object
    #handle*:ptr VSNode


# proc `=destroy`*(value: VSAudioNodeObj) =
#   api.handle.freeNode(value.handle)