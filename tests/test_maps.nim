import vs

echo getVersionString()
echo getInfoCore()
echo getApiVersion()         # 262145
echo getInfoNumThreads()  # 16
echo getInfoMaxFrameBufferSize()  # 4294967296
echo getInfoUsedFrameBufferSize() # 0
#echo info

# vsmap
var d = newMap()
d.append("key", "value")
d.append("number", 3)
d.append("float", 4.2)
d.append("listInts", @[2,3,4,5])
d.append("listFloats", @[2.1,3.1,4.1,5.1])
echo "len: ", d.len
echo "number,0: ", d.propGetInt("number",0)
echo "float,0: ", d.propGetFloat("float",0)


for k in d.keys():
  echo k

d.propDeleteKey("float")
echo "len: ", d.len
for k in d.keys():
  echo k, " ", d.getType(k), " ", d.len(k)

echo "DATA: ", d.propGetData("key",0)
echo "dataSize: ", d.propGetDataSize("key",0)

echo d.propGetIntArray("listInts")
echo d.propGetFloatArray("listFloats")
for item in d.items():
  echo item

# ----
