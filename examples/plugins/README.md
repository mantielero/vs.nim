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
2. Register the function: [registerFunction](https://vapoursynth.com/doc/api/vapoursynth4.h.html#registerfunction). One of the parameters of this function will be the function used to create a new function; in this case, `filterCreate`.

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

> IMPORTANT: don't forget to use `-d:release` in Nim for the final compilations in order to get faster code.

## ex02.nim / ex02_test.nim
The code can be simplified with the help of metaprogramming. For this we use templates that are defined in `libvsplugins.nim`.

For example a "do-nothing" filter can be created as follows:
```nim
import vs

# This is the name of the function that will be created and assigned to function "Filter"
var filterCreate:FilterCreateTyp 

# Creates the filter, memory management and gets frames
# In the body, the frame processing
createFilter("Filter", filterCreate, FilterDataObj):
  let dstFrame = vsapi.copyFrame(srcFrame, core)  # we just copy source to destination (no processing)

# Initialize the plugin
# - register function "Filter" in the 
initPlugin("com.example.filter", "filter", "VapourSynth Filter Skeleton", (1, 0), 0):
  regFunction("Filter", "clip:vnode;", "clip:vnode;", filterCreate)
```

The created filter can be tested by compiling: `ex02_test.nim`.

If we copy the `libex02.so` file into: `/usr/lib/vapoursynth`, the wrapping function in `ex02_test.nim` can be created for us with the execution `src/wrapper/plugin_generator.nim`:
```nim
nim c -r src/wrapper/plugin_generator.nim
```

