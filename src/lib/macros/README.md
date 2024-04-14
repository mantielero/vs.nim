# Filter
## Introduction
Here we have the code that enables creating custom plugins directly from Nim.

## Links
[Writting plugins](http://vapoursynth.com/doc/api/vapoursynth4.h.html#writing-plugins).
[Examples](https://github.com/vapoursynth/vapoursynth/tree/master/sdk)


## How to create a plugin
### VapourSynthPluginInit2
It is mandatory to define this function. It is the plugin entry point. This function is called after the core loads the shared library. Its purpose is to configure the plugin and to register the filters the plugin wants to export.

- plugin:: A pointer to the plugin object to be initialized.
- vspapi:: A pointer to a VSPLUGINAPI struct with a subset of the VapourSynth API used for initializing plugins. The proper way to do things is to call configPlugin and then registerFunction for each function to export.

```nim
proc VapourSynthPluginInit2*(plugin: VSPluginRef, 
                             vsapi: VSApiRef) =
    vspapi.configPlugin( "com.example.filter", 
                         "filter", 
                         "VapourSynth Filter Skeleton", 
                         VS_MAKE_VERSION(1, 0), 
                         VAPOURSYNTH_API_VERSION, 
                         0, 
                         plugin);
    vspapi.registerFunction("Filter", 
                            "clip:vnode;", 
                            "clip:vnode;", 
                            filterCreate, 
                            NULL, 
                            plugin);
```

As you can see it calls `configPlugin` and `registerFunction`.
### registerFunction
Function that registers a filter exported by the plugin. A plugin can export any number of filters. This function may only be called during the plugin loading phase unless the pcModifiable flag was set by configPlugin.
#### name
Filter name. The characters allowed are letters, numbers, and the underscore. The first character must be a letter. In other words: `^[a-zA-Z][a-zA-Z0-9_]*$`

Filter names should be PascalCase.

#### args
String containing the filter’s list of arguments.

Arguments are separated by a semicolon. Each argument is made of several fields separated by a colon. Don’t insert additional whitespace characters, or VapourSynth will die.

Fields:
The argument name.
The same characters are allowed as for the filter’s name. Argument names should be all lowercase and use only letters and the underscore.

The type.
“int”: int64_t

“float”: double

“data”: const char*

“anode”: const VSNode* (audio type)

“vnode”: const VSNode* (video type)

“aframe”: const VSFrame* (audio type)

“vframe”: const VSFrame* (video type)

“func”: const VSFunctionRef*

It is possible to declare an array by appending “[]” to the type.

“opt”
If the parameter is optional.

“empty”
For arrays that are allowed to be empty.

“any”
Can only be placed last without a semicolon after. Indicates that all remaining arguments that don’t match should also be passed through.

The following example declares the arguments “blah”, “moo”, and “asdf”:

blah:vnode;moo:int[]:opt;asdf:float:opt;
The following example declares the arguments “blah” and accepts all other arguments no matter the type:

blah:vnode;any
#### returnType
Specifies works similarly to args but instead specifies which keys and what type will be returned. Typically this will be:

clip:vnode;
for video filters. It is important to not simply specify “any” for all filters since this information is used for better auto-completion in many editors.

#### argsFunc
typedef void (VS_CC *VSPublicFunction)(const VSMap *in, VSMap *out, void *userData, VSCore *core, const VSAPI *vsapi)

User-defined function called by the core to create an instance of the filter. This function is often named fooCreate.

In this function, the filter’s input parameters should be retrieved and validated, the filter’s private instance data should be initialised, and createAudioFilter() or createVideoFilter() should be called. This is where the filter should perform any other initialisation it requires.

If for some reason you cannot create the filter, you have to free any created node references using freeNode(), call mapSetError() on out, and return.

in
Input parameter list.

Use mapGetInt() and friends to retrieve a parameter value.

The map is guaranteed to exist only until the filter’s “init” function returns. In other words, pointers returned by mapGetData() will not be usable in the filter’s “getframe” and “free” functions.

out
Output parameter list. createAudioFilter() or createVideoFilter() will add the output node(s) with the key named “clip”, or an error, if something went wrong.

userData
Pointer that was passed to registerFunction().

#### functionData
Pointer to user data that gets passed to argsFunc when creating a filter. Useful to register multiple filters using a single argsFunc function.

##### plugin
Pointer to the plugin object in the core, as passed to VapourSynthPluginInit2().