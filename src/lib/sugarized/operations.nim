import ../node/libvsnode
import ../vsmap/libvsmap
import ../../plugins4/std
import ../../wrapper/vapoursynth4
import std/[options]
import slicing
export slicing


proc gen_clips*(clips:seq[VSMapRef]):VSMapRef =
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
          result.set( "clips", clip.getNode(item.key,i) )
  #echo result
  #echo result

proc `+`*(clip1:sink VSMapRef, clip2:sink VSMapRef):VSMapRef =
  ## Adds two clips
  #echo clip1
  #echo clip2
  let tmp = @[clip1, clip2]
  # if clip1.handle == clip2.handle:
  #   echo clip1
  #   echo clip2
    #let c2 = clip1
    #tmp[1] = c2
    #discard
  let clips = gen_clips(tmp)
  return splice(clips, mismatch=0.some)


proc `**`*(clip:sink VSMapRef; n:int):VSMapRef =
  ## Adds two clips
  var tmp = newSeq[VSMapRef](n)
  for i in 0..<n:
    tmp[i] = clip
  let clips = gen_clips(tmp)
  splice(clips, mismatch=0.some)

proc `*`*(clip:sink VSMapRef; n:int):VSMapRef =
  ## Adds two clips
  #var tmp = newSeq[VSMapObj](n)
  var clips = newMap()
  for i in 0..<n:
    for item in clip.items:
      #echo item
      if item.typ == ptVideoNode:
        #echo clip
        for i in 0..<clip.len(item.key):
          clips.set( "clips", clip.getNode(item.key,i) )
  #let clips = gen_clips(tmp)
  splice(clips, mismatch=0.some)

proc `*`*(n:int, clip:sink VSMapRef):VSMapRef =
  clip * n

#SelectEvery
#Inverse
# -----------
converter toVsMap*(clips:seq[VSMapRef]):VSMapRef =
  gen_clips(clips)