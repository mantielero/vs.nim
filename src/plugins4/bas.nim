import options
import ../lib/vsmap/libvsmap
import ../lib/node/libvsnode
import ../lib/frame/libvsframe
import ../lib/function/libvsfunction
import ../lib/plugin/libvsplugins
import ../lib/api/libapi

proc asource*(source:string;
              track= none(int);
              adjustdelay= none(int);
              exactsamples= none(int);
              enable_drefs= none(int);
              use_absolute_path= none(int);
              drc_scale= none(float)):VSMapRef =

  let plug = getPluginById("com.vapoursynth.bestaudiosource")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.bestaudiosource\" not installed properly in your computer") 

  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  args.set("source", source)
  if track.isSome: args.set("track", track.get)
  if adjustdelay.isSome: args.set("adjustdelay", adjustdelay.get)
  if exactsamples.isSome: args.set("exactsamples", exactsamples.get)
  if enable_drefs.isSome: args.set("enable_drefs", enable_drefs.get)
  if use_absolute_path.isSome: args.set("use_absolute_path", use_absolute_path.get)
  if drc_scale.isSome: args.set("drc_scale", drc_scale.get)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "Source".cstring, args.handle)


