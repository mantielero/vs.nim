import ../../wrapper/vapoursynth4



type
  VSApiObj = object
    handle*: ptr Vsapi 
  VSApiRef* = ref VSApiObj

proc getAPI(major:cint = 4):VSApiRef =
  result = new VSApiRef
  result.handle = getvapoursynthapi(major)

let api* = getAPI()

# proc getApiVersion*():int =
#   api.getApiVersion