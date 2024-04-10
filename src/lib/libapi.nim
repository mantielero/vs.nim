import ../wrapper/vapoursynth4



type
  VSApiObj* = object
    handle*: ptr Vsapi 


proc getAPI*(major:cint = 4):VSApiObj =
  result.handle = getvapoursynthapi(major)

let api* = getAPI()





#[
echo getVersionString()
echo getInfoCore()
echo getInfoAPI()         # 262145
echo getInfoNumThreads()  # 16
echo getInfoMaxFrameBufferSize()  # 4294967296
echo getInfoUsedFrameBufferSize() # 0
echo info
]#