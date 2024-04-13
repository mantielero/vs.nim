import ../../wrapper/vapoursynth4
import ../api/libapi
type
  VSMapObj* = object
    handle*:ptr VSMap
  VSMapRef* = ref VSMapObj


proc `=destroy`*(self: VSMapObj) =
  #if not self.handle.isNil:
  if self.handle != nil:
    #echo sizeof( *self.handle )
    #echo sizeof(ptr VSMap) 
    #echo "destroying VSMapObj"    
    api.handle.freeMap(self.handle)

# proc `=wasMoved`*(self: var VSMapObj) =
#   self.handle = nil

#proc `=sink`(dest: var VSMapObj; source: VSMapObj) {.error.}
#proc `=move`(dest: var VSMapObj; source: VSMapObj) {.error.}
#proc `=copy`*(dest: var VSMapObj; src: VSMapObj) {.error.}


proc `=sink`(dest: var VSMapObj; source: VSMapObj) =
  `=destroy`(dest)  # Frees the destination
  wasMoved(dest)    # assigns 'nil' to the handle
  dest.handle = source.handle


proc `=copy`*(dst: var VSMapObj; src: VSMapObj) =
  # do nothing for self-assignments:
  if dst.handle == src.handle: return
  
  # clean the destination
  `=destroy`(dst)  
  wasMoved(dst)
  dst.handle = src.handle
  # a.len = b.len
  # a.cap = b.cap
  # if b.data != nil:
  #   a.data = cast[typeof(a.data)](alloc(a.cap * sizeof(T)))
  #   for i in 0..<a.len:
  #     a.data[i] = b.data[i]



# proc `=sink`(dest: var VSMapObj; source: VSMapObj) =
#   # protect against self-assignments:
#   if dest.handle != source.handle:
#     `=destroy`(dest)
#     wasMoved(dest)
#     #copyMap(source, dest) #.handle = source.handle
#     api.handle.copyMap( source.handle, dest.handle )
# #    void (VS_CC *copyMap)(const VSMap *src, VSMap *dst) VS_NOEXCEPT; /* copies all values in src to dst, if a key alrea…

