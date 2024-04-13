import ./[types,error, keys]
import ../api/libapi
import ../node/libvsnode
import ../frame/libvsframe
import ../function/libvsfunction
import ../../wrapper/vapoursynth4
import std/[strformat]

# proc propGetData*(vsmap:VSMapObj; key:string; idx:int):string = 
#   ## Given a `key` retrieves the string stored at position `idx` from a map.
#   #checkLimits(vsmap, key.string, idx)

#   var err = peUnset.cint
#   var perr = cast[ptr cint](unsafeAddr(err))  
#   result = $api.handle.mapGetData(vsmap.handle, key, idx.cint, perr)
#   #checkError(err.VSMapPropertyError, key.string, idx)

proc getData*(vsmap:VSMapRef; key:string; idx:int):string = 
  ## Given a `key` retrieves the string stored at position `idx` from a map.
  #checkLimits(vsmap, key.string, idx)

  var err = peUnset.cint
  var perr = cast[ptr cint](unsafeAddr(err))  
  result = $api.handle.mapGetData(vsmap.handle, key, idx.cint, perr)
  #checkError(err.VSMapPropertyError, key.string, idx)


# proc propGetDataSize*(vsmap:VSMapObj; key:string; idx:int ):int = 
#   ## Returns the size in bytes of a property of type ptData (see VSPropertyType), or 0 in case of error. The terminating NULL byte added by propSetData() is not counted.
#   checkLimits(vsmap, key, idx)  
#   var err = peUnset.cint
#   var perr = cast[ptr cint](unsafeAddr(err))  
#   result = api.handle.mapGetDataSize(vsmap.handle, key.cstring,idx.cint,perr).int
#   checkError(err.VSMapPropertyError, key, idx)

proc getDataSize*(vsmap:VSMapRef; key:string; idx:int ):int = 
  ## Returns the size in bytes of a property of type ptData (see VSPropertyType), or 0 in case of error. The terminating NULL byte added by propSetData() is not counted.
  checkLimits(vsmap, key, idx)  
  var err = peUnset.cint
  var perr = cast[ptr cint](unsafeAddr(err))  
  result = api.handle.mapGetDataSize(vsmap.handle, key.cstring,idx.cint,perr).int
  checkError(err.VSMapPropertyError, key, idx)

# proc propGetInt*(vsmap:VSMapObj; key:string; idx:int):int = 
#   ## Given a `key` retrieves the integer value stored at position `idx` from a map.
#   checkLimits(vsmap, key, idx)  
#   var err = peUnset.cint
#   var perr = cast[ptr cint](unsafeAddr(err))  
#   result = api.handle.mapGetInt( vsmap.handle, 
#                                  key.cstring, 
#                                  idx.cint, 
#                                  perr).int
#   checkError(err.VSMapPropertyError, key, idx)

proc getInt*(vsmap:VSMapRef; key:string; idx:int):int = 
  ## Given a `key` retrieves the integer value stored at position `idx` from a map.
  checkLimits(vsmap, key, idx)  
  var err = peUnset.cint
  var perr = cast[ptr cint](unsafeAddr(err))  
  result = api.handle.mapGetInt( vsmap.handle, 
                                 key.cstring, 
                                 idx.cint, 
                                 perr).int
  checkError(err.VSMapPropertyError, key, idx)

# proc propGetFloat*(vsmap:VSMapObj; key:string; idx:int):float =
#   ## Given a `key` retrieves the integer value stored at position `idx` from a map.
#   checkLimits(vsmap, key, idx)  
#   var err = peUnset.cint
#   var perr = cast[ptr cint](unsafeAddr(err)) 
#   result = api.handle.mapGetFloat( vsmap.handle, 
#                             key.cstring, 
#                             idx.cint, 
#                             perr).float
#   checkError(err.VSMapPropertyError, key, idx)


proc getFloat*(vsmap:VSMapRef; key:string; idx:int):float =
  ## Given a `key` retrieves the integer value stored at position `idx` from a map.
  checkLimits(vsmap, key, idx)  
  var err = peUnset.cint
  var perr = cast[ptr cint](unsafeAddr(err)) 
  result = api.handle.mapGetFloat( vsmap.handle, 
                            key.cstring, 
                            idx.cint, 
                            perr).float
  checkError(err.VSMapPropertyError, key, idx)

# proc propGetIntArray*(vsmap:VSMapObj; key:string):seq[int] = 
#   ## Retrieves an array of integers from a map.
#   var err = peUnset.cint
#   var perr = cast[ptr cint](unsafeAddr(err))
#   let address:ptr int64 = api.handle.mapGetIntArray(vsmap.handle, key.cstring, perr)
#   let size = vsmap.len(key)
#   if err.VSMapPropertyError == peType:
#     raise newException(ValueError, &"the VSMap's key=\"{key}\" does not contain strings")

#   var data = newSeq[int](size)
#   if size != 0:
#     copyMem(addr data[0], address, size*sizeof(int64))
#   result = data

proc getIntArray*(vsmap:VSMapRef; key:string):seq[int] = 
  ## Retrieves an array of integers from a map.
  var err = peUnset.cint
  var perr = cast[ptr cint](unsafeAddr(err))
  let address:ptr int64 = api.handle.mapGetIntArray(vsmap.handle, key.cstring, perr)
  let size = vsmap.len(key)
  if err.VSMapPropertyError == peType:
    raise newException(ValueError, &"the VSMap's key=\"{key}\" does not contain strings")

  var data = newSeq[int](size)
  if size != 0:
    copyMem(addr data[0], address, size*sizeof(int64))
  result = data

# proc propGetFloatArray*(vsmap:VSMapObj; key:string):seq[float] =
#   ## Retrieves an array of floating point numbers from a map.
#   var err = peUnset.cint
#   var perr = cast[ptr cint](unsafeAddr(err)) 
#   let address:ptr cdouble = api.handle.mapGetFloatArray(vsmap.handle, key.cstring, perr)
#   let size = vsmap.len(key)
#   if err.VSMapPropertyError == peType:
#     raise newException(ValueError, &"the VSMap's key=\"{key}\" does not contain strings")

#   var data = newSeq[float](size)
#   if size != 0:
#     copyMem(addr data[0], address, size * sizeof(float))
#   result = data

proc getFloatArray*(vsmap:VSMapRef; key:string):seq[float] =
  ## Retrieves an array of floating point numbers from a map.
  var err = peUnset.cint
  var perr = cast[ptr cint](unsafeAddr(err)) 
  let address:ptr cdouble = api.handle.mapGetFloatArray(vsmap.handle, key.cstring, perr)
  let size = vsmap.len(key)
  if err.VSMapPropertyError == peType:
    raise newException(ValueError, &"the VSMap's key=\"{key}\" does not contain strings")

  var data = newSeq[float](size)
  if size != 0:
    copyMem(addr data[0], address, size * sizeof(float))
  result = data

# proc propGetNode*( vsmap:VSMapObj; key:string; idx:int):VSNodeObj =
#   ## Retrieves a node from a map.
#   checkLimits(vsmap, key, idx)
#   var err = peUnset.cint
#   var perr = cast[ptr cint](unsafeAddr(err))   
#   result.handle = api.handle.mapGetNode(vsmap.handle, key.cstring, idx.cint, perr)
#   checkError(err.VSMapPropertyError, key, idx)

proc getNode*( vsmap:VSMapRef; key:string; idx:int):VSNodeRef =
  ## Retrieves a node from a map.
  
  checkLimits(vsmap, key, idx)
  var err = peUnset.cint
  var perr = cast[ptr cint](unsafeAddr(err))   
  result = new VSNodeRef
  result.handle = api.handle.mapGetNode(vsmap.handle, key.cstring, idx.cint, perr)
  checkError(err.VSMapPropertyError, key, idx)

# proc propGetFrame*( vsmap:VSMapObj; key:string; idx:int):VSFrameObj =
#   ## Retrieves a frame from a map.
#   checkLimits(vsmap, key, idx)   
#   var err = peUnset.cint
#   var perr = cast[ptr cint](unsafeAddr(err))  
#   result.handle = api.handle.mapGetFrame(vsmap.handle, key.cstring, idx.cint, perr)
#   checkError(err.VSMapPropertyError, key, idx)  

proc getFrame*( vsmap:VSMapRef; key:string; idx:int):VSFrameRef =
  ## Retrieves a frame from a map.
  checkLimits(vsmap, key, idx)   
  var err = peUnset.cint
  var perr = cast[ptr cint](unsafeAddr(err))  
  result = new VSFrameRef
  result.handle = api.handle.mapGetFrame(vsmap.handle, key.cstring, idx.cint, perr)
  checkError(err.VSMapPropertyError, key, idx)  


# proc propGetFunc*( vsmap:VSMapObj; key:string; idx:int ):VSFunctionObj =
#   ## Retrieves a function from a map.
#   checkLimits(vsmap, key, idx)   
#   var err = peUnset.cint
#   var perr = cast[ptr cint](unsafeAddr(err))  
#   result.handle = api.handle.mapGetFunction(vsmap.handle,key.cstring, idx.cint, perr)
#   checkError(err.VSMapPropertyError, key, idx)

proc getFunc*( vsmap:VSMapRef; key:string; idx:int ):VSFunctionRef =
  ## Retrieves a function from a map.
  checkLimits(vsmap, key, idx)   
  var err = peUnset.cint
  var perr = cast[ptr cint](unsafeAddr(err))  
  result = new VSFunctionRef
  result.handle = api.handle.mapGetFunction(vsmap.handle,key.cstring, idx.cint, perr)
  checkError(err.VSMapPropertyError, key, idx)
