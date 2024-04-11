{.passL:"-lvapoursynth".}
# {.passC:"-I/usr/include/vapoursynth/" .}
#[
The purpose of this code is the generation of interfaces to 
existing plugins.
]#
# when defined(linux):
#   const
#     libname* = "libvapoursynth.so"
# elif defined(windows):
#   const
#     libname* = "vapoursynth.dll"
# else:
#   const
#     libname* = "libvapoursynth.dylib"

import std/[strformat, strutils, os]
import vapoursynth4
import ../lib/[libapi,libcore,libvsplugins]

#let
#  API*  = getVapourSynthAPI(4.cint)
#  CORE* = API.createCore(0)
#include ../wrapper/vsplugins4
# ./vapoursynth4, 
## TODO: I use "VSMapObj" in order to be able to chain functions.
## but it would be better to know the result of invoke, rather than using VSMapObj as an output always.
#let API = getVapourSynthAPI(4.cint)
#let CORE = API.createCore(0)

#include "../wrapper/vsmap4.nim"
#include "../wrapper/vsplugins4.nim"

let KEYWORDS = @["addr", "and", "as", "asm", "bind", "block", "break", "case", "cast",
"concept", "const", "continue", "converter", "defer", "discard",
"distinct", "div", "do", "elif", "else", "end", "enum", "except", "export",
"finally", "for", "from", "func", "if", "import", "in", "include",
"interface", "is", "isnot", "iterator", "let", "macro", "method", "mixin",
"mod", "nil", "not", "notin", "object", "of", "or", "out", "proc", "ptr",
"raise", "ref", "return", "shl", "shr", "static", "template", "try", 
"tuple", "type", "using", "var", "when", "while", "xor", "yield" ]

type
  Plugin = tuple[id:string, namespace:string, description:string]
  #Argument = tuple[name:string, `type`:string, optional:bool]
  Function = tuple[name:string, arguments:seq[Argument]]

proc convertType(`type`:string):string =
  result = case `type`:
           of "int[]":
             "seq[int]"
           of "float[]":
             "seq[float]"
           of "data":
             "string" 
           of "data[]":
             "seq[string]"
           of "vnode":
             "VSNodeObj"   
           of "vnode[]":
             "seq[VSNodeObj]"                          
           of "anode":
             "VSNodeObj"   
           of "anode[]":
             "seq[VSNodeObj]"  
           of "clip":
             "VSNodeObj"
           of "clip[]":
             "seq[VSNodeObj]"
           of "frame":
             "VSFrameObj"             
           of "frame[]":
             "seq[VSFrameObj]"               
           of "func":
             "VSFunctionObj"             
           of "func[]":
             "seq[VSFunctionObj]"             
           else:
             `type`


proc genBodyForFirstArgument(function:VSPluginFunctionObj):string =
  # For the cases where the first argument is clip, we transform it
  # into a VSMap, to allow chaining calls

  # When there are no arguments, we simply return
  if function.args().len == 0:
    return ""  

  # Get the first argument
  result = ""
  let arg = function.args[0]
  var argName = arg.name

  # If it is name after one of Nim's key words, we wrap it in ``
  if argName in KEYWORDS: 
    argName = &"`{argName}`"

  # Get a friendlier name for type
  let newtype = convertType( arg.typ )
  # if argName == "clip":
  #   echo "clip--->",arg.typ
  
  if arg.typ in ["vnode", "vnode[]", "anode", "anode[]"]: # ["clip", "clip[]"]:
    #firstArg &= "\n  let tmpSeq = vsmap.toSeq    # Convert the VSMap into a sequence\n"
    var ident = ""
    var vsmap = "vsmap"
    if arg.optional:
      #if arg.isSome:
        result &= "  if vsmap.isSome:\n"
        ident = "  "
        vsmap = "vsmap.get"
    
    result &= &"  {ident}assert( {vsmap}.len != 0, \"the vsmap should contain at least one item\")\n"                 
    #echo result


    # Just one clip

    if newtype == "VSNodeObj":
      var clip = "clip" #"" #"vnode" # "clip"      
      # if arg.typ == "vnode":
      #   clip = "vnode"
      # elif arg.typ == "anode":
      #   clip = "anode"
      # else:
      #   echo "Checkear línea 122: ", arg.typ
      
      result &= &"  {ident}assert( {vsmap}.len(\"{clip}\") == 1, \"the vsmap should contain one node\")\n"
      if not arg.optional:  # Mandatory
        result &= &"  var {argName} = getFirstNode(vsmap)\n\n" 
      else:
        #result &= &"  if {argName}.isSome: args.{funcName}(\"{arg.name}\", {argName}.get)\n"
        result &= &"  var {argName}:Option[VSNodeObj]\n"
        result &= "  if vsmap.isSome:\n"
        result &= &"    {argName} = getFirstNode(vsmap.get).some\n\n"
    
    # For a sequence of clips in the first argument
    # TODO: to extract all nodes in the list and add it to the new map
    elif newtype == "seq[VSNodeObj]":
      var clip = "clips"           
      result &= &"  {ident}assert( {vsmap}.len(\"{clip}\") >= 1, \"the vsmap should contain a seq with nodes\")\n"

      if not arg.optional:
        result &= &"  var {argName} = getFirstNodes(vsmap)\n\n"            
      else:
        result &= &"  var {argName}:seq[VSNodeObj]\n"
        result &= &"  if vsmap.isSome:\n"        
        result &= &"    {argName} = getFirstNodes(vsmap.get)\n\n"



proc genBodyForOtherArguments(function:VSPluginFunctionObj; ini=1):string =
  if function.args.len <= 1:
    return ""   

  # Get other arguments
  result = ""
  let args = function.args
  if args.len > 1:
    for arg in args[ini..high(args)]:
      #let arg = function.arguments[0]
      var argName = arg.name
      if argName in KEYWORDS: 
        argName = &"`{argName}`"
      let newtype = convertType( arg.typ )
      let funcName = case newtype:
                    of "seq[int]", "seq[float]":
                      "append"
                    else:
                      "append"
      # If the argument is a sequence
      if newtype[0..2] == "seq" and funcName != "set":
        if not arg.optional:
          result &= &"  for item in {argName}:\n"
          result &= &"    args.{funcName}(\"{arg.name}\", item)\n"     
        else:
          result &= &"  if {argName}.isSome:\n"
          result &= &"    for item in {argName}.get:\n"
          result &= &"      args.{funcName}(\"{arg.name}\", item)\n"  
    
      else: 
        if not arg.optional:
          result &= &"  args.{funcName}(\"{arg.name}\", {argName})\n"     
        else:
          result &= &"  if {argName}.isSome: args.{funcName}(\"{arg.name}\", {argName}.get)\n"  




proc addFirstArgument(function:VSPluginFunctionObj):string =
  if function.args.len == 0:
    return ""
  #echo function.args[0].typ
  if not (function.args[0].typ in ["clip", "clip[]","vnode", "vnode[]","anode","anode[]"]):
    return ""
  let arg = function.args[0]
  var argName = arg.name
  if argName in KEYWORDS: 
    argName = &"`{argName}`"
  var ident = ""

  # If the first argument is optional
  if arg.optional:
    result = "  if vsmap.isSome:\n"
    ident = "  "

  if function.args[0].typ in ["clip", "vnode", "anode"]:
    if arg.optional:
      result &= &"  {ident}args.append(\"{arg.name}\", {argName}.get)"
    else:
      result &= &"  {ident}args.append(\"{arg.name}\", {argName})"
  else:
    result &= &"  {ident}for item in {argName}:\n"
    result &= &"    {ident}args.append(\"{arg.name}\", item)\n"
    #retun tmp #&"  args.append(\"{arg.name}\", {argName})"





proc genSignature(function:VSPluginFunctionObj):string =
  ## creates a plugin's function signature 
  
  # function name
  var fname = function.name
  fname[0] = fname[0].toLowerAscii()
  result = &"proc {fname}*("
  var nSpaces = result.len
  
  # iterate over all arguments
  var flagFirstArgument = true
  for arg in function.args:
    var argName = arg.name
    # If the argument is a Nim keyword, then enclused between "`" symbol.
    if argName in KEYWORDS: 
      argName = &"`{argName}`"

    # Get the appropriate Nim type from the VapourSynth type
    var newtype = convertType( arg.typ )
    if not flagFirstArgument:  # If not first argument the symbol is added
      result &= ";\n" & repeat(' ', nSpaces)
      # if arg.optional: 
      #   result &= "; "
      # else:
      #   result &= ", "        

    # If the first argument is "clip" or "clip[]"
    if arg.typ in @["vnode", "vnode[]", "anode", "anode[]"] and flagFirstArgument:
      argName = "vsmap"
      newtype = "VSMapObj"
    if not arg.optional: # Mandatory
      result &= &"{argName}:{newtype}"
    else:  # Optional
      result &= &"{argName}= none({newtype})"
    flagFirstArgument = false

  result &= "):VSMapObj =\n"



proc genFunction(plugin:VSPluginObj, function:VSPluginFunctionObj):string =     
  ## creates a helper for a plugin's function        

  # Get the arguments
  let func_signature = genSignature(function)

  let body_first_argument = genBodyForFirstArgument(function)
  let add_first_argument = addFirstArgument(function)
  var ini = 1
  if add_first_argument == "":
    ini = 0
  let body_other_arguments = genBodyForOtherArguments(function, ini)    
  result &= &"""
{func_signature}
  let plug = getPluginById("{plugin.id}")
  assert( plug.handle != nil, "plugin \"{plugin.id}\" not installed properly in your computer") 
{body_first_argument}
  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
{add_first_argument}
{body_other_arguments}
  result.handle = api.handle.invoke(plug.handle, "{function.name}".cstring, args.handle)
  #API.freeMap(args)
"""


proc main =
  discard existsOrCreateDir("../plugins4")
  var includes = """import options

"""

  for plugin in plugins():
    var source = "import options\n"
    source &= "import ../lib/[libvsmap,libvsnode,libvsframe,libvsfunction,libvsplugins, libapi, libvsanode]\n\n"
    for function in functions(plugin):
      source &= genFunction(plugin, function)
      source &= "\n\n"

    #if plugin.namespace == "resize":


    let name = &"../plugins4/{plugin.namespace}.nim"
    writeFile(name, source)
    echo "[INFO] Written file: ", name
    includes &= &"import {plugin.namespace}\n"
    includes &= &"export {plugin.namespace}\n"



  writeFile("../plugins4/all_plugins.nim", includes)
  echo "Written file: ", "../plugins4/all_plugins.nim"  

main()