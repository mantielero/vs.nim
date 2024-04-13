import ./[types,error]
import ../api/libapi
import ../node/libvsnode
import ../frame/libvsframe
import ../function/libvsfunction
import ../../wrapper/vapoursynth4

# Setting data
# proc append*(vsmap:VSMapObj; key, data:string) =
#   ## appends a string
#   let ret = api.handle.mapSetData( vsmap.handle, 
#                                    key.cstring, 
#                                    data.cstring, 
#                                    data.len.cint, 
#                                    ptData.cint, 
#                                    maAppend.cint )
#   if ret == 1:
#     raise newException(ValueError, "trying to append a string to a property with the wrong type")

proc set*(m:VSMapRef; key, data:string) =
  ## appends a string
  #echo m.handle == nil
  let ret = api.handle.mapSetData( m.handle, 
                                   key.cstring, 
                                   data.cstring, 
                                   data.len.cint, 
                                   ptData.cint, 
                                   maAppend.cint )
  if ret == 1:
    raise newException(ValueError, "trying to append a string to a property with the wrong type")

proc set*(m:VSMapRef; key:string; data:seq[string]) =
  ## appends a string sequence to a key
  for d in data:
    m.set(key, d)


# proc append*(vsmap:VSMapObj; key:string; data:int) =
#   ## appends an integer
#   let ret = api.handle.mapSetInt( vsmap.handle, 
#                                   key.cstring, 
#                                   data.cint, 
#                                   maAppend.cint )
#   if ret == 1:
#     raise newException(ValueError, "trying to append an integer to a property with the wrong type")  

proc set*(vsmap:VSMapRef; key:string; data:int) =
  ## appends an integer
  let ret = api.handle.mapSetInt( vsmap.handle, 
                                  key.cstring, 
                                  data.cint, 
                                  maAppend.cint )
  if ret == 1:
    raise newException(ValueError, "trying to append an integer to a property with the wrong type")  


# proc append*(vsmap:VSMapObj; key:string; data:float) =
#   ## appends a float
#   let ret = api.handle.mapSetFloat( vsmap.handle, 
#                                     key.cstring, 
#                                     data.cdouble, 
#                                     maAppend.cint)
#   if ret == 1:
#     raise newException(ValueError, "trying to append a float to a property with the wrong type")

proc set*(vsmap:VSMapRef; key:string; data:float) =
  ## appends a float
  let ret = api.handle.mapSetFloat( vsmap.handle, 
                                    key.cstring, 
                                    data.cdouble, 
                                    maAppend.cint)
  if ret == 1:
    raise newException(ValueError, "trying to append a float to a property with the wrong type")

proc append*(vsmap:VSMapObj; key:string; data:VSNodeRef) =
  ## appends a node
  let ret = api.handle.mapSetNode( vsmap.handle, 
                                   key.cstring, 
                                   data.handle, 
                                   maAppend.cint)
  if ret == 1:
    raise newException(ValueError, "trying to append a node to a property with the wrong type")

proc set*(vsmap:VSMapRef; key:string; data:VSNodeRef) =
  ## appends a node
  let ret = api.handle.mapSetNode( vsmap.handle, 
                                   key.cstring, 
                                   data.handle, 
                                   maAppend.cint)
  if ret == 1:
    raise newException(ValueError, "trying to append a node to a property with the wrong type")

proc set*(m:VSMapRef; key:string; data:seq[VSNodeRef]) =
  ## appends a VSNodeRef sequence to a key
  for d in data:
    m.set(key, d)


# proc append*(vsmap:VSMapObj; key:string; data:VSFrameRef) =
#   ## appends am integer
#   let ret = api.handle.mapSetFrame(vsmap.handle, key.cstring, data.handle, maAppend.cint)
#   if ret == 1:
#     raise newException(ValueError, "trying to append a frame to a property with the wrong type")

proc set*(vsmap:VSMapRef; key:string; data:VSFrameRef) =
  ## appends am integer
  let ret = api.handle.mapSetFrame(vsmap.handle, key.cstring, data.handle, maAppend.cint)
  if ret == 1:
    raise newException(ValueError, "trying to append a frame to a property with the wrong type")


# proc append*(vsmap:VSMapObj; key:string, data:VSFunctionRef) =
#   ## appends am integer
#   let ret = api.handle.mapSetFunction( vsmap.handle, 
#                                        key.cstring, 
#                                        data.handle, 
#                                        maAppend.cint)
#   if ret == 1:
#     raise newException(ValueError, "trying to append a function to a property with the wrong type")

proc set*(vsmap:VSMapRef; key:string, data:VSFunctionRef) =
  ## appends am integer
  let ret = api.handle.mapSetFunction( vsmap.handle, 
                                       key.cstring, 
                                       data.handle, 
                                       maAppend.cint)
  if ret == 1:
    raise newException(ValueError, "trying to append a function to a property with the wrong type")

# proc append*(vsmap:VSMapObj; key:string; data:seq[int]) =
#   ## sets an integer sequence to a key
#   let p = cast[ptr int64](unsafeAddr(data[0]))
#   let ret = api.handle.mapSetIntArray( vsmap.handle, 
#                                        key.cstring, 
#                                        p, 
#                                        data.len.cint)
#   if ret == 1:
#     raise newException(ValueError, "trying to set an integer sequence to a property with the wrong type")

proc set*(vsmap:VSMapRef; key:string; data:seq[int]) =
  ## sets an integer sequence to a key
  let p = cast[ptr int64](unsafeAddr(data[0]))
  let ret = api.handle.mapSetIntArray( vsmap.handle, 
                                       key.cstring, 
                                       p, 
                                       data.len.cint)
  if ret == 1:
    raise newException(ValueError, "trying to set an integer sequence to a property with the wrong type")

# proc append*(vsmap:VSMapObj; key:string; data:seq[float]) =
#   ## sets an integer sequence to a key
#   let ret = api.handle.mapSetFloatArray( vsmap.handle, 
#                                          key.cstring, 
#                                          unsafeAddr(data[0]), 
#                                          data.len.cint)
#   if ret == 1:
#     raise newException(ValueError, "trying to set a float sequence to a property with the wrong type")

proc set*(vsmap:VSMapRef; key:string; data:seq[float]) =
  ## sets an integer sequence to a key
  let ret = api.handle.mapSetFloatArray( vsmap.handle, 
                                         key.cstring, 
                                         unsafeAddr(data[0]), 
                                         data.len.cint)
  if ret == 1:
    raise newException(ValueError, "trying to set a float sequence to a property with the wrong type")

#--- The following should be removed in the future

# proc set*(vsmap:VSMapRef; key:string, data:string, append:VSPropAppendMode) =
#   ## Appends/Replace/Touch a string to a particular key in a map.
#   let ret = API.propSetData(vsmap, key.cstring, data.cstring, data.len.cint, append.cint)
#   if ret == 1:
#     raise newException(ValueError, "trying to append to a property with the wrong type.")

