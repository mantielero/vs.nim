import ../node/libvsnode
import ../vsmap/libvsmap
import ../../plugins4/std
import ../../wrapper/vapoursynth4
import std/[options]

let last* = -1  # This is just an identifier to specify the last frame 




proc `[]`*(vsmap:sink VSMapRef;hs:HSlice):VSMapRef =  #;clip:Natural=0
  ## vsmap[1..3] (returns a clip -vsmap- including only those frames)
  ## Only works on one clip
  let key = vsmap.key(0)
  assert key == "clip"
  let t   = vsmap.getType(key)
  assert t == ptVideoNode      # TODO: to make it work with audio too

  # How many nodes?
  let nNodes = vsmap.len(key)
  assert nNodes == 1

  # Make it work with `last` identifier
  var i = hs.a
  var j = hs.b
  # Get number of frames
  let node = vsmap.getNode("clip",0)
  let numFrames = node.getVideoInfo.numFrames
  if i < 0:
    i = numFrames + i
  if j < 0:
    j = numFrames + j

  var inverse = false
  if j < i: 
    (i,j) = (j,i)
    inverse = true

  result = vsmap.trim(some(i),some(j))
  if inverse:
    result = result.reverse

proc `[]`*(vsmap:VSMapRef; hs:HSlice; n:int):VSMapRef = 
  if n < 1:
    raise newException(ValueError, &"n={n} should be bigger than 1")

  vsmap[hs].selectEvery(n, @[0])