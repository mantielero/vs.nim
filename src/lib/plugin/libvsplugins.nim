#[
registerFunction: PENDING

]#
import ../../wrapper/vapoursynth4
import ../api/libapi
import ../core/libcore
import ../node/libvsnode
import ../frame/libvsframe
import ../info/[helper, info]
import ../vsmap/libvsmap
import std/[strutils]

type
  VSPluginObj* = object
    handle*:ptr VSPlugin # ptr Vsplugin
  VSPluginRef* = ref VSPluginObj
  
  VSPluginFunctionObj* = object
    handle*:ptr VSPluginFunction
  VSPluginFunctionRef = ref VSPluginFunctionObj

  Argument* = tuple[name:string, typ:string, optional:bool] # Function arguments
  ReturnArgument* = tuple[name:string, typ:string]

iterator plugins*():VSPluginRef =
  ## Iterate over all the plugins available in the system
  var plugin = new VSPluginRef
  plugin.handle = api.handle.getNextPlugin(nil, core.handle)
  while plugin.handle != nil:
    yield plugin
    plugin.handle = api.handle.getNextPlugin(plugin.handle, core.handle )


proc name*(plugin:VSPluginRef):string =
  $api.handle.getPluginName(plugin.handle)

proc id*(plugin:VSPluginRef):string =
  $api.handle.getPluginID(plugin.handle)

proc nameSpace*(plugin:VSPluginRef):string =
  $api.handle.getPluginNamespace(plugin.handle)

proc path*(plugin:VSPluginRef):string =
  $api.handle.getPluginPath(plugin.handle)

proc version*(plugin:VSPluginRef):int =
  api.handle.getPluginVersion(plugin.handle)


proc getPluginById*(id:string):VSPluginRef =
  result = new VSPluginRef 
  result.handle = api.handle.getpluginbyid(id.cstring, core.handle)

proc getPluginByNamespace*(namespace:string):VSPluginRef =
  result = new VSPluginRef   
  result.handle = api.handle.getPluginByNamespace(namespace.cstring, core.handle)


# Functions
iterator functions*(plugin:VSPluginObj): VSPluginFunctionRef =
  var function = new VSPluginFunctionRef
  function.handle = api.handle.getNextPluginFunction(nil, plugin.handle )
  while function.handle != nil:
    yield function
    function.handle = api.handle.getNextPluginFunction(function.handle, plugin.handle )  

proc name*(function:VSPluginFunctionRef):string =
  $api.handle.getPluginFunctionName(function.handle)

proc args*(function:VSPluginFunctionRef):seq[Argument] =
  var tmp = $api.handle.getPluginFunctionArguments(function.handle)
  # Arguments
  var args = tmp.split(';')
  if len(args) > 0:
    for arg in args:
      if arg != "":
        var tmp = arg.split(":")
        var name,typ:string
        var optional:bool = false

        if tmp.len > 0: 
          name = tmp[0]
        if tmp.len > 1:
          typ = tmp[1]
        if tmp.len > 2:
          optional = true
        if name == "any":
          typ = "any"
        result &= (name, typ, optional)


proc ret*(function:VSPluginFunctionRef):ReturnArgument =
  var tmp = $api.handle.getPluginFunctionReturnType(function.handle)
  var items = tmp.split(";")
  
  if items.len > 0:
    var item = items[0]
    if item != "":
      var values = item.split(":")
      if values.len == 2:
        result = (values[0],values[1])
      else:
        if values[0] == "any":
          result = ("any", "any")


proc getFunctionByName*(plugin:VSPluginRef; name:string):VSPluginFunctionRef = 
  result = new VSPluginFunctionRef
  result.handle = api.handle.getPluginFunctionByName(name.cstring, plugin.handle)


# Invoke
proc invoke*(plugin:VSPluginRef; name:string; args:VSMapRef):VSMapRef =
  #[
  Calls functions within plugins (invokes a filter).

  invoke() makes sure that:
  
  - the filter has no compat input nodes
  - checks that the args passed to the filter are consistent with the argument list registered by the plugin that contains the filter,
  - calls the filter’s "create" function,
  - and checks that the filter doesn’t return any compat nodes.
  
  If everything goes smoothly, the filter will be ready to generate frames after invoke() returns.
  
  Thread-safe.
  
  Arguments
  =========
  
  - plugin: A pointer to the plugin where the filter is located. Must not be NULL.
  
      See getPluginById() and getPluginByNs().
  
  - name: Name of the filter to invoke.
  - args: Arguments for the filter.
  
  Returns a map containing the filter’s return value(s).
  
  The caller gets ownership of the map. Use getError() to check if the filter was invoked successfully.
  
  Most filters will either add an error to the map, or one or more clips with the key “clip”.
  
  The exception to this are functions, for example LoadPlugin, which doesn’t return any clips for obvious reasons.
  ]#
  result = new VSMapRef
  result.handle = api.handle.invoke(plugin.handle, name.cstring, args.handle)


# Create your own filters
#[
    configplugin*: proc (a0: cstring; a1: cstring; a2: cstring; a3: cint;
                         a4: cint; a5: cint; a6: ptr Vsplugin): cint {.cdecl.}
]#
let pluginApi* = Vspluginapi()

proc getPluginApiVersion*():int =
  return pluginApi.getApiVersion().int

proc configPlugin*( identifier,pluginNamespace,name:string; 
                    pluginVersion, apiVersion, flags: int;
                    plugin: VSPluginRef) =
  ##[
  Used to provide information about a plugin when loaded. 
  Must be called exactly once from the VapourSynthPluginInit2 
  entry point. It is recommended to use the VS_MAKE_VERSION 
  macro when providing the pluginVersion. If you don’t know 
  the specific apiVersion you actually require simply 
  pass VAPOURSYNTH_API_VERSION to match the header version 
  you’re compiling against. The flags consist of values from 
  VSPluginConfigFlags ORed together but should for most plugins 
  typically be 0.
  ]##
  echo "entering 'configPlugin'"
  let ret = pluginApi.configplugin(identifier.cstring, pluginNamespace.cstring, name.cstring,
                       pluginVersion.cint, apiVersion.cint, flags.cint, plugin.handle )
  # Returns non-zero on success.
  if ret == 0:
    raise newException(ValueError, "something went wrong while configuring the plugin")

#typedef void (VS_CC *VSPublicFunction)(const VSMap *in, VSMap *out, void *userData, VSCore *core, const VSAPI *vsapi)
type
  VSPublicFunctionRef* = proc(`in`, `out`: VSMapRef; userData: pointer;
                            vscore: VSCoreRef; a4: ptr Vsapi)

  VSFrameContextObj* = object
    handle*: ptr VSFrameContext
  VSFrameContextRef* = ref VSFrameContextObj

  #VSFilterDependencyRef* = ref VSFilterDependency

#VSFilterGetFrameRef

# type
#   VSPluginApiRef* = ref VSPluginApi

type
  VSPublicFunction2* = proc ( `in`: ptr VSMap,     #const VSMap *in, 
                    `out`: ptr VSMap,    #VSMap *out, 
                    userData: pointer,  #void *userData, 
                    core: ptr VSCore,    # VSCore *core, 
                    vsapi: ptr VSApi ) {.cdecl.}

proc registerFunction*(pluginApi: ptr VSPluginApi; name, args, returnType:string;
                       argsFunc: VSPublicFunction2;
                       functionData: pointer;
                       plugin: VSPluginRef) =
  ##[
  Function that registers a filter exported by the plugin. 
  A plugin can export any number of filters. This 
  function may only be called during the plugin loading 
  phase unless the pcModifiable flag was set by configPlugin.
  ]##
  let ret = pluginApi.registerFunction(name.cstring, args.cstring, returnType.cstring,
                        argsFunc, functionData, plugin.handle )  
  if ret == 0:
    raise newException(ValueError, "something went wrong while registering the function")


# Frame
#[
Functions that are used to fetch frames and inside filters:

getFrame

getFrameAsync

getFrameFilter

requestFrameFilter

releaseFrameEarly

cacheFrame

setFilterError
]#
    # requestframefilter*: proc (a0: cint; a1: ptr Vsnode; a2: ptr Vsframecontext): void {.
    #     cdecl.}
proc requestFrameFilter*(n:int; node: VSNodeRef; frameCtx: VSFrameContextRef) =
  ## Requests a frame from a node and returns immediately.
  ## Only use inside a filter’s “getframe” function.
  ## A filter usually calls this function when its activation reason is arInitial.
  api.handle.requestFrameFilter(n.cint, node.handle, frameCtx.handle)
    
proc getFrameFilter*(n:int; node: VSNodeRef; frameCtx: VSFrameContextRef):VSFrameRef =
  ## Requests a frame from a node and returns immediately.
  ## Only use inside a filter’s “getframe” function.
  ## A filter usually calls this function when its activation reason is arInitial.
  result = new VSFrameRef
  result.handle = api.handle.getFrameFilter(n.cint, node.handle, frameCtx.handle)


#[
    createvideofilter*: proc (a0: ptr Vsmap; a1: cstring; a2: ptr Vsvideoinfo;
                              a3: Vsfiltergetframe; a4: Vsfilterfree; a5: cint;
                              a6: ptr Vsfilterdependency; a7: cint; a8: pointer;
                              a9: ptr Vscore): void
]#
proc createVideoFilter*(`out`: VSMapRef; name:string; vi: VSVideoInfoRef; 
                        getFrame: VSFilterGetFrame; free: VSFilterFree;
                        filterMode:int; 
                        dependencies: VSFilterDependency; 
                        numDeps: int; instanceData: pointer;
                        core:VSCoreRef) =
  api.handle.createVideoFilter(`out`.handle, name.cstring, vi.handle,
        getFrame, free, filterMode.cint,
        dependencies.unsafeAddr, numDeps.cint, instanceData, core.handle)


# ----------------------------------------
# Templates to make easier plugin creation
# ----------------------------------------

# Plugin initialization
type
  FilterCreateTyp* = proc ( inClip: ptr VSMap,     #const VSMap *in, 
                      outClip: ptr VSMap,    #VSMap *out, 
                      userData: pointer,  #void *userData, 
                      core {.inject.}: ptr VSCore,    # VSCore *core, 
                      vsapi {.inject.}: ptr VSApi ) {.cdecl.}

template regFunction*(functionName, functionArgs, functionReturn:string;
                     filterCreate:FilterCreateTyp):untyped {.dirty.} =
  #echo functionName
  ret = 0
  ret = vsapi.registerFunction(
                      functionName.cstring, 
                      functionArgs.cstring, 
                      functionReturn.cstring,
                      filterCreate, 
                      nil, # TODO: functionData: Pointer to user data that gets passed to argsFunc when creating a filter. Useful to register multiple filters using a single argsFunc function.
                      vsplugin)

  if ret == 0:
    raise newException(ValueError, 
                       "something failed while registering function: ")# & pluginId)

proc makeVersion*(pluginVersion:tuple[major:int,minor:int]): int =
  (pluginVersion.major shl 16) or pluginVersion.minor

template initPlugin*(pluginId, pluginNamespace, pluginName:string;
                    pluginVersion:tuple[major:int,minor:int]; 
                    flags:int;
                    body:untyped):untyped {.dirty.} =
  proc VapourSynthPluginInit2*(vsplugin: ptr VSPlugin, 
                               vsapi: ptr VSPluginApi) {.cdecl,exportc:"$1",dynlib.} =
    var ret = vsapi.configplugin(
                        pluginId.cstring, 
                        pluginNamespace.cstring, 
                        pluginName.cstring,
                        makeVersion(pluginVersion).cint, 
                        makeVersion((Vapoursynthapimajor, Vapoursynthapiminor)).cint, 
                        flags.cint, 
                        vsplugin )
    if ret == 0:
      raise newException(ValueError, "something failed while configuring plugin: " & pluginId)
    
    block:
      body

type
  FilterDataObj* = object of RootObj # to enable inheritance
    node*: ptr VSNode
    vi*: ptr VSVideoInfo



template createFilter*(filterName: string;
                       filterFunctionName:FilterCreateTyp; 
                       UserData:typedesc; 
                       body: untyped):untyped =
  ## creates: filterCreate, filterFree, filterGetFrame
  proc filterGetFrame*( n:cint, 
                        activationReason:cint, 
                        instanceData: pointer,
                        frameData: ptr pointer,
                        frameCtx: ptr VSFrameContext, 
                        core {.inject.}: ptr VSCore, 
                        vsapi {.inject.}: ptr VSApi
                        ): ptr VSFrame {.cdecl.} =
    let d = cast[ptr UserData](instanceData)
  
    if activationReason.Vsactivationreason == arInitial:
      vsapi.requestFrameFilter(n.cint, d.node, frameCtx)

    elif activationReason.Vsactivationreason == arAllFramesReady:   
      let srcFrame {.inject.} = vsapi.getFrameFilter(n.cint, d.node, frameCtx)
      #let fi = vsapi.getVideoFrameFormat(srcFrame)
      #let height = vsapi.getFrameHeight(srcFrame, 0)
      #let width = vsapi.getFrameWidth(srcFrame, 0)      
      #let dstFrame = vsapi.newVideoFrame(fi, width, height, srcFrame, core);
      # TODO: could it be better to do a copyFrame?

      # Crear frame
      # With the following, srcFrame memory should be handle by Nim.
      #let src {.inject.} = new VSMapRef
      #src.handle = srcFrame
      # your code here...
      #filterBody(vsapi, core, srcFrame, body)
      body
      #let dstFrame = vsapi.copyFrame(srcFrame, core)
      
      vsapi.freeFrame(srcFrame)
      return dstFrame
    
    return nil

  proc filterFree*( instanceData:pointer, #void *instanceData, 
                    core {.inject.}:ptr VSCore, #VSCore *core, 
                    vsapi {.inject.}: ptr VSApi ) {.cdecl.} =  #const VSAPI *vsapi) =
    var tmp = cast[ptr UserData](instanceData)
    var data = cast[UserData](tmp)

    vsapi.freeNode(data.node)
    dealloc(instanceData)


  #proc filterCreate*( inClip: ptr VSMap,     #const VSMap *in,
  filterFunctionName = proc( inClip: ptr VSMap,     #const VSMap *in, 
                      outClip: ptr VSMap,    #VSMap *out, 
                      userData: pointer,  #void *userData, 
                      core {.inject.}: ptr VSCore,    # VSCore *core, 
                      vsapi {.inject.}: ptr VSApi ) {.cdecl.} =  # {.cdecl,exportc,dynlib.} = #const VSAPI *vsapi) =
    var err = peUnset.cint
    var perr = cast[ptr cint](unsafeAddr(err))   
    let node = vsapi.mapGetNode(inClip, "clip".cstring, 0.cint, perr)

    let vi = vsapi.getVideoInfo(node)

    # Move data to the heap
    var d = UserData(node: node, vi: vi)
    var data1 = cast[ptr UserData]( alloc0(sizeof(d)) )
    data1[] = d  

    let deps = VSFilterDependency(source: d.node, 
                                  requestpattern: rpGeneral.cint)
    var data2 = cast[ptr VSFilterDependency]( alloc0(sizeof(deps)) )
    data2[] = deps

    vsapi.createVideoFilter(
            outClip,           # ptr VSMap
            filterName.cstring,  # cstring, 
            d.vi,              # ptr VSVideoInfo
            filterGetFrame,    # VSFilterGetFrame
            filterFree,        # VSFilterFree
            fmParallel.cint,   # cint
            data2,             # ptr VSFilterDependency
            1.cint,            # cint
            data1,             # ptr FilterDataObj
            core )             # ptr VSCore
