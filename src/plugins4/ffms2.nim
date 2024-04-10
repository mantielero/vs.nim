import options
import ../lib/[libvsmap,libvsnode,libvsframe,libvsfunction,libvsplugins, libapi, libvsanode]

proc getLogLevel*():VSMapObj =

  let plug = getPluginById("com.vapoursynth.ffms2")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.ffms2\" not installed properly in your computer") 

  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()


  result.handle = api.handle.invoke(plug.handle, "GetLogLevel".cstring, args.handle)
  #API.freeMap(args)


proc index*(source:string;
            cachefile= none(string);
            indextracks= none(seq[int]);
            errorhandling= none(int);
            overwrite= none(int)):VSMapObj =

  let plug = getPluginById("com.vapoursynth.ffms2")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.ffms2\" not installed properly in your computer") 

  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  args.append("source", source)
  if cachefile.isSome: args.append("cachefile", cachefile.get)
  if indextracks.isSome:
    for item in indextracks.get:
      args.append("indextracks", item)
  if errorhandling.isSome: args.append("errorhandling", errorhandling.get)
  if overwrite.isSome: args.append("overwrite", overwrite.get)

  result.handle = api.handle.invoke(plug.handle, "Index".cstring, args.handle)
  #API.freeMap(args)


proc setLogLevel*(level:int):VSMapObj =

  let plug = getPluginById("com.vapoursynth.ffms2")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.ffms2\" not installed properly in your computer") 

  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()


  result.handle = api.handle.invoke(plug.handle, "SetLogLevel".cstring, args.handle)
  #API.freeMap(args)


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
             alpha= none(int)):VSMapObj =

  let plug = getPluginById("com.vapoursynth.ffms2")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.ffms2\" not installed properly in your computer") 

  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()

  args.append("source", source)
  if track.isSome: args.append("track", track.get)
  if cache.isSome: args.append("cache", cache.get)
  if cachefile.isSome: args.append("cachefile", cachefile.get)
  if fpsnum.isSome: args.append("fpsnum", fpsnum.get)
  if fpsden.isSome: args.append("fpsden", fpsden.get)
  if threads.isSome: args.append("threads", threads.get)
  if timecodes.isSome: args.append("timecodes", timecodes.get)
  if seekmode.isSome: args.append("seekmode", seekmode.get)
  if width.isSome: args.append("width", width.get)
  if height.isSome: args.append("height", height.get)
  if resizer.isSome: args.append("resizer", resizer.get)
  if format.isSome: args.append("format", format.get)
  if alpha.isSome: args.append("alpha", alpha.get)

  result.handle = api.handle.invoke(plug.handle, "Source".cstring, args.handle)
  #API.freeMap(args)


proc version*():VSMapObj =

  let plug = getPluginById("com.vapoursynth.ffms2")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.ffms2\" not installed properly in your computer") 

  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()


  result.handle = api.handle.invoke(plug.handle, "Version".cstring, args.handle)
  #API.freeMap(args)


