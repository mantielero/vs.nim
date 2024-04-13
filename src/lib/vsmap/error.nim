import ./[types,keys]
import ../api/libapi
import ../../wrapper/vapoursynth4

proc getError*(vsmap:VSMapObj):string = 
  ## Returns a pointer to the error message contained in the map, 
  ## or NULL if there is no error message. The pointer is valid as
  ## long as the map lives.
  $api.handle.mapGetError(vsmap.handle)


proc setError*(vsmap:VSMapObj, errorMessage:string) = 
  ## Adds an error message to a map. The map is cleared first. The error message is copied. In this state the map may only be freed, cleared or queried for the error message.
  ##
  ## For errors encountered in a filter’s "getframe" function, use setFilterError.
  api.handle.mapSetError(vsmap.handle, errorMessage.cstring)


template checkLimits*[T:VSMapObj|VSMapRef](vsmap:T; key:string; idx: int) =
  assert( idx >= 0, "`idx` shall be >= 0")
  assert( idx < vsmap.len(key), "`idx` shall be <" & $vsmap.len(key) & " but got: " & $idx)



proc checkError*(error:VSMapPropertyError; key:string; idx:int) =                                                                 
  case error
  of peIndex:
    raise newException(ValueError, "the index " & $idx & " is out of range")
  of peType:
    raise newException(ValueError, "the VSMap's key=" & key & " does not contain strings")
  else: # peUnset:
    discard 
