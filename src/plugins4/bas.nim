import options
import ../lib/[libvsmap,libvsnode,libvsframe,libvsfunction,libvsplugins, libapi, libvsanode]

proc source*(source:string;
             track= none(int);
             adjustdelay= none(int);
             exactsamples= none(int);
             enable_drefs= none(int);
             use_absolute_path= none(int);
             drc_scale= none(float)):VSMapObj =

  let plug = getPluginById("com.vapoursynth.bestaudiosource")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.bestaudiosource\" not installed properly in your computer") 

  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  args.append("source", source)
  if track.isSome: args.append("track", track.get)
  if adjustdelay.isSome: args.append("adjustdelay", adjustdelay.get)
  if exactsamples.isSome: args.append("exactsamples", exactsamples.get)
  if enable_drefs.isSome: args.append("enable_drefs", enable_drefs.get)
  if use_absolute_path.isSome: args.append("use_absolute_path", use_absolute_path.get)
  if drc_scale.isSome: args.append("drc_scale", drc_scale.get)

  result.handle = api.handle.invoke(plug.handle, "Source".cstring, args.handle)
  #API.freeMap(args)


