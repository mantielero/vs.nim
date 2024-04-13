import options
import ../lib/vsmap/libvsmap
import ../lib/node/libvsnode
import ../lib/frame/libvsframe
import ../lib/function/libvsfunction
import ../lib/plugin/libvsplugins
import ../lib/api/libapi

proc getLogLevel*():VSMapRef =

  let plug = getPluginById("com.vapoursynth.ffms2")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.ffms2\" not installed properly in your computer") 

  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()


  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "GetLogLevel".cstring, args.handle)


proc index*(source:string;
            cachefile= none(string);
            indextracks= none(seq[int]);
            errorhandling= none(int);
            overwrite= none(int)):VSMapRef =

  let plug = getPluginById("com.vapoursynth.ffms2")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.ffms2\" not installed properly in your computer") 

  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  args.set("source", source)
  if cachefile.isSome: args.set("cachefile", cachefile.get)
  if indextracks.isSome: args.set("indextracks", indextracks.get)
  if errorhandling.isSome: args.set("errorhandling", errorhandling.get)
  if overwrite.isSome: args.set("overwrite", overwrite.get)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "Index".cstring, args.handle)


proc setLogLevel*(level:int):VSMapRef =

  let plug = getPluginById("com.vapoursynth.ffms2")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.ffms2\" not installed properly in your computer") 

  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()


  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "SetLogLevel".cstring, args.handle)


proc source*(source:string;
             track= none(int);
             cache= none(int);
             cachefile= none(string);
             fpsnum= none(int);
             fpsden= none(int);
             threads= none(int);
             timecodes= none(string);
             seekmode= none(int);
             width= none(int);
             height= none(int);
             resizer= none(string);
             format= none(int);
             alpha= none(int)):VSMapRef =

  let plug = getPluginById("com.vapoursynth.ffms2")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.ffms2\" not installed properly in your computer") 

  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  args.set("source", source)
  if track.isSome: args.set("track", track.get)
  if cache.isSome: args.set("cache", cache.get)
  if cachefile.isSome: args.set("cachefile", cachefile.get)
  if fpsnum.isSome: args.set("fpsnum", fpsnum.get)
  if fpsden.isSome: args.set("fpsden", fpsden.get)
  if threads.isSome: args.set("threads", threads.get)
  if timecodes.isSome: args.set("timecodes", timecodes.get)
  if seekmode.isSome: args.set("seekmode", seekmode.get)
  if width.isSome: args.set("width", width.get)
  if height.isSome: args.set("height", height.get)
  if resizer.isSome: args.set("resizer", resizer.get)
  if format.isSome: args.set("format", format.get)
  if alpha.isSome: args.set("alpha", alpha.get)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "Source".cstring, args.handle)


proc version*():VSMapRef =

  let plug = getPluginById("com.vapoursynth.ffms2")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.ffms2\" not installed properly in your computer") 

  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()


  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "Version".cstring, args.handle)


