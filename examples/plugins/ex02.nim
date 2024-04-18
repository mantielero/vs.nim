# Create the filter (in Linux creates "libex02.so")
# nim c --app:lib -d:release ex02  
import vs

# This is the name of the function that will be created and assigned to function "Filter"
var filterCreate:FilterCreateTyp  # it is used in `createFilter` and `regFunction`

# Creates the filter, memory management and gets frames
# In the body, the frame processing
createFilter("Filter", filterCreate, FilterDataObj):
  let dstFrame = vsapi.copyFrame(srcFrame, core)  # we just copy source to destination (no processing)

# Initialize the plugin
# - register function "Filter" in the 
initPlugin("com.example.filter", "filter", "VapourSynth Filter Skeleton", (1, 0), 0):
  regFunction("Filter", "clip:vnode;", "clip:vnode;", filterCreate)


