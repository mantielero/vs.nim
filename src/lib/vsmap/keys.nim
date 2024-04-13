import ./[types]
import ../api/libapi
import ../../wrapper/vapoursynth4

proc len*[T:VSMapObj|VSMapRef](vsmap: T):int = 
  ## Returns the number of keys contained in a property map.
  api.handle.mapNumKeys(vsmap.handle).int

proc key*(vsmap:VSMapRef; idx:int):string = 
  ## Returns a key from a property map.
  assert(idx >= 0, "`idx` shall be >= 0")
  assert(idx < vsmap.len, "`idx` shall be <= " & $vsmap.len)
  #if idx < 0:
  #  raise newException(ValueError, )
  #elif idx >= vsmap.len:
  #  raise newException(ValueError, &"`idx` shall be <= {vsmap.len}")
  #var key = $API.propGetKey(vsmap, idx.cint)
  #var x = newString(key.len)
  #copyMem(addr(x[0]), addr(key), key.len)
  #return key
  return $api.handle.mapGetKey(vsmap.handle, idx.cint)




proc getType*(vsmap:VSMapRef; key:string):VSPropertyType = 
  ## Returns the type of the elements associated with the given key in a property map.
  ## The returned value is one of VSPropertyType. If there is no such key in the map, the returned value is ptUnset.
  api.handle.mapGetType(vsmap.handle, key.cstring).VSPropertyType


proc len*[T:VSMapObj|VSMapRef](vsmap:T; key:string):int = 
  ## Returns the number of elements associated with a key in
  ## a property map. Returns -1 if there is no such key in the map.
  api.handle.mapNumElements(vsmap.handle, key).int

proc propDeleteKey*(vsmap:VSMapObj; key:string) = 
  ## Removes the property with the given key. All values associated with the key are lost.
  ## Returns 0 if the key isn’t in the map. Otherwise it returns 1. 
  var ret = api.handle.mapDeleteKey(vsmap.handle, key.cstring).int
  if ret == 0:
    raise newException(ValueError, "the key '" & key & "' isn't in the maps")

# Friendly API
iterator keys*(vsmap:VSMapRef):string =
  for idx in 0..<vsmap.len:
    yield vsmap.key(idx)