#[
registerFunction: PENDING

]#
import ../wrapper/vapoursynth4
import libapi, helper, libvsmap
import std/[strutils]

type
  VSPluginObj* = object
    handle*:ptr VSPlugin # ptr Vsplugin
  VSPluginFunctionObj* = object
    handle*:ptr VSPluginFunction

  Argument* = tuple[name:string, typ:string, optional:bool] # Function arguments
  ReturnArgument* = tuple[name:string, typ:string]

iterator plugins*():VSPluginObj =
  ## Iterate over all the plugins available in the system
  var plugin:VSPluginObj
  plugin.handle = api.handle.getNextPlugin(nil, core.handle)
  while plugin.handle != nil:
    yield plugin
    plugin.handle = api.handle.getNextPlugin(plugin.handle, core.handle )


proc name*(plugin:VSPluginObj):string =
  $api.handle.getPluginName(plugin.handle)

proc id*(plugin:VSPluginObj):string =
  $api.handle.getPluginID(plugin.handle)

proc nameSpace*(plugin:VSPluginObj):string =
  $api.handle.getPluginNamespace(plugin.handle)

proc path*(plugin:VSPluginObj):string =
  $api.handle.getPluginPath(plugin.handle)

proc version*(plugin:VSPluginObj):int =
  api.handle.getPluginVersion(plugin.handle)


proc getPluginById*(id:string):VSPluginObj = 
  result.handle = api.handle.getpluginbyid(id.cstring, core.handle)

proc getPluginByNamespace*(namespace:string):VSPluginObj =
  result.handle = api.handle.getPluginByNamespace(namespace.cstring, core.handle)


# Functions
iterator functions*(plugin:VSPluginObj): VSPluginFunctionObj =
  var function:VSPluginFunctionObj 
  function.handle = api.handle.getNextPluginFunction(nil, plugin.handle )
  while function.handle != nil:
    yield function
    function.handle = api.handle.getNextPluginFunction(function.handle, plugin.handle )  

proc name*(function:VSPluginFunctionObj):string =
  $api.handle.getPluginFunctionName(function.handle)

proc args*(function:VSPluginFunctionObj):seq[Argument] =
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


proc ret*(function:VSPluginFunctionObj):ReturnArgument =
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


proc getFunctionByName*(plugin:VSPluginObj; name:string):VSPluginFunctionObj = 
  result.handle = api.handle.getPluginFunctionByName(name.cstring, plugin.handle)


# Invoke
proc invoke*(plugin:VSPluginObj; name:string; args:VSMapObj):VSMapObj =
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
  result.handle = api.handle.invoke(plugin.handle, name.cstring, args.handle)
