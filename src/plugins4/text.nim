import options
import ../lib/[libvsmap,libvsnode,libvsframe,libvsfunction,libvsplugins, libapi, libvsanode]

proc clipInfo*(vsmap:VSMapObj;
               alignment= none(int);
               scale= none(int)):VSMapObj =

  let plug = getPluginById("com.vapoursynth.text")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.text\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  args.append("clip", clip)
  if alignment.isSome: args.append("alignment", alignment.get)
  if scale.isSome: args.append("scale", scale.get)

  result.handle = api.handle.invoke(plug.handle, "ClipInfo".cstring, args.handle)
  #API.freeMap(args)

#[
proc coreInfo*(vsmap= none(VSMapObj);
               alignment= none(int);
               scale= none(int)):VSMapObj =

  let plug = getPluginById("com.vapoursynth.text")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.text\" not installed properly in your computer") 
  if vsmap.isSome:
    assert( vsmap.get.len != 0, "the vsmap should contain at least one item")
    assert( vsmap.get.len("vnode") == 1, "the vsmap should contain one node")
  var clip:VSNodeObj
  if vsmap.isSome:
    clip = getFirstNode(vsmap.get)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  if clip.isSome: args.append("clip", clip.get)
  if alignment.isSome: args.append("alignment", alignment.get)
  if scale.isSome: args.append("scale", scale.get)

  result.handle = api.handle.invoke(plug.handle, "CoreInfo".cstring, args.handle)
  #API.freeMap(args)
]#

proc frameNum*(vsmap:VSMapObj;
               alignment= none(int);
               scale= none(int)):VSMapObj =

  let plug = getPluginById("com.vapoursynth.text")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.text\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  args.append("clip", clip)
  if alignment.isSome: args.append("alignment", alignment.get)
  if scale.isSome: args.append("scale", scale.get)

  result.handle = api.handle.invoke(plug.handle, "FrameNum".cstring, args.handle)
  #API.freeMap(args)


proc frameProps*(vsmap:VSMapObj;
                 props= none(seq[string]);
                 alignment= none(int);
                 scale= none(int)):VSMapObj =

  let plug = getPluginById("com.vapoursynth.text")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.text\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  args.append("clip", clip)
  if props.isSome:
    for item in props.get:
      args.append("props", item)
  if alignment.isSome: args.append("alignment", alignment.get)
  if scale.isSome: args.append("scale", scale.get)

  result.handle = api.handle.invoke(plug.handle, "FrameProps".cstring, args.handle)
  #API.freeMap(args)


proc text*(vsmap:VSMapObj;
           text:string;
           alignment= none(int);
           scale= none(int)):VSMapObj =

  let plug = getPluginById("com.vapoursynth.text")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.text\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("vnode") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  args.append("clip", clip)
  args.append("text", text)
  if alignment.isSome: args.append("alignment", alignment.get)
  if scale.isSome: args.append("scale", scale.get)

  result.handle = api.handle.invoke(plug.handle, "Text".cstring, args.handle)
  #API.freeMap(args)


