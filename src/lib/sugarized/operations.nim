import ../[libvsmap, libvsnode]
import ../../plugins4/std
import ../../wrapper/vapoursynth4
import std/[options]

let last* = -1  # This is just an identifier to specify the last frame 




proc `[]`*(vsmap:VSMapObj;hs:HSlice):VSMapObj =  #;clip:Natural=0
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
  let node = vsmap.propGetNode("clip",0)
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

proc `[]`*(vsmap:VSMapObj; hs:HSlice; n:int):VSMapObj = 
  if n < 1:
    raise newException(ValueError, &"n={n} should be bigger than 1")

  vsmap[hs].selectEvery(n, @[0])

proc gen_clips*(clips:seq[VSMapObj]):VSMapObj =
  ## Puts the nodes from a sequence of VSMaps just into one (as needed by Splice)
  #var nodes:seq[VSNodeObj]
  result = newMap()
  #echo clips
  for clip in clips: # these are VSMap
    #echo clip
    for item in clip.items:
      #echo item
      if item.typ == ptVideoNode:
        #echo clip
        for i in 0..<clip.len(item.key):
          result.append( "clips", clip.propGetNode(item.key,i) )
  #echo result

proc `+`*(clip1:VSMapObj, clip2:VSMapObj):VSMapObj =
  ## Adds two clips
  #echo clip1
  #echo clip2
  var tmp = @[clip1, clip2]
  if clip1.handle == clip2.handle:
    echo clip1
    echo clip2
    let c2 = clip1
    tmp[1] = c2
    #discard
  let clips = gen_clips(tmp)
  splice(clips, mismatch=0.some)


proc `*`*(clip:VSMapObj, n:int):VSMapObj =
  ## Adds two clips
  var tmp = newSeq[VSMapObj](n)
  for i in 0..<n:
    tmp[i] = clip
  let clips = gen_clips(tmp)
  splice(clips, mismatch=0.some)

proc `*`*(n:int, clip:VSMapObj):VSMapObj =
  clip * n

#SelectEvery
#Inverse