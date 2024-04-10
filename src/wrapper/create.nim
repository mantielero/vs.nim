# nim c -d:nodeclguards create
# nim c create
# nim c -d:nodeclguards -d:noopaquetypes create
import futhark,os


# proc renameCb(n, k: string, p = ""): string =
#   echo "----"
#   echo "n: ", n
#   echo "k: ", k
#   echo "p: ", p 
#   if k == "enum":
#     echo "************************"
#     case n
#     of "enum_VSColorFamily": "ColorFamily"
#     else: n
#   else:
#     n



importc:
  outputPath currentSourcePath.parentDir / "vapoursynth4.nim"
  #renameCallback renameCb
  path "/usr/include/vapoursynth/"
  "VapourSynth4.h"


importc:
  outputPath currentSourcePath.parentDir / "vsconstants4.nim"
  path "/usr/include/vapoursynth/"
  "VSConstants4.h"


#[
VapourSynth4.h  VSConstants4.h  VSHelper.h   VSScript.h
VapourSynth.h   VSHelper4.h     VSScript4.h

/usr/lib/libvapoursynth-script.so.0.0.0
/usr/lib/libvapoursynth.so
/usr/lib/vapoursynth/libbestaudiosource.so  /usr/lib/vapoursynth/libffms2.so

]#

