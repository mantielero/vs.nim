import options
import ../lib/[libvsmap,libvsnode,libvsframe,libvsfunction,libvsplugins, libapi, libvsanode]

proc addBorders*(vsmap:VSMapObj;
                 left= none(int);
                 right= none(int);
                 top= none(int);
                 bottom= none(int);
                 color= none(seq[float])):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  args.append("clip", clip)
  if left.isSome: args.append("left", left.get)
  if right.isSome: args.append("right", right.get)
  if top.isSome: args.append("top", top.get)
  if bottom.isSome: args.append("bottom", bottom.get)
  if color.isSome:
    for item in color.get:
      args.append("color", item)

  result.handle = api.handle.invoke(plug.handle, "AddBorders".cstring, args.handle)
  #API.freeMap(args)


proc assumeFPS*(vsmap:VSMapObj;
                src= none(VSNodeObj);
                fpsnum= none(int);
                fpsden= none(int)):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  args.append("clip", clip)
  if src.isSome: args.append("src", src.get)
  if fpsnum.isSome: args.append("fpsnum", fpsnum.get)
  if fpsden.isSome: args.append("fpsden", fpsden.get)

  result.handle = api.handle.invoke(plug.handle, "AssumeFPS".cstring, args.handle)
  #API.freeMap(args)

#[
proc assumeSampleRate*(vsmap:VSMapObj;
                       src= none(VSAudioNodeObj);
                       samplerate= none(int)):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")

  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  args.append("clip", clip)
  if src.isSome: args.append("src", src.get)
  if samplerate.isSome: args.append("samplerate", samplerate.get)

  result.handle = api.handle.invoke(plug.handle, "AssumeSampleRate".cstring, args.handle)
  #API.freeMap(args)


proc audioGain*(vsmap:VSMapObj;
                gain= none(seq[float]);
                overflow_error= none(int)):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")

  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  args.append("clip", clip)
  if gain.isSome:
    for item in gain.get:
      args.append("gain", item)
  if overflow_error.isSome: args.append("overflow_error", overflow_error.get)

  result.handle = api.handle.invoke(plug.handle, "AudioGain".cstring, args.handle)
  #API.freeMap(args)


proc audioLoop*(vsmap:VSMapObj;
                times= none(int)):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")

  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  args.append("clip", clip)
  if times.isSome: args.append("times", times.get)

  result.handle = api.handle.invoke(plug.handle, "AudioLoop".cstring, args.handle)
  #API.freeMap(args)


proc audioMix*(vsmap:VSMapObj;
               matrix:seq[float];
               channels_out:seq[int];
               overflow_error= none(int)):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")

  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  for item in clips:
    args.append("clips", item)
  for item in matrix:
    args.append("matrix", item)
  for item in channels_out:
    args.append("channels_out", item)
  if overflow_error.isSome: args.append("overflow_error", overflow_error.get)

  result.handle = api.handle.invoke(plug.handle, "AudioMix".cstring, args.handle)
  #API.freeMap(args)


proc audioReverse*(vsmap:VSMapObj):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")

  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()


  result.handle = api.handle.invoke(plug.handle, "AudioReverse".cstring, args.handle)
  #API.freeMap(args)


proc audioSplice*(vsmap:VSMapObj):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")

  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()


  result.handle = api.handle.invoke(plug.handle, "AudioSplice".cstring, args.handle)
  #API.freeMap(args)


proc audioTrim*(vsmap:VSMapObj;
                first= none(int);
                last= none(int);
                length= none(int)):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")

  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  args.append("clip", clip)
  if first.isSome: args.append("first", first.get)
  if last.isSome: args.append("last", last.get)
  if length.isSome: args.append("length", length.get)

  result.handle = api.handle.invoke(plug.handle, "AudioTrim".cstring, args.handle)
  #API.freeMap(args)

]#
proc averageFrames*(vsmap:VSMapObj;
                    weights:seq[float];
                    scale= none(float);
                    scenechange= none(int);
                    planes= none(seq[int])):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clips") >= 1, "the vsmap should contain a seq with nodes")
  var clips = getFirstNodes(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  for item in clips:
    args.append("clips", item)
  for item in weights:
    args.append("weights", item)
  if scale.isSome: args.append("scale", scale.get)
  if scenechange.isSome: args.append("scenechange", scenechange.get)
  if planes.isSome:
    for item in planes.get:
      args.append("planes", item)

  result.handle = api.handle.invoke(plug.handle, "AverageFrames".cstring, args.handle)
  #API.freeMap(args)


proc binarize*(vsmap:VSMapObj;
               threshold= none(seq[float]);
               v0= none(seq[float]);
               v1= none(seq[float]);
               planes= none(seq[int])):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  args.append("clip", clip)
  if threshold.isSome:
    for item in threshold.get:
      args.append("threshold", item)
  if v0.isSome:
    for item in v0.get:
      args.append("v0", item)
  if v1.isSome:
    for item in v1.get:
      args.append("v1", item)
  if planes.isSome:
    for item in planes.get:
      args.append("planes", item)

  result.handle = api.handle.invoke(plug.handle, "Binarize".cstring, args.handle)
  #API.freeMap(args)


proc binarizeMask*(vsmap:VSMapObj;
                   threshold= none(seq[float]);
                   v0= none(seq[float]);
                   v1= none(seq[float]);
                   planes= none(seq[int])):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  args.append("clip", clip)
  if threshold.isSome:
    for item in threshold.get:
      args.append("threshold", item)
  if v0.isSome:
    for item in v0.get:
      args.append("v0", item)
  if v1.isSome:
    for item in v1.get:
      args.append("v1", item)
  if planes.isSome:
    for item in planes.get:
      args.append("planes", item)

  result.handle = api.handle.invoke(plug.handle, "BinarizeMask".cstring, args.handle)
  #API.freeMap(args)

#[
proc blankAudio*(vsmap= none(VSMapObj);
                 channels= none(seq[int]);
                 bits= none(int);
                 sampletype= none(int);
                 samplerate= none(int);
                 length= none(int);
                 keep= none(int)):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  if vsmap.isSome:
    assert( vsmap.get.len != 0, "the vsmap should contain at least one item")

  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  if clip.isSome: args.append("clip", clip.get)
  if channels.isSome:
    for item in channels.get:
      args.append("channels", item)
  if bits.isSome: args.append("bits", bits.get)
  if sampletype.isSome: args.append("sampletype", sampletype.get)
  if samplerate.isSome: args.append("samplerate", samplerate.get)
  if length.isSome: args.append("length", length.get)
  if keep.isSome: args.append("keep", keep.get)

  result.handle = api.handle.invoke(plug.handle, "BlankAudio".cstring, args.handle)
  #API.freeMap(args)


proc blankClip*(vsmap= none(VSMapObj);
                width= none(int);
                height= none(int);
                format= none(int);
                length= none(int);
                fpsnum= none(int);
                fpsden= none(int);
                color= none(seq[float]);
                keep= none(int);
                varsize= none(int);
                varformat= none(int)):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  if vsmap.isSome:
    assert( vsmap.get.len != 0, "the vsmap should contain at least one item")
    assert( vsmap.get.len("vnode") == 1, "the vsmap should contain one node")
  var clip:VSNodeObj
  if vsmap.isSome:
    clip = getFirstNode(vsmap.get)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  if clip.isSome: args.append("clip", clip.get)
  if width.isSome: args.append("width", width.get)
  if height.isSome: args.append("height", height.get)
  if format.isSome: args.append("format", format.get)
  if length.isSome: args.append("length", length.get)
  if fpsnum.isSome: args.append("fpsnum", fpsnum.get)
  if fpsden.isSome: args.append("fpsden", fpsden.get)
  if color.isSome:
    for item in color.get:
      args.append("color", item)
  if keep.isSome: args.append("keep", keep.get)
  if varsize.isSome: args.append("varsize", varsize.get)
  if varformat.isSome: args.append("varformat", varformat.get)

  result.handle = api.handle.invoke(plug.handle, "BlankClip".cstring, args.handle)
  #API.freeMap(args)

]#
proc boxBlur*(vsmap:VSMapObj;
              planes= none(seq[int]);
              hradius= none(int);
              hpasses= none(int);
              vradius= none(int);
              vpasses= none(int)):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  args.append("clip", clip)
  if planes.isSome:
    for item in planes.get:
      args.append("planes", item)
  if hradius.isSome: args.append("hradius", hradius.get)
  if hpasses.isSome: args.append("hpasses", hpasses.get)
  if vradius.isSome: args.append("vradius", vradius.get)
  if vpasses.isSome: args.append("vpasses", vpasses.get)

  result.handle = api.handle.invoke(plug.handle, "BoxBlur".cstring, args.handle)
  #API.freeMap(args)


proc cache*(vsmap:VSMapObj;
            size= none(int);
            fixed= none(int);
            make_linear= none(int)):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  args.append("clip", clip)
  if size.isSome: args.append("size", size.get)
  if fixed.isSome: args.append("fixed", fixed.get)
  if make_linear.isSome: args.append("make_linear", make_linear.get)

  result.handle = api.handle.invoke(plug.handle, "Cache".cstring, args.handle)
  #API.freeMap(args)


proc clipToProp*(vsmap:VSMapObj;
                 mclip:VSNodeObj;
                 prop= none(string)):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  args.append("clip", clip)
  args.append("mclip", mclip)
  if prop.isSome: args.append("prop", prop.get)

  result.handle = api.handle.invoke(plug.handle, "ClipToProp".cstring, args.handle)
  #API.freeMap(args)


proc convolution*(vsmap:VSMapObj;
                  matrix:seq[float];
                  bias= none(float);
                  divisor= none(float);
                  planes= none(seq[int]);
                  saturate= none(int);
                  mode= none(string)):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  args.append("clip", clip)
  for item in matrix:
    args.append("matrix", item)
  if bias.isSome: args.append("bias", bias.get)
  if divisor.isSome: args.append("divisor", divisor.get)
  if planes.isSome:
    for item in planes.get:
      args.append("planes", item)
  if saturate.isSome: args.append("saturate", saturate.get)
  if mode.isSome: args.append("mode", mode.get)

  result.handle = api.handle.invoke(plug.handle, "Convolution".cstring, args.handle)
  #API.freeMap(args)


proc copyFrameProps*(vsmap:VSMapObj;
                     prop_src:VSNodeObj;
                     props= none(seq[string])):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  args.append("clip", clip)
  args.append("prop_src", prop_src)
  if props.isSome:
    for item in props.get:
      args.append("props", item)

  result.handle = api.handle.invoke(plug.handle, "CopyFrameProps".cstring, args.handle)
  #API.freeMap(args)


proc crop*(vsmap:VSMapObj;
           left= none(int);
           right= none(int);
           top= none(int);
           bottom= none(int)):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  args.append("clip", clip)
  if left.isSome: args.append("left", left.get)
  if right.isSome: args.append("right", right.get)
  if top.isSome: args.append("top", top.get)
  if bottom.isSome: args.append("bottom", bottom.get)

  result.handle = api.handle.invoke(plug.handle, "Crop".cstring, args.handle)
  #API.freeMap(args)


proc cropAbs*(vsmap:VSMapObj;
              width:int;
              height:int;
              left= none(int);
              top= none(int);
              x= none(int);
              y= none(int)):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  args.append("clip", clip)
  args.append("width", width)
  args.append("height", height)
  if left.isSome: args.append("left", left.get)
  if top.isSome: args.append("top", top.get)
  if x.isSome: args.append("x", x.get)
  if y.isSome: args.append("y", y.get)

  result.handle = api.handle.invoke(plug.handle, "CropAbs".cstring, args.handle)
  #API.freeMap(args)


proc cropRel*(vsmap:VSMapObj;
              left= none(int);
              right= none(int);
              top= none(int);
              bottom= none(int)):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  args.append("clip", clip)
  if left.isSome: args.append("left", left.get)
  if right.isSome: args.append("right", right.get)
  if top.isSome: args.append("top", top.get)
  if bottom.isSome: args.append("bottom", bottom.get)

  result.handle = api.handle.invoke(plug.handle, "CropRel".cstring, args.handle)
  #API.freeMap(args)


proc deflate*(vsmap:VSMapObj;
              planes= none(seq[int]);
              threshold= none(float)):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  args.append("clip", clip)
  if planes.isSome:
    for item in planes.get:
      args.append("planes", item)
  if threshold.isSome: args.append("threshold", threshold.get)

  result.handle = api.handle.invoke(plug.handle, "Deflate".cstring, args.handle)
  #API.freeMap(args)


proc deleteFrames*(vsmap:VSMapObj;
                   frames:seq[int]):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  args.append("clip", clip)
  for item in frames:
    args.append("frames", item)

  result.handle = api.handle.invoke(plug.handle, "DeleteFrames".cstring, args.handle)
  #API.freeMap(args)


proc doubleWeave*(vsmap:VSMapObj;
                  tff= none(int)):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  args.append("clip", clip)
  if tff.isSome: args.append("tff", tff.get)

  result.handle = api.handle.invoke(plug.handle, "DoubleWeave".cstring, args.handle)
  #API.freeMap(args)


proc duplicateFrames*(vsmap:VSMapObj;
                      frames:seq[int]):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  args.append("clip", clip)
  for item in frames:
    args.append("frames", item)

  result.handle = api.handle.invoke(plug.handle, "DuplicateFrames".cstring, args.handle)
  #API.freeMap(args)


proc expr*(vsmap:VSMapObj;
           expr:seq[string];
           format= none(int)):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clips") >= 1, "the vsmap should contain a seq with nodes")
  var clips = getFirstNodes(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  for item in clips:
    args.append("clips", item)
  for item in expr:
    args.append("expr", item)
  if format.isSome: args.append("format", format.get)

  result.handle = api.handle.invoke(plug.handle, "Expr".cstring, args.handle)
  #API.freeMap(args)


proc flipHorizontal*(vsmap:VSMapObj):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()


  result.handle = api.handle.invoke(plug.handle, "FlipHorizontal".cstring, args.handle)
  #API.freeMap(args)


proc flipVertical*(vsmap:VSMapObj):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()


  result.handle = api.handle.invoke(plug.handle, "FlipVertical".cstring, args.handle)
  #API.freeMap(args)

#[
proc frameEval*(vsmap:VSMapObj;
                eval:VSFuncRefObj;
                prop_src= none(seq[VSNodeObj]);
                clip_src= none(seq[VSNodeObj])):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  args.append("clip", clip)
  args.append("eval", eval)
  if prop_src.isSome:
    for item in prop_src.get:
      args.append("prop_src", item)
  if clip_src.isSome:
    for item in clip_src.get:
      args.append("clip_src", item)

  result.handle = api.handle.invoke(plug.handle, "FrameEval".cstring, args.handle)
  #API.freeMap(args)
]#

proc freezeFrames*(vsmap:VSMapObj;
                   first= none(seq[int]);
                   last= none(seq[int]);
                   replacement= none(seq[int])):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  args.append("clip", clip)
  if first.isSome:
    for item in first.get:
      args.append("first", item)
  if last.isSome:
    for item in last.get:
      args.append("last", item)
  if replacement.isSome:
    for item in replacement.get:
      args.append("replacement", item)

  result.handle = api.handle.invoke(plug.handle, "FreezeFrames".cstring, args.handle)
  #API.freeMap(args)


proc inflate*(vsmap:VSMapObj;
              planes= none(seq[int]);
              threshold= none(float)):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  args.append("clip", clip)
  if planes.isSome:
    for item in planes.get:
      args.append("planes", item)
  if threshold.isSome: args.append("threshold", threshold.get)

  result.handle = api.handle.invoke(plug.handle, "Inflate".cstring, args.handle)
  #API.freeMap(args)


proc interleave*(vsmap:VSMapObj;
                 extend= none(int);
                 mismatch= none(int);
                 modify_duration= none(int)):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clips") >= 1, "the vsmap should contain a seq with nodes")
  var clips = getFirstNodes(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  for item in clips:
    args.append("clips", item)
  if extend.isSome: args.append("extend", extend.get)
  if mismatch.isSome: args.append("mismatch", mismatch.get)
  if modify_duration.isSome: args.append("modify_duration", modify_duration.get)

  result.handle = api.handle.invoke(plug.handle, "Interleave".cstring, args.handle)
  #API.freeMap(args)


proc invert*(vsmap:VSMapObj;
             planes= none(seq[int])):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  args.append("clip", clip)
  if planes.isSome:
    for item in planes.get:
      args.append("planes", item)

  result.handle = api.handle.invoke(plug.handle, "Invert".cstring, args.handle)
  #API.freeMap(args)


proc invertMask*(vsmap:VSMapObj;
                 planes= none(seq[int])):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  args.append("clip", clip)
  if planes.isSome:
    for item in planes.get:
      args.append("planes", item)

  result.handle = api.handle.invoke(plug.handle, "InvertMask".cstring, args.handle)
  #API.freeMap(args)


proc levels*(vsmap:VSMapObj;
             min_in= none(seq[float]);
             max_in= none(seq[float]);
             gamma= none(seq[float]);
             min_out= none(seq[float]);
             max_out= none(seq[float]);
             planes= none(seq[int])):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  args.append("clip", clip)
  if min_in.isSome:
    for item in min_in.get:
      args.append("min_in", item)
  if max_in.isSome:
    for item in max_in.get:
      args.append("max_in", item)
  if gamma.isSome:
    for item in gamma.get:
      args.append("gamma", item)
  if min_out.isSome:
    for item in min_out.get:
      args.append("min_out", item)
  if max_out.isSome:
    for item in max_out.get:
      args.append("max_out", item)
  if planes.isSome:
    for item in planes.get:
      args.append("planes", item)

  result.handle = api.handle.invoke(plug.handle, "Levels".cstring, args.handle)
  #API.freeMap(args)


proc limiter*(vsmap:VSMapObj;
              min= none(seq[float]);
              max= none(seq[float]);
              planes= none(seq[int])):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  args.append("clip", clip)
  if min.isSome:
    for item in min.get:
      args.append("min", item)
  if max.isSome:
    for item in max.get:
      args.append("max", item)
  if planes.isSome:
    for item in planes.get:
      args.append("planes", item)

  result.handle = api.handle.invoke(plug.handle, "Limiter".cstring, args.handle)
  #API.freeMap(args)


proc loadAllPlugins*(path:string):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 

  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()


  result.handle = api.handle.invoke(plug.handle, "LoadAllPlugins".cstring, args.handle)
  #API.freeMap(args)


proc loadPlugin*(path:string;
                 altsearchpath= none(int);
                 forcens= none(string);
                 forceid= none(string)):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 

  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  args.append("path", path)
  if altsearchpath.isSome: args.append("altsearchpath", altsearchpath.get)
  if forcens.isSome: args.append("forcens", forcens.get)
  if forceid.isSome: args.append("forceid", forceid.get)

  result.handle = api.handle.invoke(plug.handle, "LoadPlugin".cstring, args.handle)
  #API.freeMap(args)


proc loop*(vsmap:VSMapObj;
           times= none(int)):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  args.append("clip", clip)
  if times.isSome: args.append("times", times.get)

  result.handle = api.handle.invoke(plug.handle, "Loop".cstring, args.handle)
  #API.freeMap(args)

#[
proc lut*(vsmap:VSMapObj;
          planes= none(seq[int]);
          lut= none(seq[int]);
          lutf= none(seq[float]);
          function= none(VSFuncRefObj);
          bits= none(int);
          floatout= none(int)):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  args.append("clip", clip)
  if planes.isSome:
    for item in planes.get:
      args.append("planes", item)
  if lut.isSome:
    for item in lut.get:
      args.append("lut", item)
  if lutf.isSome:
    for item in lutf.get:
      args.append("lutf", item)
  if function.isSome: args.append("function", function.get)
  if bits.isSome: args.append("bits", bits.get)
  if floatout.isSome: args.append("floatout", floatout.get)

  result.handle = api.handle.invoke(plug.handle, "Lut".cstring, args.handle)
  #API.freeMap(args)
]#
#[
proc lut2*(vsmap:VSMapObj;
           clipb:VSNodeObj;
           planes= none(seq[int]);
           lut= none(seq[int]);
           lutf= none(seq[float]);
           function= none(VSFuncRefObj);
           bits= none(int);
           floatout= none(int)):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clipa = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  args.append("clipa", clipa)
  args.append("clipb", clipb)
  if planes.isSome:
    for item in planes.get:
      args.append("planes", item)
  if lut.isSome:
    for item in lut.get:
      args.append("lut", item)
  if lutf.isSome:
    for item in lutf.get:
      args.append("lutf", item)
  if function.isSome: args.append("function", function.get)
  if bits.isSome: args.append("bits", bits.get)
  if floatout.isSome: args.append("floatout", floatout.get)

  result.handle = api.handle.invoke(plug.handle, "Lut2".cstring, args.handle)
  #API.freeMap(args)
]#

proc makeDiff*(vsmap:VSMapObj;
               clipb:VSNodeObj;
               planes= none(seq[int])):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clipa = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  args.append("clipa", clipa)
  args.append("clipb", clipb)
  if planes.isSome:
    for item in planes.get:
      args.append("planes", item)

  result.handle = api.handle.invoke(plug.handle, "MakeDiff".cstring, args.handle)
  #API.freeMap(args)


proc makeFullDiff*(vsmap:VSMapObj;
                   clipb:VSNodeObj):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clipa = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  args.append("clipa", clipa)
  args.append("clipb", clipb)

  result.handle = api.handle.invoke(plug.handle, "MakeFullDiff".cstring, args.handle)
  #API.freeMap(args)


proc maskedMerge*(vsmap:VSMapObj;
                  clipb:VSNodeObj;
                  mask:VSNodeObj;
                  planes= none(seq[int]);
                  first_plane= none(int);
                  premultiplied= none(int)):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clipa = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  args.append("clipa", clipa)
  args.append("clipb", clipb)
  args.append("mask", mask)
  if planes.isSome:
    for item in planes.get:
      args.append("planes", item)
  if first_plane.isSome: args.append("first_plane", first_plane.get)
  if premultiplied.isSome: args.append("premultiplied", premultiplied.get)

  result.handle = api.handle.invoke(plug.handle, "MaskedMerge".cstring, args.handle)
  #API.freeMap(args)


proc maximum*(vsmap:VSMapObj;
              planes= none(seq[int]);
              threshold= none(float);
              coordinates= none(seq[int])):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  args.append("clip", clip)
  if planes.isSome:
    for item in planes.get:
      args.append("planes", item)
  if threshold.isSome: args.append("threshold", threshold.get)
  if coordinates.isSome:
    for item in coordinates.get:
      args.append("coordinates", item)

  result.handle = api.handle.invoke(plug.handle, "Maximum".cstring, args.handle)
  #API.freeMap(args)


proc median*(vsmap:VSMapObj;
             planes= none(seq[int])):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  args.append("clip", clip)
  if planes.isSome:
    for item in planes.get:
      args.append("planes", item)

  result.handle = api.handle.invoke(plug.handle, "Median".cstring, args.handle)
  #API.freeMap(args)


proc merge*(vsmap:VSMapObj;
            clipb:VSNodeObj;
            weight= none(seq[float])):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clipa = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  args.append("clipa", clipa)
  args.append("clipb", clipb)
  if weight.isSome:
    for item in weight.get:
      args.append("weight", item)

  result.handle = api.handle.invoke(plug.handle, "Merge".cstring, args.handle)
  #API.freeMap(args)


proc mergeDiff*(vsmap:VSMapObj;
                clipb:VSNodeObj;
                planes= none(seq[int])):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clipa = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  args.append("clipa", clipa)
  args.append("clipb", clipb)
  if planes.isSome:
    for item in planes.get:
      args.append("planes", item)

  result.handle = api.handle.invoke(plug.handle, "MergeDiff".cstring, args.handle)
  #API.freeMap(args)


proc mergeFullDiff*(vsmap:VSMapObj;
                    clipb:VSNodeObj):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clipa = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  args.append("clipa", clipa)
  args.append("clipb", clipb)

  result.handle = api.handle.invoke(plug.handle, "MergeFullDiff".cstring, args.handle)
  #API.freeMap(args)

#[
proc minimum*(vsmap:VSMapObj;
              planes= none(seq[int]);
              threshold= none(float);
              coordinates= none(seq[int])):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  args.append("clip", clip)
  if planes.isSome:
    for item in planes.get:
      args.append("planes", item)
  if threshold.isSome: args.append("threshold", threshold.get)
  if coordinates.isSome:
    for item in coordinates.get:
      args.append("coordinates", item)

  result.handle = api.handle.invoke(plug.handle, "Minimum".cstring, args.handle)
  #API.freeMap(args)


proc modifyFrame*(vsmap:VSMapObj;
                  clips:seq[VSNodeObj];
                  selector:VSFuncRefObj):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  args.append("clip", clip)
  for item in clips:
    args.append("clips", item)
  args.append("selector", selector)

  result.handle = api.handle.invoke(plug.handle, "ModifyFrame".cstring, args.handle)
  #API.freeMap(args)

]#
proc pEMVerifier*(vsmap:VSMapObj;
                  upper= none(seq[float]);
                  lower= none(seq[float])):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  args.append("clip", clip)
  if upper.isSome:
    for item in upper.get:
      args.append("upper", item)
  if lower.isSome:
    for item in lower.get:
      args.append("lower", item)

  result.handle = api.handle.invoke(plug.handle, "PEMVerifier".cstring, args.handle)
  #API.freeMap(args)


proc planeStats*(vsmap:VSMapObj;
                 clipb= none(VSNodeObj);
                 plane= none(int);
                 prop= none(string)):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clipa = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  args.append("clipa", clipa)
  if clipb.isSome: args.append("clipb", clipb.get)
  if plane.isSome: args.append("plane", plane.get)
  if prop.isSome: args.append("prop", prop.get)

  result.handle = api.handle.invoke(plug.handle, "PlaneStats".cstring, args.handle)
  #API.freeMap(args)


proc preMultiply*(vsmap:VSMapObj;
                  alpha:VSNodeObj):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  args.append("clip", clip)
  args.append("alpha", alpha)

  result.handle = api.handle.invoke(plug.handle, "PreMultiply".cstring, args.handle)
  #API.freeMap(args)


proc prewitt*(vsmap:VSMapObj;
              planes= none(seq[int]);
              scale= none(float)):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  args.append("clip", clip)
  if planes.isSome:
    for item in planes.get:
      args.append("planes", item)
  if scale.isSome: args.append("scale", scale.get)

  result.handle = api.handle.invoke(plug.handle, "Prewitt".cstring, args.handle)
  #API.freeMap(args)


proc propToClip*(vsmap:VSMapObj;
                 prop= none(string)):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  args.append("clip", clip)
  if prop.isSome: args.append("prop", prop.get)

  result.handle = api.handle.invoke(plug.handle, "PropToClip".cstring, args.handle)
  #API.freeMap(args)


proc removeFrameProps*(vsmap:VSMapObj;
                       props= none(seq[string])):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  args.append("clip", clip)
  if props.isSome:
    for item in props.get:
      args.append("props", item)

  result.handle = api.handle.invoke(plug.handle, "RemoveFrameProps".cstring, args.handle)
  #API.freeMap(args)


proc reverse*(vsmap:VSMapObj):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()


  result.handle = api.handle.invoke(plug.handle, "Reverse".cstring, args.handle)
  #API.freeMap(args)


proc selectEvery*(vsmap:VSMapObj;
                  cycle:int;
                  offsets:seq[int];
                  modify_duration= none(int)):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  args.append("clip", clip)
  args.append("cycle", cycle)
  for item in offsets:
    args.append("offsets", item)
  if modify_duration.isSome: args.append("modify_duration", modify_duration.get)

  result.handle = api.handle.invoke(plug.handle, "SelectEvery".cstring, args.handle)
  #API.freeMap(args)


proc separateFields*(vsmap:VSMapObj;
                     tff= none(int);
                     modify_duration= none(int)):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  args.append("clip", clip)
  if tff.isSome: args.append("tff", tff.get)
  if modify_duration.isSome: args.append("modify_duration", modify_duration.get)

  result.handle = api.handle.invoke(plug.handle, "SeparateFields".cstring, args.handle)
  #API.freeMap(args)

#[
proc setAudioCache*(vsmap:VSMapObj;
                    mode= none(int);
                    fixedsize= none(int);
                    maxsize= none(int);
                    maxhistory= none(int)):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")

  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  args.append("clip", clip)
  if mode.isSome: args.append("mode", mode.get)
  if fixedsize.isSome: args.append("fixedsize", fixedsize.get)
  if maxsize.isSome: args.append("maxsize", maxsize.get)
  if maxhistory.isSome: args.append("maxhistory", maxhistory.get)

  result.handle = api.handle.invoke(plug.handle, "SetAudioCache".cstring, args.handle)
  #API.freeMap(args)

]#
proc setFieldBased*(vsmap:VSMapObj;
                    value:int):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  args.append("clip", clip)
  args.append("value", value)

  result.handle = api.handle.invoke(plug.handle, "SetFieldBased".cstring, args.handle)
  #API.freeMap(args)


proc setFrameProp*(vsmap:VSMapObj;
                   prop:string;
                   intval= none(seq[int]);
                   floatval= none(seq[float]);
                   data= none(seq[string])):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  args.append("clip", clip)
  args.append("prop", prop)
  if intval.isSome:
    for item in intval.get:
      args.append("intval", item)
  if floatval.isSome:
    for item in floatval.get:
      args.append("floatval", item)
  if data.isSome:
    for item in data.get:
      args.append("data", item)

  result.handle = api.handle.invoke(plug.handle, "SetFrameProp".cstring, args.handle)
  #API.freeMap(args)


proc setFrameProps*(vsmap:VSMapObj;
                    any:any):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  args.append("clip", clip)
  args.append("any", any)

  result.handle = api.handle.invoke(plug.handle, "SetFrameProps".cstring, args.handle)
  #API.freeMap(args)


proc setMaxCPU*(cpu:string):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 

  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()


  result.handle = api.handle.invoke(plug.handle, "SetMaxCPU".cstring, args.handle)
  #API.freeMap(args)


proc setVideoCache*(vsmap:VSMapObj;
                    mode= none(int);
                    fixedsize= none(int);
                    maxsize= none(int);
                    maxhistory= none(int)):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  args.append("clip", clip)
  if mode.isSome: args.append("mode", mode.get)
  if fixedsize.isSome: args.append("fixedsize", fixedsize.get)
  if maxsize.isSome: args.append("maxsize", maxsize.get)
  if maxhistory.isSome: args.append("maxhistory", maxhistory.get)

  result.handle = api.handle.invoke(plug.handle, "SetVideoCache".cstring, args.handle)
  #API.freeMap(args)

#[
proc shuffleChannels*(vsmap:VSMapObj;
                      channels_in:seq[int];
                      channels_out:seq[int]):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")

  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  for item in clips:
    args.append("clips", item)
  for item in channels_in:
    args.append("channels_in", item)
  for item in channels_out:
    args.append("channels_out", item)

  result.handle = api.handle.invoke(plug.handle, "ShuffleChannels".cstring, args.handle)
  #API.freeMap(args)
]#

proc shufflePlanes*(vsmap:VSMapObj;
                    planes:seq[int];
                    colorfamily:int;
                    prop_src= none(VSNodeObj)):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clips") >= 1, "the vsmap should contain a seq with nodes")
  var clips = getFirstNodes(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  for item in clips:
    args.append("clips", item)
  for item in planes:
    args.append("planes", item)
  args.append("colorfamily", colorfamily)
  if prop_src.isSome: args.append("prop_src", prop_src.get)

  result.handle = api.handle.invoke(plug.handle, "ShufflePlanes".cstring, args.handle)
  #API.freeMap(args)


proc sobel*(vsmap:VSMapObj;
            planes= none(seq[int]);
            scale= none(float)):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  args.append("clip", clip)
  if planes.isSome:
    for item in planes.get:
      args.append("planes", item)
  if scale.isSome: args.append("scale", scale.get)

  result.handle = api.handle.invoke(plug.handle, "Sobel".cstring, args.handle)
  #API.freeMap(args)


proc splice*(vsmap:VSMapObj;
             mismatch= none(int)):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clips") >= 1, "the vsmap should contain a seq with nodes")
  var clips = getFirstNodes(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  for item in clips:
    args.append("clips", item)
  if mismatch.isSome: args.append("mismatch", mismatch.get)

  result.handle = api.handle.invoke(plug.handle, "Splice".cstring, args.handle)
  #API.freeMap(args)


proc splitChannels*(vsmap:VSMapObj):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")

  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()


  result.handle = api.handle.invoke(plug.handle, "SplitChannels".cstring, args.handle)
  #API.freeMap(args)


proc splitPlanes*(vsmap:VSMapObj):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()


  result.handle = api.handle.invoke(plug.handle, "SplitPlanes".cstring, args.handle)
  #API.freeMap(args)


proc stackHorizontal*(vsmap:VSMapObj):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clips") >= 1, "the vsmap should contain a seq with nodes")
  var clips = getFirstNodes(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()


  result.handle = api.handle.invoke(plug.handle, "StackHorizontal".cstring, args.handle)
  #API.freeMap(args)


proc stackVertical*(vsmap:VSMapObj):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clips") >= 1, "the vsmap should contain a seq with nodes")
  var clips = getFirstNodes(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()


  result.handle = api.handle.invoke(plug.handle, "StackVertical".cstring, args.handle)
  #API.freeMap(args)


proc testAudio*(channels= none(seq[int]);
                bits= none(int);
                isfloat= none(int);
                samplerate= none(int);
                length= none(int)):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 

  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  if channels.isSome:
    for item in channels.get:
      args.append("channels", item)
  if bits.isSome: args.append("bits", bits.get)
  if isfloat.isSome: args.append("isfloat", isfloat.get)
  if samplerate.isSome: args.append("samplerate", samplerate.get)
  if length.isSome: args.append("length", length.get)

  result.handle = api.handle.invoke(plug.handle, "TestAudio".cstring, args.handle)
  #API.freeMap(args)


proc transpose*(vsmap:VSMapObj):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()


  result.handle = api.handle.invoke(plug.handle, "Transpose".cstring, args.handle)
  #API.freeMap(args)


proc trim*(vsmap:VSMapObj;
           first= none(int);
           last= none(int);
           length= none(int)):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  args.append("clip", clip)
  if first.isSome: args.append("first", first.get)
  if last.isSome: args.append("last", last.get)
  if length.isSome: args.append("length", length.get)

  result.handle = api.handle.invoke(plug.handle, "Trim".cstring, args.handle)
  #API.freeMap(args)


proc turn180*(vsmap:VSMapObj):VSMapObj =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()


  result.handle = api.handle.invoke(plug.handle, "Turn180".cstring, args.handle)
  #API.freeMap(args)


