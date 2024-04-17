# Plugins
## ex01_filter_skeleton.nim 
### Introduction
This is the equivalent to [filter_skeleton.c](https://github.com/vapoursynth/vapoursynth/blob/a228cb91023c72546879a01c16038b7c68f62414/sdk/filter_skeleton.c). It is using pointers, so no advantage over using pure C code here.

The plugin is created by means of executing:
```sh
$ nim c --app:lib ex01_filter_skeleton 
```
In Linux, it will create the plugin file: `libex01_filter_skeleton.so`. 

In order to use it, we run:
```sh
$ nim c -r ex10_custom_filter 
```
It will call the code under `when isMainModule:`. It will:
1. Load the plugin: `loadPlugin("./libex01_custom_filter.so")`
2. Create a helper function to use the `Filter` function defined in the plugin under Nim:
```nim
proc myFilter*(vsmap:VSMapRef):VSMapRef =
  ...
```
3. Execute the helper function `myFilter`: 
```nim
let nframes = source("../../media/2sec.mkv").myFilter.saveY4M("../../media/demo.y4m")
```

### Code explanation
#### VapourSynthPluginInit2
This function initialize the plugin. It requires to use the pragmas `{.cdecl,exportc:"$1",dynlib.}`.

Inside it will:
1. Configure the plugin: `configPlugin`
2. Register the function: `registerFunction`. One of the parameters of this function will be the function used to create a new function; in this case, `filterCreate`.

#### filterCreate
This is the function responsible for creating the filter. 

Here it is created an instance of `FilterDataObj`. The reason for the following:
```nim
var d = FilterDataObj(node: node, vi: vi)
var data1 = cast[ptr FilterDataObj]( alloc0(sizeof(d)) )
data1[] = d  
```
is that the first line creates the instance in the stack, so it would be destroyed once the scope of the function is left. The second line creates an object in the heap (allocates the space), and the third copies the data from the stack to the heap.

Finally, the `createVideoFilter` is called to create the video filter. The most relevant parameters are:
1. The data instance is pass by reference.
2. `filterGetFrame`: this is the function called in order to request/get the frames.
3. `filterFree`: this function is called to deallocated the memory.

#### filterGetFrame
The function `requestFrameFilter` is used to request a frame. Once requested, it can be received using `getFrameFilter`.

The interesing processing takes place after `getFrameFilter`. In this "filter skeleton" we do nothing, we just state:
```nim
# your code here...
```

> Notice that the only function required to be exported `{.exportc, dynlib.}` is VapourSynthPluginInit2.

