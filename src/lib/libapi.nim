import ../wrapper/vapoursynth4



type
  VSApiObj* = object
    handle*: ptr Vsapi 


proc getAPI*(major:cint = 4):VSApiObj =
  result.handle = getvapoursynthapi(major)

let api* = getAPI()
