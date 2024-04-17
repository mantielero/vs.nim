#[
This file contains a simple filter
skeleton you can use to get started.
With no changes it simply passes
frames through.
]#
# Create the plugin: libex10_custom_filter.so
# $ nim c --app:lib ex10_custom_filter 
# Load the plugin and use it:
# $ nim c -r ex10_custom_filter 

# https://forum.nim-lang.org/t/6081
# https://github.com/vapoursynth/vapoursynth/issues/534
import vs

type
  FilterDataObj* = object
    node*: ptr VSNode
    vi*: ptr VSVideoInfo
  
proc filterGetFrame*( n:cint, 
                      activationReason:cint, # activationReason, 
                      instanceData: pointer, #void *instanceData, 
                      frameData: ptr pointer, #void **frameData, 
                      frameCtx: ptr VSFrameContext, 
                      core: ptr VSCore, 
                      vsapi: ptr VSApi
                      ): ptr VSFrame {.cdecl.} =
  let d:ptr FilterDataObj = cast[ptr FilterDataObj](instanceData)
 
  if activationReason.Vsactivationreason == arInitial:
    vsapi.requestFrameFilter(n.cint, d.node, frameCtx)

  elif activationReason.Vsactivationreason == arAllFramesReady:   
    let dstFrame = vsapi.getFrameFilter(n.cint, d.node, frameCtx)
    # your code here...

    #vsapi.freeFrame(s)
    return dstFrame
  
  return nil


proc filterFree*( instanceData:pointer, #void *instanceData, 
                  core:ptr VSCore, #VSCore *core, 
                  vsapi: ptr VSApi ) {.cdecl.} =  #const VSAPI *vsapi) =
  var tmp = cast[ptr FilterDataObj](instanceData)
  var data = cast[FilterDataObj](tmp)

  vsapi.freeNode(data.node)



# No necesita ser exportada
proc filterCreate*( inClip: ptr VSMap,     #const VSMap *in, 
                    outClip: ptr VSMap,    #VSMap *out, 
                    userData: pointer,  #void *userData, 
                    core: ptr VSCore,    # VSCore *core, 
                    vsapi: ptr VSApi ) {.cdecl.} =  # {.cdecl,exportc,dynlib.} = #const VSAPI *vsapi) =
  var err = peUnset.cint
  var perr = cast[ptr cint](unsafeAddr(err))   
  let node = vsapi.mapGetNode(inClip, "clip".cstring, 0.cint, perr)

  let vi = vsapi.getVideoInfo(node)

  # Move data to the heap
  var d = FilterDataObj(node: node, vi: vi)
  var data1 = cast[ptr FilterDataObj]( alloc0(sizeof(d)) )
  data1[] = d  

  let deps = VSFilterDependency(source: d.node, 
                                requestpattern: rpGeneral.cint)
  var data2 = cast[ptr VSFilterDependency]( alloc0(sizeof(deps)) )
  data2[] = deps

  vsapi.createVideoFilter(
          outClip,           # ptr VSMap
          "Filter".cstring,  # cstring, 
          d.vi,              # ptr VSVideoInfo
          filterGetFrame,    # VSFilterGetFrame
          filterFree,        # VSFilterFree
          fmParallel.cint,   # cint
          data2,             # ptr VSFilterDependency
          1.cint,            # cint
          data1,             # ptr FilterDataObj
          core )             # ptr VSCore


proc VS_MAKE_VERSION(major, minor: int): int =
  (major shl 16) or minor

# Esta es la única función que necesita ser exportada
proc VapourSynthPluginInit2*(plugin: ptr VSPlugin, 
                             vsapi: ptr VSPluginApi) {.cdecl,exportc:"$1",dynlib.} =
    let myPlugin = new VSPluginRef
    myPlugin.handle = plugin

    let ret = vsapi.configplugin(
                        "com.example.filter".cstring, 
                        "filter".cstring, 
                        "VapourSynth Filter Skeleton".cstring,
                        VS_MAKE_VERSION(1, 0).cint, 
                        VS_MAKE_VERSION(Vapoursynthapimajor, Vapoursynthapiminor).cint, 
                        0.cint, 
                        plugin )

    let ret2 = vsapi.registerFunction(
                        "Filter".cstring, 
                        "clip:vnode;".cstring, 
                        "clip:vnode;".cstring,
                        filterCreate, 
                        nil, 
                        plugin )  

# ----- USE THE FILTER -----
when isMainModule:
  import vs
  # https://www.vapoursynth.com/doc/installation.html#installing-manually
  let tmp = loadPlugin("./libex01_filter_skeleton.so")
  #let plug = getPluginById("com.example.filter")
  #echo plug.handle == nil
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

  let nframes = source("../../media/2sec.mkv").myFilter.saveY4M("../../media/demo.y4m")
  echo nframes, " frames written in '../../media/demo.y4m'"
