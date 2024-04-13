#[
https://vapoursynth.com/doc/api/vapoursynth4.h.html#struct-vsmap

]#
import ./[types, error, getters, setters, keys]
export types, error, getters, setters, keys
import ../../wrapper/vapoursynth4
import ../api/libapi
import ../node/libvsnode
# import ../frame/libvsframe
# import ../function/libvsfunction
import std/[strformat]


# proc newMap*():VSMapObj = 
#   ## Creates a new property map. 
#   result.handle = api.handle.createMap()

proc newMap*():VSMapRef = 
  ## Creates a new property map. 
  result = new VSMapRef
  result.handle = api.handle.createMap()

proc clearMap*(vsmap:VSMapObj) = 
  ## Deletes all the keys and their associated values from the map,
  ## leaving it empty.
  api.handle.clearMap(vsmap.handle)

proc copyMap*(src: VSMapObj; dst: var VSMapObj)  =
  api.handle.copyMap( src.handle, dst.handle )


#[
# ===================================
#        Friendly API
# ===================================
]#



type
  Item = tuple[key:string, typ:VSPropertyType, n,idx: int]
  #VSType = string | int | float | ptr VSNode | ptr VSFrame | VSFunction


iterator items*(vsmap:VSMapRef):Item =
  for idx in 0..<vsmap.len:
    let key = vsmap.key(idx)
    let typ = vsmap.getType(key)
    let n   = vsmap.len(key) 
    yield (key: key, typ: typ, n: n, idx:idx)

#[

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
proc getFirstNode*(vsmap:VSMapRef):VSNodeRef =
  ## Retrieves a node from a map.
  ## Returns a pointer to the node on success, or NULL in case of error.
  ## This function increases the node’s reference count, so freeNode() must be used when the node is no longer needed.
  ## If the map has an error set (i.e. if getError() returns non-NULL), VapourSynth will die with a fatal error.  
  let key = vsmap.key(0)        # ex:: "clip"
  let typ = vsmap.getType(key)  # ex.: "ptvideonode"
  let n   = vsmap.len(key)      # ex.: 1
  #var tmp = vsmap.propGetNode(key,0)
  #echo tmp
  #assert ( (typ == ptvideonode or typ == ptaudionode), "expecting a video or audio node" )
  #assert( key == "clip", "expecting \"clip\" as first item in VSMap" )
  return vsmap.getNode(key,0) # First item of the given key


proc getFirstNodes*(vsmap:VSMapRef):seq[VSNodeRef] =
  ## Retrieves a node from a map.
  ## Returns a pointer to the node on success, or NULL in case of error.
  ## This function increases the node’s reference count, so freeNode() must be used when the node is no longer needed.
  ## If the map has an error set (i.e. if getError() returns non-NULL), VapourSynth will die with a fatal error.  
  let key = key(vsmap,0)  # Get the first key

  assert( key == "clips", "expecting \"clip\" as first item in VSMap" )
  
  #var tmp:seq[ptr VSNode]
  for i in 0..<vsmap.len("clips"):
    result &= vsmap.getNode("clips",i)
  #return tmp

#[


proc checkContainsJustOneNode*(inClip:ptr VSMap) =
  #let tmpSeq = inClip.toSeq    # Convert the VSMap into a sequence
  assert( inClip.len > 0, "the vsmap should contain at least one item")
  assert( inClip.len("clip") > 0, "the vsmap should contain one node" )
]#

# ---- Pretty printing a VSMap ----
proc `$`*[T:VSMapRef|VSMapObj](m:T):string =
  if m.handle == nil:
    return "NIL"
  result = &"VSMap: {m.len} item(s)\n"
  for item in m.items():
    result &= &"  {item}\n"
    for i in 0..<item.n:
      case item.typ
      of ptint:
        result &= &"    value: {m.getInt(item.key, i)}\n"
      of ptfloat:
        result &= &"    value: {m.getFloat(item.key, i)}\n"
      of ptData:
        result &= &"    value: {m.getData(item.key, i)}\n"
      else:
        discard

