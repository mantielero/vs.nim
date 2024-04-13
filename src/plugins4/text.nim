import options
import ../lib/vsmap/libvsmap
import ../lib/node/libvsnode
import ../lib/frame/libvsframe
import ../lib/function/libvsfunction
import ../lib/plugin/libvsplugins
import ../lib/api/libapi

proc clipInfo*(vsmap:VSMapRef;
               alignment= none(int);
               scale= none(int)):VSMapRef =

  let plug = getPluginById("com.vapoursynth.text")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.text\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clip", clip)
  if alignment.isSome: args.set("alignment", alignment.get)
  if scale.isSome: args.set("scale", scale.get)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "ClipInfo".cstring, args.handle)


proc coreInfo*(vsmap= none(VSMapRef);
               alignment= none(int);
               scale= none(int)):VSMapRef =

  let plug = getPluginById("com.vapoursynth.text")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.text\" not installed properly in your computer") 
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
  if alignment.isSome: args.set("alignment", alignment.get)
  if scale.isSome: args.set("scale", scale.get)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "CoreInfo".cstring, args.handle)


proc frameNum*(vsmap:VSMapRef;
               alignment= none(int);
               scale= none(int)):VSMapRef =

  let plug = getPluginById("com.vapoursynth.text")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.text\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clip", clip)
  if alignment.isSome: args.set("alignment", alignment.get)
  if scale.isSome: args.set("scale", scale.get)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "FrameNum".cstring, args.handle)


proc frameProps*(vsmap:VSMapRef;
                 props= none(seq[string]);
                 alignment= none(int);
                 scale= none(int)):VSMapRef =

  let plug = getPluginById("com.vapoursynth.text")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.text\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clip", clip)
  if props.isSome: args.set("props", props.get)
  if alignment.isSome: args.set("alignment", alignment.get)
  if scale.isSome: args.set("scale", scale.get)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "FrameProps".cstring, args.handle)


proc text*(vsmap:VSMapRef;
           text:string;
           alignment= none(int);
           scale= none(int)):VSMapRef =

  let plug = getPluginById("com.vapoursynth.text")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.text\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clip", clip)
  args.set("text", text)
  if alignment.isSome: args.set("alignment", alignment.get)
  if scale.isSome: args.set("scale", scale.get)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "Text".cstring, args.handle)


