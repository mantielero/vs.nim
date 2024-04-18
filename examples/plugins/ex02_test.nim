import vs

# load the plugin
let tmp = loadPlugin("./libex02.so")

# wrap the filter for Nim
proc myFilter*(vsmap:VSMapRef):VSMapRef =
  let plug = getPluginById("com.example.filter")
  assert( plug.handle != nil, "plugin \"com.example.filter\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clip", clip)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "Filter".cstring, args.handle)

# running the filter
let nframes = source("../../media/2sec.mkv").myFilter.saveY4M("../../media/demo.y4m")
echo nframes, " frames written in '../../media/demo.y4m'"