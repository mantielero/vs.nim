#[
This file contains a simple filter
skeleton you can use to get started.
With no changes it simply passes
frames through.
]#
# Generar el plugin: libex10_custom_filter
# nim c --app:lib ex10_custom_filter 
# Cargar y probar el plugin
# nim c -r ex10_custom_filter 

import vs
#include "VSHelper4.h"
# type
#   FilterDataObj* {.bycopy.} = object
#     node*: VSNodeRef
#     vi*: VSVideoInfoRef
#   FilterData* = ref FilterDataObj

type
  FilterData* {.bycopy.} = object
    node*: ptr VSNode
    vi*: ptr VSVideoInfo
  
# static const VSFrame *VS_CC filterGetFrame(int n, int activationReason, void *instanceData, void **frameData, VSFrameContext *frameCtx, VSCore *core, const VSAPI *vsapi) {
#VSFilterGetFrame
proc filterGetFrame*( n:cint, 
                      activationReason:cint, # activationReason, 
                      instanceData: pointer, #void *instanceData, 
                      frameData: ptr pointer, #void **frameData, 
                      frameCtx: ptr VSFrameContext, 
                      core: ptr VSCore, 
                      vsapi: ptr VSApi
                      ): ptr VSFrame {.cdecl.} =
  echo "Entering 'filterGetFrame'"
  let fCtx = new VSFrameContextRef
  fCtx.handle = frameCtx
  # FilterData *d = (FilterData *)instanceData;
  let d = cast[FilterData](instanceData)

  # if (activationReason == arInitial) {
  #     vsapi->requestFrameFilter(n, d->node, frameCtx);
  if activationReason.Vsactivationreason == arInitial:
    var tmp = new VSNodeRef
    tmp.handle = d.node
    requestFrameFilter(n,tmp, fCtx)

  # } else if (activationReason == arAllFramesReady) {
  #     const VSFrame *frame = vsapi->getFrameFilter(n, d->node, frameCtx);

  #     /* your code here... */

  #     return frame;
  # } 
  elif activationReason.Vsactivationreason == arAllFramesReady:
    var tmp = new VSNodeRef
    tmp.handle = d.node
    let frame = getFrameFilter(n, tmp, fCtx)
    # your code here...
    return frame.handle
  
  return nil


# proc filterGetFrame3*( n:int, 
#                       activationReason:int, # activationReason, 
#                       instanceData: pointer, #void *instanceData, 
#                       frameData: pointer, #void **frameData, 
#                       frameCtx: VSFrameContext, 
#                       core: ptr VSCore, 
#                       vsapi: ptr VSApi
#                       ): ptr VSFrame {.cdecl.} =

#   let fCtx = new VSFrameContextRef
#   fCtx.handle = frameCtx.unsafeAddr
#   # FilterData *d = (FilterData *)instanceData;
#   let d = cast[FilterData](instanceData)

#   # if (activationReason == arInitial) {
#   #     vsapi->requestFrameFilter(n, d->node, frameCtx);
#   if activationReason.Vsactivationreason == arInitial:
#     requestFrameFilter(n, d.node, fCtx)

#   # } else if (activationReason == arAllFramesReady) {
#   #     const VSFrame *frame = vsapi->getFrameFilter(n, d->node, frameCtx);

#   #     /* your code here... */

#   #     return frame;
#   # } 
#   elif activationReason.Vsactivationreason == arAllFramesReady:
#     let frame = getFrameFilter(n, d.node, fCtx)
#     # your code here...
#     return frame.handle
  
#   return nil



# proc filterGetFrame2*( n:int, 
#                       activationReason:int, # activationReason, 
#                       instanceData: pointer, #void *instanceData, 
#                       frameData: pointer, #void **frameData, 
#                       frameCtx: VSFrameContext, 
#                       core: VSCoreRef, 
#                       vsapi: VSApiRef): VSFrameRef =

#   let fCtx = new VSFrameContextRef
#   fCtx.handle = frameCtx.unsafeAddr
#   # FilterData *d = (FilterData *)instanceData;
#   let d = cast[FilterData](instanceData)

#   # if (activationReason == arInitial) {
#   #     vsapi->requestFrameFilter(n, d->node, frameCtx);
#   if activationReason.Vsactivationreason == arInitial:
#     requestFrameFilter(n, d.node, fCtx)

#   # } else if (activationReason == arAllFramesReady) {
#   #     const VSFrame *frame = vsapi->getFrameFilter(n, d->node, frameCtx);

#   #     /* your code here... */

#   #     return frame;
#   # } 
#   elif activationReason.Vsactivationreason == arAllFramesReady:
#     let frame = getFrameFilter(n, d.node, fCtx)
#     # your code here...
#     return frame
  
#   return nil



#[
static void VS_CC filterFree(void *instanceData, VSCore *core, const VSAPI *vsapi) {
    FilterData *d = (FilterData *)instanceData;
    vsapi->freeNode(d->node);
    free(d);
}
]#
# Vsfilterfree
proc filterFree*( instanceData:pointer, #void *instanceData, 
                  core:ptr VSCore, #VSCore *core, 
                  vsapi: ptr VSApi ) {.cdecl.} =  #const VSAPI *vsapi) =
  echo "Entering 'filterFree'"                  
  let d = cast[FilterData](instanceData)
  vsapi.freeNode(d.node)
  

# proc filterFree2*( instanceData:pointer, #void *instanceData, 
#                   core:VSCoreRef, #VSCore *core, 
#                   vsapi: VSApiRef ) =  #const VSAPI *vsapi) =
#   let d = cast[FilterData](instanceData)

# static void VS_CC filterCreate(const VSMap *in, VSMap *out, void *userData, VSCore *core, const VSAPI *vsapi) {
#let filterCreate:Vspublicfunction = proc ( `in`: ptr VSMap,     #const VSMap *in, 


# No necesita ser exportada
proc filterCreate*( `in`: ptr VSMap,     #const VSMap *in, 
                    `out`: ptr VSMap,    #VSMap *out, 
                    userData: pointer,  #void *userData, 
                    core: ptr VSCore,    # VSCore *core, 
                    vsapi: ptr VSApi ) {.cdecl.} = #const VSAPI *vsapi) =
  echo "Entering 'filterCreate'"
  # var d    = new FilterData  # FilterData d;
  # var data = new FilterData  # FilterData *data;
  
  var inClip  = new VSMapRef
  inClip.handle = `in`
  var outClip = new VSMapRef
  outClip.handle = `out`
  let myNode = inClip.getNode("clip", 0) # d.node = vsapi->mapGetNode(in, "clip", 0, 0);
  let myVideoInfo   = myNode.getVideoInfo        # d.vi = vsapi->getVideoInfo(d.node);
  let d = FilterData(node: myNode.handle, vi: myVideoInfo.handle)
  # data = (FilterData *)malloc(sizeof(d));
  # *data = d;
  let data = d

  # VSFilterDependency deps[] = {{d.node, rpGeneral}}; /* Depending the the request patterns you may want to change this */
  let deps = VSFilterDependency(source: d.node, 
                                requestpattern: rpGeneral.cint)
  # vsapi->createVideoFilter(out, "Filter", data->vi, filterGetFrame, filterFree, 
  #                           fmParallel, deps, 1, data, core);
  vsapi.createVideoFilter(
          `out`, 
          "Filter".cstring, 
          data.vi, 
          filterGetFrame, 
          filterFree, 
          fmParallel.cint,
          deps.unsafeAddr, 
          1.cint, 
          cast[pointer](data.addr), 
          core )
  echo "Leaving 'filterCreate'"
# proc filterCreate2*( `in`: VSMapRef,     #const VSMap *in, 
#                     `out`: VSMapRef,    #VSMap *out, 
#                     userData: pointer,  #void *userData, 
#                     core: VSCoreRef,    # VSCore *core, 
#                     vsapi: VSApiRef ) = #const VSAPI *vsapi) =
#   var d    = new FilterData  # FilterData d;
#   var data = new FilterData  # FilterData *data;
  
#   d.node = `in`.getNode("clip", 0) # d.node = vsapi->mapGetNode(in, "clip", 0, 0);
#   d.vi   = d.node.getVideoInfo        # d.vi = vsapi->getVideoInfo(d.node);

#   # data = (FilterData *)malloc(sizeof(d));
#   # *data = d;
#   data = d

#   # VSFilterDependency deps[] = {{d.node, rpGeneral}}; /* Depending the the request patterns you may want to change this */
#   let deps = VSFilterDependency(source: d.node.handle, 
#                                 requestpattern: rpGeneral.cint)
#   # vsapi->createVideoFilter(out, "Filter", data->vi, filterGetFrame, filterFree, 
#   #                           fmParallel, deps, 1, data, core);
#   vsapi.handle.createVideoFilter(`out`.handle, "Filter".cstring, data.vi.handle, 
#           filterGetFrame, 
#           filterFree, fmParallel.cint,
#           deps.unsafeAddr, 1.cint, cast[pointer](data.addr), core.handle )

#[
a3: Vsfiltergetframe, 
proc (n: int, 
      activationReason: int, 
      instanceData: pointer, 
      frameData: pointer, 
      frameCtx: structvsframecontext, 
      core: ptr structvscore, 
      vsapi: ptr structvsapi): ptr structvsframe, 

]#

# Init

#[
VS_EXTERNAL_API(void) VapourSynthPluginInit2(VSPlugin *plugin, const VSPLUGINAPI *vspapi) 
{
    vspapi->configPlugin("com.example.filter", "filter", "VapourSynth Filter Skeleton", VS_MAKE_VERSION(1, 0), VAPOURSYNTH_API_VERSION, 0, plugin);
    vspapi->registerFunction("Filter", "clip:vnode;", "clip:vnode;", filterCreate, NULL, plugin);
}
]#

proc VS_MAKE_VERSION(major, minor: int): int =
  (major shl 16) or minor

# Esta es la única función que necesita ser exportada
proc VapourSynthPluginInit2*(plugin: ptr VSPlugin, 
                             vsapi: ptr VSPluginApi) {.cdecl,exportc:"$1",dynlib.} =
    echo "Entering VapourSynthPluginInit2"
    let myPlugin = new VSPluginRef
    myPlugin.handle = plugin
    #echo plugin == nil

    # configPlugin( "com.example.filter", 
    #                      "filter", 
    #                      "VapourSynth Filter Skeleton", 
    #                      VS_MAKE_VERSION(1, 0), 
    #                      VS_MAKE_VERSION(Vapoursynthapimajor, Vapoursynthapiminor), #VAPOURSYNTH_API_VERSION, 
    #                      0, 
    #                      myPlugin)
    let ret = vsapi.configplugin(
                        "com.example.filter".cstring, 
                        "filter".cstring, 
                        "VapourSynth Filter Skeleton".cstring,
                        VS_MAKE_VERSION(1, 0).cint, 
                        VS_MAKE_VERSION(Vapoursynthapimajor, Vapoursynthapiminor).cint, 
                        0.cint, 
                        plugin )
    #echo ret
    # vsapi.registerFunction("Filter", 
    #                         "clip:vnode;", 
    #                         "clip:vnode;", 
    #                         filterCreate, 
    #                         nil, 
    #                         myPlugin);

    let ret2 = vsapi.registerFunction(
                        "Filter".cstring, 
                        "clip:vnode;".cstring, 
                        "clip:vnode;".cstring,
                        filterCreate, 
                        nil, 
                        plugin )  
    #echo ret2
    echo "Leaving VapourSynthPluginInit2"    
# ----- USE THE FILTER -----

when isMainModule:
  import vs
  # https://www.vapoursynth.com/doc/installation.html#installing-manually
  let tmp = loadPlugin("./libex10_custom_filter.so")
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
    # if left.isSome: args.set("left", left.get)
    # if right.isSome: args.set("right", right.get)
    # if top.isSome: args.set("top", top.get)
    # if bottom.isSome: args.set("bottom", bottom.get)

    result = newMap()
    result.handle = api.handle.invoke(plug.handle, "Filter".cstring, args.handle)
  let nframes = source("../media/2sec.mkv").myFilter.saveY4M("../media/demo.y4m")
  echo nframes, " frames written in '../media/demo.y4m'"
