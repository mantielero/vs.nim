#[
https://vapoursynth.com/doc/api/vapoursynth4.h.html#struct-vsmap

mapSetEmpty

mapGetIntSaturated

mapGetFloatSaturated

mapGetDataTypeHint

mapConsumeNode

mapConsumeFrame

mapConsumeFunction
]#
import ../wrapper/vapoursynth4
import libapi,libvsnode, libvsframe, libvsfunction
import std/[strformat]

type
  VSMapObj* = object
    handle*:ptr VSMap

proc newMap*():VSMapObj = 
  ## Creates a new property map. 
  result.handle = api.handle.createMap()


proc `=destroy`*(self: VSMapObj) =
  api.handle.freeMap(self.handle)

proc clearMap*(vsmap:VSMapObj) = 
  ## Deletes all the keys and their associated values from the map,
  ## leaving it empty.
  api.handle.clearMap(vsmap.handle)


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


proc len*(vsmap: VSMapObj):int = 
  ## Returns the number of keys contained in a property map.
  api.handle.mapNumKeys(vsmap.handle).int


template checkLimits(vsmap:VSMapObj; key:string; idx: int) =
  assert( idx >= 0, "`idx` shall be >= 0")
  assert( idx < vsmap.len, "`idx` shall be <" & $vsmap.len & " but got: " & $idx)



proc checkError(error:VSMapPropertyError; key:string; idx:int) =                                                                 
  case error
  of peIndex:
    raise newException(ValueError, "the index " & $idx & " is out of range")
  of peType:
    raise newException(ValueError, "the VSMap's key=" & key & " does not contain strings")
  else: # peUnset:
    discard 


proc propDeleteKey*(vsmap:VSMapObj; key:string) = 
  ## Removes the property with the given key. All values associated with the key are lost.
  ## Returns 0 if the key isn’t in the map. Otherwise it returns 1. 
  var ret = api.handle.mapDeleteKey(vsmap.handle, key.cstring).int
  if ret == 0:
    raise newException(ValueError, "the key '" & key & "' isn't in the maps")    


# Setting data
proc append*(vsmap:VSMapObj; key, data:string) =
  ## appends a string
  let ret = api.handle.mapSetData( vsmap.handle, 
                                   key.cstring, 
                                   data.cstring, 
                                   data.len.cint, 
                                   ptData.cint, 
                                   maAppend.cint )
  if ret == 1:
    raise newException(ValueError, "trying to append a string to a property with the wrong type")

proc append*(vsmap:VSMapObj; key:string; data:int) =
  ## appends an integer
  let ret = api.handle.mapSetInt( vsmap.handle, 
                                  key.cstring, 
                                  data.cint, 
                                  maAppend.cint )
  if ret == 1:
    raise newException(ValueError, "trying to append an integer to a property with the wrong type")  

proc append*(vsmap:VSMapObj; key:string; data:float) =
  ## appends a float
  let ret = api.handle.mapSetFloat( vsmap.handle, 
                                    key.cstring, 
                                    data.cdouble, 
                                    maAppend.cint)
  if ret == 1:
    raise newException(ValueError, "trying to append a float to a property with the wrong type")


proc append*(vsmap:VSMapObj; key:string; data:VSNodeObj) =
  ## appends a node
  let ret = api.handle.mapSetNode( vsmap.handle, 
                                   key.cstring, 
                                   data.handle, 
                                   maAppend.cint)
  if ret == 1:
    raise newException(ValueError, "trying to append a node to a property with the wrong type")


proc append*(vsmap:VSMapObj; key:string; data:VSFrameObj) =
  ## appends am integer
  let ret = api.handle.mapSetFrame(vsmap.handle, key.cstring, data.handle, maAppend.cint)
  if ret == 1:
    raise newException(ValueError, "trying to append a frame to a property with the wrong type")

proc append*(vsmap:VSMapObj; key:string, data:VSFunctionObj) =
  ## appends am integer
  let ret = api.handle.mapSetFunction( vsmap.handle, 
                                       key.cstring, 
                                       data.handle, 
                                       maAppend.cint)
  if ret == 1:
    raise newException(ValueError, "trying to append a function to a property with the wrong type")

proc append*(vsmap:VSMapObj; key:string; data:seq[int]) =
  ## sets an integer sequence to a key
  let p = cast[ptr int64](unsafeAddr(data[0]))
  let ret = api.handle.mapSetIntArray( vsmap.handle, 
                                       key.cstring, 
                                       p, 
                                       data.len.cint)
  if ret == 1:
    raise newException(ValueError, "trying to set an integer sequence to a property with the wrong type")

proc append*(vsmap:VSMapObj; key:string; data:seq[float]) =
  ## sets an integer sequence to a key
  let ret = api.handle.mapSetFloatArray( vsmap.handle, 
                                         key.cstring, 
                                         unsafeAddr(data[0]), 
                                         data.len.cint)
  if ret == 1:
    raise newException(ValueError, "trying to set a float sequence to a property with the wrong type")



#--- The following should be removed in the future
#[
proc propSetData*(vsmap:ptr VSMap, key:string, data:string, append:VSPropAppendMode) =
  ## Appends/Replace/Touch a string to a particular key in a map.
  let ret = API.propSetData(vsmap, key.cstring, data.cstring, data.len.cint, append.cint)
  if ret == 1:
    raise newException(ValueError, "trying to append to a property with the wrong type.")
]#




proc key*(vsmap:VSMapObj; idx:int):string = 
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




proc getType*(vsmap:VSMapObj; key:string):VSPropertyType = 
  ## Returns the type of the elements associated with the given key in a property map.
  ## The returned value is one of VSPropertyType. If there is no such key in the map, the returned value is ptUnset.
  api.handle.mapGetType(vsmap.handle, key.cstring).VSPropertyType


proc len*(vsmap:VSMapObj; key:string):int = 
  ## Returns the number of elements associated with a key in a property map. Returns -1 if there is no such key in the map.
  api.handle.mapNumElements(vsmap.handle, key).int



proc propGetData*(vsmap:VSMapObj; key:string; idx:int):string = 
  ## Given a `key` retrieves the string stored at position `idx` from a map.
  #checkLimits(vsmap, key.string, idx)

  var err = peUnset.cint
  var perr = cast[ptr cint](unsafeAddr(err))  
  result = $api.handle.mapGetData(vsmap.handle, key, idx.cint, perr)
  #checkError(err.VSMapPropertyError, key.string, idx)

proc propGetDataSize*(vsmap:VSMapObj; key:string; idx:int ):int = 
  ## Returns the size in bytes of a property of type ptData (see VSPropertyType), or 0 in case of error. The terminating NULL byte added by propSetData() is not counted.
  checkLimits(vsmap, key, idx)  
  var err = peUnset.cint
  var perr = cast[ptr cint](unsafeAddr(err))  
  result = api.handle.mapGetDataSize(vsmap.handle, key.cstring,idx.cint,perr).int
  checkError(err.VSMapPropertyError, key, idx)


proc propGetInt*(vsmap:VSMapObj; key:string; idx:int):int = 
  ## Given a `key` retrieves the integer value stored at position `idx` from a map.
  checkLimits(vsmap, key, idx)  
  var err = peUnset.cint
  var perr = cast[ptr cint](unsafeAddr(err))  
  result = api.handle.mapGetInt( vsmap.handle, 
                                 key.cstring, 
                                 idx.cint, 
                                 perr).int
  checkError(err.VSMapPropertyError, key, idx)


proc propGetFloat*(vsmap:VSMapObj; key:string; idx:int):float =
  ## Given a `key` retrieves the integer value stored at position `idx` from a map.
  checkLimits(vsmap, key, idx)  
  var err = peUnset.cint
  var perr = cast[ptr cint](unsafeAddr(err)) 
  result = api.handle.mapGetFloat( vsmap.handle, 
                            key.cstring, 
                            idx.cint, 
                            perr).float
  checkError(err.VSMapPropertyError, key, idx)


proc propGetIntArray*(vsmap:VSMapObj; key:string):seq[int] = 
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


proc propGetFloatArray*(vsmap:VSMapObj; key:string):seq[float] =
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


proc propGetNode*( vsmap:VSMapObj; key:string; idx:int):VSNodeObj =
  ## Retrieves a node from a map.
  checkLimits(vsmap, key, idx)
  var err = peUnset.cint
  var perr = cast[ptr cint](unsafeAddr(err))   
  result.handle = api.handle.mapGetNode(vsmap.handle, key.cstring, idx.cint, perr)  
  checkError(err.VSMapPropertyError, key, idx)

proc propGetFrame*( vsmap:VSMapObj; key:string; idx:int):VSFrameObj =
  ## Retrieves a frame from a map.
  checkLimits(vsmap, key, idx)   
  var err = peUnset.cint
  var perr = cast[ptr cint](unsafeAddr(err))  
  result.handle = api.handle.mapGetFrame(vsmap.handle, key.cstring, idx.cint, perr)
  checkError(err.VSMapPropertyError, key, idx)  

proc propGetFunc*( vsmap:VSMapObj; key:string; idx:int ):VSFunctionObj =
  ## Retrieves a function from a map.
  checkLimits(vsmap, key, idx)   
  var err = peUnset.cint
  var perr = cast[ptr cint](unsafeAddr(err))  
  result.handle = api.handle.mapGetFunction(vsmap.handle,key.cstring, idx.cint, perr)
  checkError(err.VSMapPropertyError, key, idx)


#------------------------------------------------



#[
# ===================================
#        Friendly API
# ===================================
]#

iterator keys*(vsmap:VSMapObj):string =
  for idx in 0..<vsmap.len:
    yield vsmap.key(idx)



type
  Item = tuple[key:string, typ:VSPropertyType, n,idx: int]
  #VSType = string | int | float | ptr VSNode | ptr VSFrame | VSFunction


iterator items*(vsmap:VSMapObj):Item =
  for idx in 0..<vsmap.len:
    let key = vsmap.key(idx)
    let typ = vsmap.getType(key)
    let n   = vsmap.len(key) 
    yield (key: key, typ: typ, n: n, idx:idx)

#[
proc len*(vsmap:ptr VSMap, item:Item):int =
  vsmap.len(item.key)


iterator items*(vsmap:ptr VSMap, item:Item):VSType = 
  # Iterate on the available items
  #result = newSeq[VSType]()
  for idx in 0..<vsmap.len(item):
    if item.`type` == ptData:
      yield vsmap.propGetData($item.key,idx)  

    elif item.`type` == ptInt:
      yield vsmap.propGetInt($item.key,idx)  

    elif item.`type` == ptFloat:
      yield vsmap.propGetFloat($item.key,idx)   

    elif item.`type` == ptNode:
      yield vsmap.propGetNode($item.key,idx)   

    elif item.`type` == ptFrame:
      yield vsmap.propGetFrame($item.key,idx)   

    elif item.`type` == ptFunction:
      yield vsmap.propGetFunc($item.key,idx)  



proc `$`*(prop:VSPropertyType):string = 
  case prop:
    of ptUnset:      "ptUnset"
    of ptInt:        "ptInt"
    of ptFloat:      "ptFloat"  
    of ptData:       "ptData"
    of ptFunction:   "ptFunction"
    of ptVideoNode:  "ptVideoNode"
    of ptAudioNode:  "ptAudioNode"  
    of ptVideoFrame: "ptVideoFrame"
    of ptAudioFrame: "ptAudioFrame"
    else:            "!!VSPropertyType Unknown"




      
#proc `[]`*(vsmap:ptr VSMap, item:Item):int  =
#  vsmap.len(item.key)

 




#[
proc get*(vsmap:ptr VSMap, idx:int):Map =  
  # This enables getting item at position `idx` from an vsmap
  let key = vsmap.key(idx)
  let t = vsmap.`type`( key)
  var val:Map
  val.key = key
  val.`type` = t
  let nElems = vsmap.len(key)
    
  if t == ptData:
    var elems:seq[string]
    for i in 0..<nElems:
      elems &= vsmap.propGetData(key,i)  
    val.data = elems

  elif t == ptInt:
    var elems:seq[int]
    for i in 0..<nElems:
      elems &= vsmap.propGetInt(key, i)  
    val.integers = elems  

  elif t == ptFloat:
    var elems:seq[float]
    for i in 0..<nElems:
      elems &= vsmap.propGetFloat(key,i)  
    val.floats = elems

  elif t == ptNode:
    var elems:seq[ptr VSNodeRef]
    for i in 0..<nElems:
      elems &= vsmap.propGetNode(key,i)  
    val.nodes = elems

  elif t == ptFrame:
    var elems:seq[ptr VSFrameRef]
    for i in 0..<nElems:
      elems &= vsmap.propGetFrame(key,i)  
    val.frames = elems

  elif t == ptFunction:
    var elems:seq[ptr VSFuncRef]
    for i in 0..<nElems:
      elems &= vsmap.propGetFunc(key,i)  
    val.functions = elems
  
  #elif t == ptUnset:
  #  continue

  return val
]#

#[
proc toSeq*(vsmap:ptr VSMap):seq[ Map ] =
  ## Reads from VSMap into a sequence.
  for idx in 0..<vsmap.len:
    result &= vsmap.get(idx)
]#






#[
proc `[]`*(vsmap:ptr VSMap, idx:int;clip:int=0):vsmap =
  ## Returns something
  # Check the that the first item in the vsmap is a Node type
  let key = key(vsmap, 0)
  let t = propGetType(vsmap, key)
  if t != ptNode:
    raise newException(ValueError, "slicing on vsmap only works for node")  

  # Get all nodes
  let nNodes = vsmap.len(key)

  if clip > nNodes -1:
     raise newException(ValueError, &"referring to clip number={clip} when there are only {nNodes}")

  # Load the nodes available in 
  var elems:seq[ptr VSNodeRef]
  for i in 0..<nElems:
    elems &= vsmap.propGetNode(key,i)  
  val.nodes = elems  
]#

#iterator span*(vsmap: ptr VSMap; first, last: Natural): char {.inline.} =
#  assert last < vsmap.len
#  var idx: int = first
#  while i <= last:
#    yield a[i]
#    inc(i)
#[
proc getClip(vsmap:ptr VSMap, clip:Natural):ptr VSMap =
  ## Retrieves one specific clip when there are many available
  let key = key(vsmap, 0)
  let t   = vsmap.`type`(key)
  assert t == ptNode
  #if t != ptNode:
  #  raise newException(ValueError, "slicing on vsmap only works for node") 
  # How many nodes?
  let nNodes = vsmap.len(key)
  assert clip < nNodes - 1

  var new = createMap()
  let node = vsmap.propGetNode(key,0) 
  new.append("clip", node)
  return new
]#

]#
proc getFirstNode*(vsmap:VSMapObj):VSNodeObj =
  ## Retrieves a node from a map.
  ## Returns a pointer to the node on success, or NULL in case of error.
  ## This function increases the node’s reference count, so freeNode() must be used when the node is no longer needed.
  ## If the map has an error set (i.e. if getError() returns non-NULL), VapourSynth will die with a fatal error.  
  let key = vsmap.key(0)
  assert( key == "clip", "expecting \"clip\" as first item in VSMap" )
  
  return vsmap.propGetNode("clip",0)


proc getFirstNodes*(vsmap:VSMapObj):seq[VSNodeObj] =
  ## Retrieves a node from a map.
  ## Returns a pointer to the node on success, or NULL in case of error.
  ## This function increases the node’s reference count, so freeNode() must be used when the node is no longer needed.
  ## If the map has an error set (i.e. if getError() returns non-NULL), VapourSynth will die with a fatal error.  
  let key = key(vsmap,0)
  assert( key == "clips", "expecting \"clip\" as first item in VSMap" )
  
  #var tmp:seq[ptr VSNode]
  for i in 0..<vsmap.len("clips"):
    result &= vsmap.propGetNode("clips",i)
  #return tmp

#[


proc checkContainsJustOneNode*(inClip:ptr VSMap) =
  #let tmpSeq = inClip.toSeq    # Convert the VSMap into a sequence
  assert( inClip.len > 0, "the vsmap should contain at least one item")
  assert( inClip.len("clip") > 0, "the vsmap should contain one node" )
]#

# ---- Pretty printing a VSMap ----
proc `$`*(m:VSMapObj):string =
  result = &"VSMap: {m.len} item(s)\n"
  for item in m.items():
    result &= &"  {item}\n"
    for i in 0..<item.n:
      case item.typ
      of ptint:
        result &= &"    value: {m.propGetInt(item.key, i)}\n"
      of ptfloat:
        result &= &"    value: {m.propGetFloat(item.key, i)}\n"
      of ptData:
        result &= &"    value: {m.propGetData(item.key, i)}\n"
      else:
        discard

