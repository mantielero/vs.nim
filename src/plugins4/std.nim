import options
import ../lib/vsmap/libvsmap
import ../lib/node/libvsnode
import ../lib/frame/libvsframe
import ../lib/function/libvsfunction
import ../lib/plugin/libvsplugins
import ../lib/api/libapi

proc addBorders*(vsmap:VSMapRef;
                 left= none(int);
                 right= none(int);
                 top= none(int);
                 bottom= none(int);
                 color= none(seq[float])):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clip", clip)
  if left.isSome: args.set("left", left.get)
  if right.isSome: args.set("right", right.get)
  if top.isSome: args.set("top", top.get)
  if bottom.isSome: args.set("bottom", bottom.get)
  if color.isSome: args.set("color", color.get)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "AddBorders".cstring, args.handle)


proc assumeFPS*(vsmap:VSMapRef;
                src= none(VSNodeRef);
                fpsnum= none(int);
                fpsden= none(int)):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clip", clip)
  if src.isSome: args.set("src", src.get)
  if fpsnum.isSome: args.set("fpsnum", fpsnum.get)
  if fpsden.isSome: args.set("fpsden", fpsden.get)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "AssumeFPS".cstring, args.handle)


proc assumeSampleRate*(vsmap:VSMapRef;
                       src= none(VSNodeRef);
                       samplerate= none(int)):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clip", clip)
  if src.isSome: args.set("src", src.get)
  if samplerate.isSome: args.set("samplerate", samplerate.get)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "AssumeSampleRate".cstring, args.handle)


proc audioGain*(vsmap:VSMapRef;
                gain= none(seq[float]);
                overflow_error= none(int)):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clip", clip)
  if gain.isSome: args.set("gain", gain.get)
  if overflow_error.isSome: args.set("overflow_error", overflow_error.get)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "AudioGain".cstring, args.handle)


proc audioLoop*(vsmap:VSMapRef;
                times= none(int)):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clip", clip)
  if times.isSome: args.set("times", times.get)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "AudioLoop".cstring, args.handle)


proc audioMix*(vsmap:VSMapRef;
               matrix:seq[float];
               channels_out:seq[int];
               overflow_error= none(int)):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clips") >= 1, "the vsmap should contain a seq with nodes")
  var clips = getFirstNodes(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  for item in clips:
    args.set("clips", item)

  args.set("matrix", matrix)
  args.set("channels_out", channels_out)
  if overflow_error.isSome: args.set("overflow_error", overflow_error.get)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "AudioMix".cstring, args.handle)


proc audioReverse*(vsmap:VSMapRef):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clip", clip)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "AudioReverse".cstring, args.handle)


proc audioSplice*(vsmap:VSMapRef):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clips") >= 1, "the vsmap should contain a seq with nodes")
  var clips = getFirstNodes(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  for item in clips:
    args.set("clips", item)


  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "AudioSplice".cstring, args.handle)


proc audioTrim*(vsmap:VSMapRef;
                first= none(int);
                last= none(int);
                length= none(int)):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clip", clip)
  if first.isSome: args.set("first", first.get)
  if last.isSome: args.set("last", last.get)
  if length.isSome: args.set("length", length.get)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "AudioTrim".cstring, args.handle)


proc averageFrames*(vsmap:VSMapRef;
                    weights:seq[float];
                    scale= none(float);
                    scenechange= none(int);
                    planes= none(seq[int])):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clips") >= 1, "the vsmap should contain a seq with nodes")
  var clips = getFirstNodes(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  for item in clips:
    args.set("clips", item)

  args.set("weights", weights)
  if scale.isSome: args.set("scale", scale.get)
  if scenechange.isSome: args.set("scenechange", scenechange.get)
  if planes.isSome: args.set("planes", planes.get)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "AverageFrames".cstring, args.handle)


proc binarize*(vsmap:VSMapRef;
               threshold= none(seq[float]);
               v0= none(seq[float]);
               v1= none(seq[float]);
               planes= none(seq[int])):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clip", clip)
  if threshold.isSome: args.set("threshold", threshold.get)
  if v0.isSome: args.set("v0", v0.get)
  if v1.isSome: args.set("v1", v1.get)
  if planes.isSome: args.set("planes", planes.get)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "Binarize".cstring, args.handle)


proc binarizeMask*(vsmap:VSMapRef;
                   threshold= none(seq[float]);
                   v0= none(seq[float]);
                   v1= none(seq[float]);
                   planes= none(seq[int])):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clip", clip)
  if threshold.isSome: args.set("threshold", threshold.get)
  if v0.isSome: args.set("v0", v0.get)
  if v1.isSome: args.set("v1", v1.get)
  if planes.isSome: args.set("planes", planes.get)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "BinarizeMask".cstring, args.handle)


proc blankAudio*(vsmap= none(VSMapRef);
                 channels= none(seq[int]);
                 bits= none(int);
                 sampletype= none(int);
                 samplerate= none(int);
                 length= none(int);
                 keep= none(int)):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  if vsmap.isSome:
    assert( vsmap.get.len != 0, "the vsmap should contain at least one item")
    assert( vsmap.get.len("clip") == 1, "the vsmap should contain one node")
  var clip:Option[VSNodeRef]
  if vsmap.isSome:
    clip = getFirstNode(vsmap.get).some


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  if vsmap.isSome:
    args.set("clip", clip.get)
  if channels.isSome: args.set("channels", channels.get)
  if bits.isSome: args.set("bits", bits.get)
  if sampletype.isSome: args.set("sampletype", sampletype.get)
  if samplerate.isSome: args.set("samplerate", samplerate.get)
  if length.isSome: args.set("length", length.get)
  if keep.isSome: args.set("keep", keep.get)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "BlankAudio".cstring, args.handle)


proc blankClip*(vsmap= none(VSMapRef);
                width= none(int);
                height= none(int);
                format= none(int);
                length= none(int);
                fpsnum= none(int);
                fpsden= none(int);
                color= none(seq[float]);
                keep= none(int);
                varsize= none(int);
                varformat= none(int)):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  if vsmap.isSome:
    assert( vsmap.get.len != 0, "the vsmap should contain at least one item")
    assert( vsmap.get.len("clip") == 1, "the vsmap should contain one node")
  var clip:Option[VSNodeRef]
  if vsmap.isSome:
    clip = getFirstNode(vsmap.get).some


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  if vsmap.isSome:
    args.set("clip", clip.get)
  if width.isSome: args.set("width", width.get)
  if height.isSome: args.set("height", height.get)
  if format.isSome: args.set("format", format.get)
  if length.isSome: args.set("length", length.get)
  if fpsnum.isSome: args.set("fpsnum", fpsnum.get)
  if fpsden.isSome: args.set("fpsden", fpsden.get)
  if color.isSome: args.set("color", color.get)
  if keep.isSome: args.set("keep", keep.get)
  if varsize.isSome: args.set("varsize", varsize.get)
  if varformat.isSome: args.set("varformat", varformat.get)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "BlankClip".cstring, args.handle)


proc boxBlur*(vsmap:VSMapRef;
              planes= none(seq[int]);
              hradius= none(int);
              hpasses= none(int);
              vradius= none(int);
              vpasses= none(int)):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clip", clip)
  if planes.isSome: args.set("planes", planes.get)
  if hradius.isSome: args.set("hradius", hradius.get)
  if hpasses.isSome: args.set("hpasses", hpasses.get)
  if vradius.isSome: args.set("vradius", vradius.get)
  if vpasses.isSome: args.set("vpasses", vpasses.get)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "BoxBlur".cstring, args.handle)


proc cache*(vsmap:VSMapRef;
            size= none(int);
            fixed= none(int);
            make_linear= none(int)):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clip", clip)
  if size.isSome: args.set("size", size.get)
  if fixed.isSome: args.set("fixed", fixed.get)
  if make_linear.isSome: args.set("make_linear", make_linear.get)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "Cache".cstring, args.handle)


proc clipToProp*(vsmap:VSMapRef;
                 mclip:VSNodeRef;
                 prop= none(string)):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clip", clip)
  args.set("mclip", mclip)
  if prop.isSome: args.set("prop", prop.get)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "ClipToProp".cstring, args.handle)


proc convolution*(vsmap:VSMapRef;
                  matrix:seq[float];
                  bias= none(float);
                  divisor= none(float);
                  planes= none(seq[int]);
                  saturate= none(int);
                  mode= none(string)):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clip", clip)
  args.set("matrix", matrix)
  if bias.isSome: args.set("bias", bias.get)
  if divisor.isSome: args.set("divisor", divisor.get)
  if planes.isSome: args.set("planes", planes.get)
  if saturate.isSome: args.set("saturate", saturate.get)
  if mode.isSome: args.set("mode", mode.get)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "Convolution".cstring, args.handle)


proc copyFrameProps*(vsmap:VSMapRef;
                     prop_src:VSNodeRef;
                     props= none(seq[string])):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clip", clip)
  args.set("prop_src", prop_src)
  if props.isSome: args.set("props", props.get)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "CopyFrameProps".cstring, args.handle)


proc crop*(vsmap:VSMapRef;
           left= none(int);
           right= none(int);
           top= none(int);
           bottom= none(int)):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clip", clip)
  if left.isSome: args.set("left", left.get)
  if right.isSome: args.set("right", right.get)
  if top.isSome: args.set("top", top.get)
  if bottom.isSome: args.set("bottom", bottom.get)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "Crop".cstring, args.handle)


proc cropAbs*(vsmap:VSMapRef;
              width:int;
              height:int;
              left= none(int);
              top= none(int);
              x= none(int);
              y= none(int)):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clip", clip)
  args.set("width", width)
  args.set("height", height)
  if left.isSome: args.set("left", left.get)
  if top.isSome: args.set("top", top.get)
  if x.isSome: args.set("x", x.get)
  if y.isSome: args.set("y", y.get)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "CropAbs".cstring, args.handle)


proc cropRel*(vsmap:VSMapRef;
              left= none(int);
              right= none(int);
              top= none(int);
              bottom= none(int)):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clip", clip)
  if left.isSome: args.set("left", left.get)
  if right.isSome: args.set("right", right.get)
  if top.isSome: args.set("top", top.get)
  if bottom.isSome: args.set("bottom", bottom.get)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "CropRel".cstring, args.handle)


proc deflate*(vsmap:VSMapRef;
              planes= none(seq[int]);
              threshold= none(float)):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clip", clip)
  if planes.isSome: args.set("planes", planes.get)
  if threshold.isSome: args.set("threshold", threshold.get)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "Deflate".cstring, args.handle)


proc deleteFrames*(vsmap:VSMapRef;
                   frames:seq[int]):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clip", clip)
  args.set("frames", frames)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "DeleteFrames".cstring, args.handle)


proc doubleWeave*(vsmap:VSMapRef;
                  tff= none(int)):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clip", clip)
  if tff.isSome: args.set("tff", tff.get)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "DoubleWeave".cstring, args.handle)


proc duplicateFrames*(vsmap:VSMapRef;
                      frames:seq[int]):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clip", clip)
  args.set("frames", frames)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "DuplicateFrames".cstring, args.handle)


proc expr*(vsmap:VSMapRef;
           expr:seq[string];
           format= none(int)):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clips") >= 1, "the vsmap should contain a seq with nodes")
  var clips = getFirstNodes(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  for item in clips:
    args.set("clips", item)

  args.set("expr", expr)
  if format.isSome: args.set("format", format.get)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "Expr".cstring, args.handle)


proc flipHorizontal*(vsmap:VSMapRef):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clip", clip)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "FlipHorizontal".cstring, args.handle)


proc flipVertical*(vsmap:VSMapRef):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clip", clip)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "FlipVertical".cstring, args.handle)


proc frameEval*(vsmap:VSMapRef;
                eval:VSFunctionRef;
                prop_src= none(seq[VSNodeRef]);
                clip_src= none(seq[VSNodeRef])):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clip", clip)
  args.set("eval", eval)
  if prop_src.isSome: args.set("prop_src", prop_src.get)
  if clip_src.isSome: args.set("clip_src", clip_src.get)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "FrameEval".cstring, args.handle)


proc freezeFrames*(vsmap:VSMapRef;
                   first= none(seq[int]);
                   last= none(seq[int]);
                   replacement= none(seq[int])):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clip", clip)
  if first.isSome: args.set("first", first.get)
  if last.isSome: args.set("last", last.get)
  if replacement.isSome: args.set("replacement", replacement.get)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "FreezeFrames".cstring, args.handle)


proc inflate*(vsmap:VSMapRef;
              planes= none(seq[int]);
              threshold= none(float)):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clip", clip)
  if planes.isSome: args.set("planes", planes.get)
  if threshold.isSome: args.set("threshold", threshold.get)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "Inflate".cstring, args.handle)


proc interleave*(vsmap:VSMapRef;
                 extend= none(int);
                 mismatch= none(int);
                 modify_duration= none(int)):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clips") >= 1, "the vsmap should contain a seq with nodes")
  var clips = getFirstNodes(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  for item in clips:
    args.set("clips", item)

  if extend.isSome: args.set("extend", extend.get)
  if mismatch.isSome: args.set("mismatch", mismatch.get)
  if modify_duration.isSome: args.set("modify_duration", modify_duration.get)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "Interleave".cstring, args.handle)


proc invert*(vsmap:VSMapRef;
             planes= none(seq[int])):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clip", clip)
  if planes.isSome: args.set("planes", planes.get)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "Invert".cstring, args.handle)


proc invertMask*(vsmap:VSMapRef;
                 planes= none(seq[int])):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clip", clip)
  if planes.isSome: args.set("planes", planes.get)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "InvertMask".cstring, args.handle)


proc levels*(vsmap:VSMapRef;
             min_in= none(seq[float]);
             max_in= none(seq[float]);
             gamma= none(seq[float]);
             min_out= none(seq[float]);
             max_out= none(seq[float]);
             planes= none(seq[int])):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clip", clip)
  if min_in.isSome: args.set("min_in", min_in.get)
  if max_in.isSome: args.set("max_in", max_in.get)
  if gamma.isSome: args.set("gamma", gamma.get)
  if min_out.isSome: args.set("min_out", min_out.get)
  if max_out.isSome: args.set("max_out", max_out.get)
  if planes.isSome: args.set("planes", planes.get)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "Levels".cstring, args.handle)


proc limiter*(vsmap:VSMapRef;
              min= none(seq[float]);
              max= none(seq[float]);
              planes= none(seq[int])):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clip", clip)
  if min.isSome: args.set("min", min.get)
  if max.isSome: args.set("max", max.get)
  if planes.isSome: args.set("planes", planes.get)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "Limiter".cstring, args.handle)


proc loadAllPlugins*(path:string):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 

  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()


  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "LoadAllPlugins".cstring, args.handle)


proc loadPlugin*(path:string;
                 altsearchpath= none(int);
                 forcens= none(string);
                 forceid= none(string)):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 

  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  args.set("path", path)
  if altsearchpath.isSome: args.set("altsearchpath", altsearchpath.get)
  if forcens.isSome: args.set("forcens", forcens.get)
  if forceid.isSome: args.set("forceid", forceid.get)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "LoadPlugin".cstring, args.handle)


proc loop*(vsmap:VSMapRef;
           times= none(int)):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clip", clip)
  if times.isSome: args.set("times", times.get)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "Loop".cstring, args.handle)


proc lut*(vsmap:VSMapRef;
          planes= none(seq[int]);
          lut= none(seq[int]);
          lutf= none(seq[float]);
          function= none(VSFunctionRef);
          bits= none(int);
          floatout= none(int)):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clip", clip)
  if planes.isSome: args.set("planes", planes.get)
  if lut.isSome: args.set("lut", lut.get)
  if lutf.isSome: args.set("lutf", lutf.get)
  if function.isSome: args.set("function", function.get)
  if bits.isSome: args.set("bits", bits.get)
  if floatout.isSome: args.set("floatout", floatout.get)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "Lut".cstring, args.handle)


proc lut2*(vsmap:VSMapRef;
           clipb:VSNodeRef;
           planes= none(seq[int]);
           lut= none(seq[int]);
           lutf= none(seq[float]);
           function= none(VSFunctionRef);
           bits= none(int);
           floatout= none(int)):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clipa = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clipa", clipa)
  args.set("clipb", clipb)
  if planes.isSome: args.set("planes", planes.get)
  if lut.isSome: args.set("lut", lut.get)
  if lutf.isSome: args.set("lutf", lutf.get)
  if function.isSome: args.set("function", function.get)
  if bits.isSome: args.set("bits", bits.get)
  if floatout.isSome: args.set("floatout", floatout.get)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "Lut2".cstring, args.handle)


proc makeDiff*(vsmap:VSMapRef;
               clipb:VSNodeRef;
               planes= none(seq[int])):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clipa = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clipa", clipa)
  args.set("clipb", clipb)
  if planes.isSome: args.set("planes", planes.get)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "MakeDiff".cstring, args.handle)


proc makeFullDiff*(vsmap:VSMapRef;
                   clipb:VSNodeRef):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clipa = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clipa", clipa)
  args.set("clipb", clipb)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "MakeFullDiff".cstring, args.handle)


proc maskedMerge*(vsmap:VSMapRef;
                  clipb:VSNodeRef;
                  mask:VSNodeRef;
                  planes= none(seq[int]);
                  first_plane= none(int);
                  premultiplied= none(int)):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clipa = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clipa", clipa)
  args.set("clipb", clipb)
  args.set("mask", mask)
  if planes.isSome: args.set("planes", planes.get)
  if first_plane.isSome: args.set("first_plane", first_plane.get)
  if premultiplied.isSome: args.set("premultiplied", premultiplied.get)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "MaskedMerge".cstring, args.handle)


proc maximum*(vsmap:VSMapRef;
              planes= none(seq[int]);
              threshold= none(float);
              coordinates= none(seq[int])):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clip", clip)
  if planes.isSome: args.set("planes", planes.get)
  if threshold.isSome: args.set("threshold", threshold.get)
  if coordinates.isSome: args.set("coordinates", coordinates.get)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "Maximum".cstring, args.handle)


proc median*(vsmap:VSMapRef;
             planes= none(seq[int])):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clip", clip)
  if planes.isSome: args.set("planes", planes.get)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "Median".cstring, args.handle)


proc merge*(vsmap:VSMapRef;
            clipb:VSNodeRef;
            weight= none(seq[float])):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clipa = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clipa", clipa)
  args.set("clipb", clipb)
  if weight.isSome: args.set("weight", weight.get)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "Merge".cstring, args.handle)


proc mergeDiff*(vsmap:VSMapRef;
                clipb:VSNodeRef;
                planes= none(seq[int])):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clipa = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clipa", clipa)
  args.set("clipb", clipb)
  if planes.isSome: args.set("planes", planes.get)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "MergeDiff".cstring, args.handle)


proc mergeFullDiff*(vsmap:VSMapRef;
                    clipb:VSNodeRef):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clipa = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clipa", clipa)
  args.set("clipb", clipb)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "MergeFullDiff".cstring, args.handle)


proc minimum*(vsmap:VSMapRef;
              planes= none(seq[int]);
              threshold= none(float);
              coordinates= none(seq[int])):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clip", clip)
  if planes.isSome: args.set("planes", planes.get)
  if threshold.isSome: args.set("threshold", threshold.get)
  if coordinates.isSome: args.set("coordinates", coordinates.get)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "Minimum".cstring, args.handle)


proc modifyFrame*(vsmap:VSMapRef;
                  clips:seq[VSNodeRef];
                  selector:VSFunctionRef):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clip", clip)
  args.set("clips", clips)
  args.set("selector", selector)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "ModifyFrame".cstring, args.handle)


proc pEMVerifier*(vsmap:VSMapRef;
                  upper= none(seq[float]);
                  lower= none(seq[float])):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clip", clip)
  if upper.isSome: args.set("upper", upper.get)
  if lower.isSome: args.set("lower", lower.get)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "PEMVerifier".cstring, args.handle)


proc planeStats*(vsmap:VSMapRef;
                 clipb= none(VSNodeRef);
                 plane= none(int);
                 prop= none(string)):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clipa = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clipa", clipa)
  if clipb.isSome: args.set("clipb", clipb.get)
  if plane.isSome: args.set("plane", plane.get)
  if prop.isSome: args.set("prop", prop.get)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "PlaneStats".cstring, args.handle)


proc preMultiply*(vsmap:VSMapRef;
                  alpha:VSNodeRef):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clip", clip)
  args.set("alpha", alpha)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "PreMultiply".cstring, args.handle)


proc prewitt*(vsmap:VSMapRef;
              planes= none(seq[int]);
              scale= none(float)):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clip", clip)
  if planes.isSome: args.set("planes", planes.get)
  if scale.isSome: args.set("scale", scale.get)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "Prewitt".cstring, args.handle)


proc propToClip*(vsmap:VSMapRef;
                 prop= none(string)):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clip", clip)
  if prop.isSome: args.set("prop", prop.get)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "PropToClip".cstring, args.handle)


proc removeFrameProps*(vsmap:VSMapRef;
                       props= none(seq[string])):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clip", clip)
  if props.isSome: args.set("props", props.get)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "RemoveFrameProps".cstring, args.handle)


proc reverse*(vsmap:VSMapRef):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clip", clip)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "Reverse".cstring, args.handle)


proc selectEvery*(vsmap:VSMapRef;
                  cycle:int;
                  offsets:seq[int];
                  modify_duration= none(int)):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clip", clip)
  args.set("cycle", cycle)
  args.set("offsets", offsets)
  if modify_duration.isSome: args.set("modify_duration", modify_duration.get)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "SelectEvery".cstring, args.handle)


proc separateFields*(vsmap:VSMapRef;
                     tff= none(int);
                     modify_duration= none(int)):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clip", clip)
  if tff.isSome: args.set("tff", tff.get)
  if modify_duration.isSome: args.set("modify_duration", modify_duration.get)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "SeparateFields".cstring, args.handle)


proc setAudioCache*(vsmap:VSMapRef;
                    mode= none(int);
                    fixedsize= none(int);
                    maxsize= none(int);
                    maxhistory= none(int)):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clip", clip)
  if mode.isSome: args.set("mode", mode.get)
  if fixedsize.isSome: args.set("fixedsize", fixedsize.get)
  if maxsize.isSome: args.set("maxsize", maxsize.get)
  if maxhistory.isSome: args.set("maxhistory", maxhistory.get)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "SetAudioCache".cstring, args.handle)


proc setFieldBased*(vsmap:VSMapRef;
                    value:int):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clip", clip)
  args.set("value", value)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "SetFieldBased".cstring, args.handle)


proc setFrameProp*(vsmap:VSMapRef;
                   prop:string;
                   intval= none(seq[int]);
                   floatval= none(seq[float]);
                   data= none(seq[string])):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clip", clip)
  args.set("prop", prop)
  if intval.isSome: args.set("intval", intval.get)
  if floatval.isSome: args.set("floatval", floatval.get)
  if data.isSome: args.set("data", data.get)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "SetFrameProp".cstring, args.handle)


proc setFrameProps*(vsmap:VSMapRef;
                    any:any):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clip", clip)
  args.set("any", any)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "SetFrameProps".cstring, args.handle)


proc setMaxCPU*(cpu:string):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 

  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()


  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "SetMaxCPU".cstring, args.handle)


proc setVideoCache*(vsmap:VSMapRef;
                    mode= none(int);
                    fixedsize= none(int);
                    maxsize= none(int);
                    maxhistory= none(int)):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clip", clip)
  if mode.isSome: args.set("mode", mode.get)
  if fixedsize.isSome: args.set("fixedsize", fixedsize.get)
  if maxsize.isSome: args.set("maxsize", maxsize.get)
  if maxhistory.isSome: args.set("maxhistory", maxhistory.get)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "SetVideoCache".cstring, args.handle)


proc shuffleChannels*(vsmap:VSMapRef;
                      channels_in:seq[int];
                      channels_out:seq[int]):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clips") >= 1, "the vsmap should contain a seq with nodes")
  var clips = getFirstNodes(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  for item in clips:
    args.set("clips", item)

  args.set("channels_in", channels_in)
  args.set("channels_out", channels_out)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "ShuffleChannels".cstring, args.handle)


proc shufflePlanes*(vsmap:VSMapRef;
                    planes:seq[int];
                    colorfamily:int;
                    prop_src= none(VSNodeRef)):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clips") >= 1, "the vsmap should contain a seq with nodes")
  var clips = getFirstNodes(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  for item in clips:
    args.set("clips", item)

  args.set("planes", planes)
  args.set("colorfamily", colorfamily)
  if prop_src.isSome: args.set("prop_src", prop_src.get)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "ShufflePlanes".cstring, args.handle)


proc sobel*(vsmap:VSMapRef;
            planes= none(seq[int]);
            scale= none(float)):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clip", clip)
  if planes.isSome: args.set("planes", planes.get)
  if scale.isSome: args.set("scale", scale.get)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "Sobel".cstring, args.handle)


proc splice*(vsmap:VSMapRef;
             mismatch= none(int)):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clips") >= 1, "the vsmap should contain a seq with nodes")
  var clips = getFirstNodes(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  for item in clips:
    args.set("clips", item)

  if mismatch.isSome: args.set("mismatch", mismatch.get)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "Splice".cstring, args.handle)


proc splitChannels*(vsmap:VSMapRef):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clip", clip)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "SplitChannels".cstring, args.handle)


proc splitPlanes*(vsmap:VSMapRef):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clip", clip)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "SplitPlanes".cstring, args.handle)


proc stackHorizontal*(vsmap:VSMapRef):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clips") >= 1, "the vsmap should contain a seq with nodes")
  var clips = getFirstNodes(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  for item in clips:
    args.set("clips", item)


  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "StackHorizontal".cstring, args.handle)


proc stackVertical*(vsmap:VSMapRef):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clips") >= 1, "the vsmap should contain a seq with nodes")
  var clips = getFirstNodes(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  for item in clips:
    args.set("clips", item)


  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "StackVertical".cstring, args.handle)


proc testAudio*(channels= none(seq[int]);
                bits= none(int);
                isfloat= none(int);
                samplerate= none(int);
                length= none(int)):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 

  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  if channels.isSome: args.set("channels", channels.get)
  if bits.isSome: args.set("bits", bits.get)
  if isfloat.isSome: args.set("isfloat", isfloat.get)
  if samplerate.isSome: args.set("samplerate", samplerate.get)
  if length.isSome: args.set("length", length.get)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "TestAudio".cstring, args.handle)


proc transpose*(vsmap:VSMapRef):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clip", clip)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "Transpose".cstring, args.handle)


proc trim*(vsmap:VSMapRef;
           first= none(int);
           last= none(int);
           length= none(int)):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clip", clip)
  if first.isSome: args.set("first", first.get)
  if last.isSome: args.set("last", last.get)
  if length.isSome: args.set("length", length.get)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "Trim".cstring, args.handle)


proc turn180*(vsmap:VSMapRef):VSMapRef =

  let plug = getPluginById("com.vapoursynth.std")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.std\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clip", clip)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "Turn180".cstring, args.handle)


