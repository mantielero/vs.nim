
type
  enumvscolorfamily* {.size: sizeof(cuint).} = enum
    cfundefined = 0, cfgray = 1, cfrgb = 2, cfyuv = 3
type
  enumvssampletype* {.size: sizeof(cuint).} = enum
    stinteger = 0, stfloat = 1
type
  enumvspresetvideoformat* {.size: sizeof(cuint).} = enum
    pfnone = 0, pfgray8 = 268959744, pfgray9 = 269025280, pfgray10 = 269090816,
    pfgray12 = 269221888, pfgray14 = 269352960, pfgray16 = 269484032,
    pfgray32 = 270532608, pfgrayh = 286261248, pfgrays = 287309824,
    pfrgb24 = 537395200, pfrgb27 = 537460736, pfrgb30 = 537526272,
    pfrgb36 = 537657344, pfrgb42 = 537788416, pfrgb48 = 537919488,
    pfrgbh = 554696704, pfrgbs = 555745280, pfyuv444p8 = 805830656,
    pfyuv440p8 = 805830657, pfyuv422p8 = 805830912, pfyuv420p8 = 805830913,
    pfyuv411p8 = 805831168, pfyuv410p8 = 805831170, pfyuv444p9 = 805896192,
    pfyuv422p9 = 805896448, pfyuv420p9 = 805896449, pfyuv444p10 = 805961728,
    pfyuv422p10 = 805961984, pfyuv420p10 = 805961985, pfyuv444p12 = 806092800,
    pfyuv422p12 = 806093056, pfyuv420p12 = 806093057, pfyuv444p14 = 806223872,
    pfyuv422p14 = 806224128, pfyuv420p14 = 806224129, pfyuv444p16 = 806354944,
    pfyuv422p16 = 806355200, pfyuv420p16 = 806355201, pfyuv444ph = 823132160,
    pfyuv444ps = 824180736
type
  enumvsfiltermode* {.size: sizeof(cuint).} = enum
    fmparallel = 0, fmparallelrequests = 1, fmunordered = 2, fmframestate = 3
type
  enumvsmediatype* {.size: sizeof(cuint).} = enum
    mtvideo = 1, mtaudio = 2
type
  enumvsaudiochannels* {.size: sizeof(cuint).} = enum
    acfrontleft = 0, acfrontright = 1, acfrontcenter = 2, aclowfrequency = 3,
    acbackleft = 4, acbackright = 5, acfrontleftofcenter = 6,
    acfrontrightofcenter = 7, acbackcenter = 8, acsideleft = 9,
    acsideright = 10, actopcenter = 11, actopfrontleft = 12,
    actopfrontcenter = 13, actopfrontright = 14, actopbackleft = 15,
    actopbackcenter = 16, actopbackright = 17, acstereoleft = 29,
    acstereoright = 30, acwideleft = 31, acwideright = 32,
    acsurrounddirectleft = 33, acsurrounddirectright = 34, aclowfrequency2 = 35
type
  enumvspropertytype* {.size: sizeof(cuint).} = enum
    ptunset = 0, ptint = 1, ptfloat = 2, ptdata = 3, ptfunction = 4,
    ptvideonode = 5, ptaudionode = 6, ptvideoframe = 7, ptaudioframe = 8
type
  enumvsmappropertyerror* {.size: sizeof(cuint).} = enum
    pesuccess = 0, peunset = 1, petype = 2, peerror = 3, peindex = 4
type
  enumvsmapappendmode* {.size: sizeof(cuint).} = enum
    mareplace = 0, maappend = 1
type
  enumvsactivationreason* {.size: sizeof(cint).} = enum
    arerror = -1, arinitial = 0, arallframesready = 1
type
  enumvsmessagetype* {.size: sizeof(cuint).} = enum
    mtdebug = 0, mtinformation = 1, mtwarning = 2, mtcritical = 3, mtfatal = 4
type
  enumvscorecreationflags* {.size: sizeof(cuint).} = enum
    ccfenablegraphinspection = 1, ccfdisableautoloading = 2,
    ccfdisablelibraryunloading = 4
type
  enumvspluginconfigflags* {.size: sizeof(cuint).} = enum
    pcmodifiable = 1
type
  enumvsdatatypehint* {.size: sizeof(cint).} = enum
    dtunknown = -1, dtbinary = 0, dtutf8 = 1
type
  enumvsrequestpattern* {.size: sizeof(cuint).} = enum
    rpgeneral = 0, rpnoframereuse = 1, rpstrictspatial = 2,
    rpframereuselastonly = 3
type
  enumvscachemode* {.size: sizeof(cint).} = enum
    cmauto = -1, cmforcedisable = 0, cmforceenable = 1
type
  structvsframecontext* = distinct object
type
  structvsloghandle* = distinct object
type
  structvsmap* = distinct object
type
  structvscore* = distinct object
type
  structvspluginfunction* = distinct object
type
  structvsfunction* = distinct object
type
  structvsnode* = distinct object
type
  structvsplugin* = distinct object
type
  structvsframe* = distinct object
type
  Vsframe* = structvsframe   ## Generated based on /usr/include/vapoursynth/VapourSynth4.h:68:24
  Vsnode* = structvsnode     ## Generated based on /usr/include/vapoursynth/VapourSynth4.h:69:23
  Vscore* = structvscore     ## Generated based on /usr/include/vapoursynth/VapourSynth4.h:70:23
  Vsplugin* = structvsplugin ## Generated based on /usr/include/vapoursynth/VapourSynth4.h:71:25
  Vspluginfunction* = structvspluginfunction ## Generated based on /usr/include/vapoursynth/VapourSynth4.h:72:33
  Vsfunction* = structvsfunction ## Generated based on /usr/include/vapoursynth/VapourSynth4.h:73:27
  Vsmap* = structvsmap       ## Generated based on /usr/include/vapoursynth/VapourSynth4.h:74:22
  Vsloghandle* = structvsloghandle ## Generated based on /usr/include/vapoursynth/VapourSynth4.h:75:28
  Vsframecontext* = structvsframecontext ## Generated based on /usr/include/vapoursynth/VapourSynth4.h:76:31
  Vspluginapi* = structvspluginapi ## Generated based on /usr/include/vapoursynth/VapourSynth4.h:328:3
  structvspluginapi* {.pure, inheritable, bycopy.} = object
    getapiversion*: proc (): cint {.cdecl.} ## Generated based on /usr/include/vapoursynth/VapourSynth4.h:324:16
    configplugin*: proc (a0: cstring; a1: cstring; a2: cstring; a3: cint;
                         a4: cint; a5: cint; a6: ptr Vsplugin): cint {.cdecl.}
    registerfunction*: proc (a0: cstring; a1: cstring; a2: cstring;
                             a3: Vspublicfunction; a4: pointer; a5: ptr Vsplugin): cint {.
        cdecl.}

  Vsapi* = structvsapi       ## Generated based on /usr/include/vapoursynth/VapourSynth4.h:78:22
  structvsapi* {.pure, inheritable, bycopy.} = object
    createvideofilter*: proc (a0: ptr Vsmap; a1: cstring; a2: ptr Vsvideoinfo;
                              a3: Vsfiltergetframe; a4: Vsfilterfree; a5: cint;
                              a6: ptr Vsfilterdependency; a7: cint; a8: pointer;
                              a9: ptr Vscore): void {.cdecl.} ## Generated based on /usr/include/vapoursynth/VapourSynth4.h:335:8
    createvideofilter2*: proc (a0: cstring; a1: ptr Vsvideoinfo;
                               a2: Vsfiltergetframe; a3: Vsfilterfree; a4: cint;
                               a5: ptr Vsfilterdependency; a6: cint;
                               a7: pointer; a8: ptr Vscore): ptr Vsnode {.cdecl.}
    createaudiofilter*: proc (a0: ptr Vsmap; a1: cstring; a2: ptr Vsaudioinfo;
                              a3: Vsfiltergetframe; a4: Vsfilterfree; a5: cint;
                              a6: ptr Vsfilterdependency; a7: cint; a8: pointer;
                              a9: ptr Vscore): void {.cdecl.}
    createaudiofilter2*: proc (a0: cstring; a1: ptr Vsaudioinfo;
                               a2: Vsfiltergetframe; a3: Vsfilterfree; a4: cint;
                               a5: ptr Vsfilterdependency; a6: cint;
                               a7: pointer; a8: ptr Vscore): ptr Vsnode {.cdecl.}
    setlinearfilter*: proc (a0: ptr Vsnode): cint {.cdecl.}
    setcachemode*: proc (a0: ptr Vsnode; a1: cint): void {.cdecl.}
    setcacheoptions*: proc (a0: ptr Vsnode; a1: cint; a2: cint; a3: cint): void {.
        cdecl.}
    freenode*: proc (a0: ptr Vsnode): void {.cdecl.}
    addnoderef*: proc (a0: ptr Vsnode): ptr Vsnode {.cdecl.}
    getnodetype*: proc (a0: ptr Vsnode): cint {.cdecl.}
    getvideoinfo*: proc (a0: ptr Vsnode): ptr Vsvideoinfo {.cdecl.}
    getaudioinfo*: proc (a0: ptr Vsnode): ptr Vsaudioinfo {.cdecl.}
    newvideoframe*: proc (a0: ptr Vsvideoformat; a1: cint; a2: cint;
                          a3: ptr Vsframe; a4: ptr Vscore): ptr Vsframe {.cdecl.}
    newvideoframe2*: proc (a0: ptr Vsvideoformat; a1: cint; a2: cint;
                           a3: ptr ptr Vsframe; a4: ptr cint; a5: ptr Vsframe;
                           a6: ptr Vscore): ptr Vsframe {.cdecl.}
    newaudioframe*: proc (a0: ptr Vsaudioformat; a1: cint; a2: ptr Vsframe;
                          a3: ptr Vscore): ptr Vsframe {.cdecl.}
    newaudioframe2*: proc (a0: ptr Vsaudioformat; a1: cint; a2: ptr ptr Vsframe;
                           a3: ptr cint; a4: ptr Vsframe; a5: ptr Vscore): ptr Vsframe {.
        cdecl.}
    freeframe*: proc (a0: ptr Vsframe): void {.cdecl.}
    addframeref*: proc (a0: ptr Vsframe): ptr Vsframe {.cdecl.}
    copyframe*: proc (a0: ptr Vsframe; a1: ptr Vscore): ptr Vsframe {.cdecl.}
    getframepropertiesro*: proc (a0: ptr Vsframe): ptr Vsmap {.cdecl.}
    getframepropertiesrw*: proc (a0: ptr Vsframe): ptr Vsmap {.cdecl.}
    getstride*: proc (a0: ptr Vsframe; a1: cint): ptrdifft {.cdecl.}
    getreadptr*: proc (a0: ptr Vsframe; a1: cint): ptr uint8 {.cdecl.}
    getwriteptr*: proc (a0: ptr Vsframe; a1: cint): ptr uint8 {.cdecl.}
    getvideoframeformat*: proc (a0: ptr Vsframe): ptr Vsvideoformat {.cdecl.}
    getaudioframeformat*: proc (a0: ptr Vsframe): ptr Vsaudioformat {.cdecl.}
    getframetype*: proc (a0: ptr Vsframe): cint {.cdecl.}
    getframewidth*: proc (a0: ptr Vsframe; a1: cint): cint {.cdecl.}
    getframeheight*: proc (a0: ptr Vsframe; a1: cint): cint {.cdecl.}
    getframelength*: proc (a0: ptr Vsframe): cint {.cdecl.}
    getvideoformatname*: proc (a0: ptr Vsvideoformat; a1: cstring): cint {.cdecl.}
    getaudioformatname*: proc (a0: ptr Vsaudioformat; a1: cstring): cint {.cdecl.}
    queryvideoformat*: proc (a0: ptr Vsvideoformat; a1: cint; a2: cint;
                             a3: cint; a4: cint; a5: cint; a6: ptr Vscore): cint {.
        cdecl.}
    queryaudioformat*: proc (a0: ptr Vsaudioformat; a1: cint; a2: cint;
                             a3: uint64; a4: ptr Vscore): cint {.cdecl.}
    queryvideoformatid*: proc (a0: cint; a1: cint; a2: cint; a3: cint; a4: cint;
                               a5: ptr Vscore): uint32 {.cdecl.}
    getvideoformatbyid*: proc (a0: ptr Vsvideoformat; a1: uint32; a2: ptr Vscore): cint {.
        cdecl.}
    getframe*: proc (a0: cint; a1: ptr Vsnode; a2: cstring; a3: cint): ptr Vsframe {.
        cdecl.}
    getframeasync*: proc (a0: cint; a1: ptr Vsnode; a2: Vsframedonecallback;
                          a3: pointer): void {.cdecl.}
    getframefilter*: proc (a0: cint; a1: ptr Vsnode; a2: ptr Vsframecontext): ptr Vsframe {.
        cdecl.}
    requestframefilter*: proc (a0: cint; a1: ptr Vsnode; a2: ptr Vsframecontext): void {.
        cdecl.}
    releaseframeearly*: proc (a0: ptr Vsnode; a1: cint; a2: ptr Vsframecontext): void {.
        cdecl.}
    cacheframe*: proc (a0: ptr Vsframe; a1: cint; a2: ptr Vsframecontext): void {.
        cdecl.}
    setfiltererror*: proc (a0: cstring; a1: ptr Vsframecontext): void {.cdecl.}
    createfunction*: proc (a0: Vspublicfunction; a1: pointer;
                           a2: Vsfreefunctiondata; a3: ptr Vscore): ptr Vsfunction {.
        cdecl.}
    freefunction*: proc (a0: ptr Vsfunction): void {.cdecl.}
    addfunctionref*: proc (a0: ptr Vsfunction): ptr Vsfunction {.cdecl.}
    callfunction*: proc (a0: ptr Vsfunction; a1: ptr Vsmap; a2: ptr Vsmap): void {.
        cdecl.}
    createmap*: proc (): ptr Vsmap {.cdecl.}
    freemap*: proc (a0: ptr Vsmap): void {.cdecl.}
    clearmap*: proc (a0: ptr Vsmap): void {.cdecl.}
    copymap*: proc (a0: ptr Vsmap; a1: ptr Vsmap): void {.cdecl.}
    mapseterror*: proc (a0: ptr Vsmap; a1: cstring): void {.cdecl.}
    mapgeterror*: proc (a0: ptr Vsmap): cstring {.cdecl.}
    mapnumkeys*: proc (a0: ptr Vsmap): cint {.cdecl.}
    mapgetkey*: proc (a0: ptr Vsmap; a1: cint): cstring {.cdecl.}
    mapdeletekey*: proc (a0: ptr Vsmap; a1: cstring): cint {.cdecl.}
    mapnumelements*: proc (a0: ptr Vsmap; a1: cstring): cint {.cdecl.}
    mapgettype*: proc (a0: ptr Vsmap; a1: cstring): cint {.cdecl.}
    mapsetempty*: proc (a0: ptr Vsmap; a1: cstring; a2: cint): cint {.cdecl.}
    mapgetint*: proc (a0: ptr Vsmap; a1: cstring; a2: cint; a3: ptr cint): int64 {.
        cdecl.}
    mapgetintsaturated*: proc (a0: ptr Vsmap; a1: cstring; a2: cint;
                               a3: ptr cint): cint {.cdecl.}
    mapgetintarray*: proc (a0: ptr Vsmap; a1: cstring; a2: ptr cint): ptr int64 {.
        cdecl.}
    mapsetint*: proc (a0: ptr Vsmap; a1: cstring; a2: int64; a3: cint): cint {.
        cdecl.}
    mapsetintarray*: proc (a0: ptr Vsmap; a1: cstring; a2: ptr int64; a3: cint): cint {.
        cdecl.}
    mapgetfloat*: proc (a0: ptr Vsmap; a1: cstring; a2: cint; a3: ptr cint): cdouble {.
        cdecl.}
    mapgetfloatsaturated*: proc (a0: ptr Vsmap; a1: cstring; a2: cint;
                                 a3: ptr cint): cfloat {.cdecl.}
    mapgetfloatarray*: proc (a0: ptr Vsmap; a1: cstring; a2: ptr cint): ptr cdouble {.
        cdecl.}
    mapsetfloat*: proc (a0: ptr Vsmap; a1: cstring; a2: cdouble; a3: cint): cint {.
        cdecl.}
    mapsetfloatarray*: proc (a0: ptr Vsmap; a1: cstring; a2: ptr cdouble;
                             a3: cint): cint {.cdecl.}
    mapgetdata*: proc (a0: ptr Vsmap; a1: cstring; a2: cint; a3: ptr cint): cstring {.
        cdecl.}
    mapgetdatasize*: proc (a0: ptr Vsmap; a1: cstring; a2: cint; a3: ptr cint): cint {.
        cdecl.}
    mapgetdatatypehint*: proc (a0: ptr Vsmap; a1: cstring; a2: cint;
                               a3: ptr cint): cint {.cdecl.}
    mapsetdata*: proc (a0: ptr Vsmap; a1: cstring; a2: cstring; a3: cint;
                       a4: cint; a5: cint): cint {.cdecl.}
    mapgetnode*: proc (a0: ptr Vsmap; a1: cstring; a2: cint; a3: ptr cint): ptr Vsnode {.
        cdecl.}
    mapsetnode*: proc (a0: ptr Vsmap; a1: cstring; a2: ptr Vsnode; a3: cint): cint {.
        cdecl.}
    mapconsumenode*: proc (a0: ptr Vsmap; a1: cstring; a2: ptr Vsnode; a3: cint): cint {.
        cdecl.}
    mapgetframe*: proc (a0: ptr Vsmap; a1: cstring; a2: cint; a3: ptr cint): ptr Vsframe {.
        cdecl.}
    mapsetframe*: proc (a0: ptr Vsmap; a1: cstring; a2: ptr Vsframe; a3: cint): cint {.
        cdecl.}
    mapconsumeframe*: proc (a0: ptr Vsmap; a1: cstring; a2: ptr Vsframe;
                            a3: cint): cint {.cdecl.}
    mapgetfunction*: proc (a0: ptr Vsmap; a1: cstring; a2: cint; a3: ptr cint): ptr Vsfunction {.
        cdecl.}
    mapsetfunction*: proc (a0: ptr Vsmap; a1: cstring; a2: ptr Vsfunction;
                           a3: cint): cint {.cdecl.}
    mapconsumefunction*: proc (a0: ptr Vsmap; a1: cstring; a2: ptr Vsfunction;
                               a3: cint): cint {.cdecl.}
    registerfunction*: proc (a0: cstring; a1: cstring; a2: cstring;
                             a3: Vspublicfunction; a4: pointer; a5: ptr Vsplugin): cint {.
        cdecl.}
    getpluginbyid*: proc (a0: cstring; a1: ptr Vscore): ptr Vsplugin {.cdecl.}
    getpluginbynamespace*: proc (a0: cstring; a1: ptr Vscore): ptr Vsplugin {.
        cdecl.}
    getnextplugin*: proc (a0: ptr Vsplugin; a1: ptr Vscore): ptr Vsplugin {.
        cdecl.}
    getpluginname*: proc (a0: ptr Vsplugin): cstring {.cdecl.}
    getpluginid*: proc (a0: ptr Vsplugin): cstring {.cdecl.}
    getpluginnamespace*: proc (a0: ptr Vsplugin): cstring {.cdecl.}
    getnextpluginfunction*: proc (a0: ptr Vspluginfunction; a1: ptr Vsplugin): ptr Vspluginfunction {.
        cdecl.}
    getpluginfunctionbyname*: proc (a0: cstring; a1: ptr Vsplugin): ptr Vspluginfunction {.
        cdecl.}
    getpluginfunctionname*: proc (a0: ptr Vspluginfunction): cstring {.cdecl.}
    getpluginfunctionarguments*: proc (a0: ptr Vspluginfunction): cstring {.
        cdecl.}
    getpluginfunctionreturntype*: proc (a0: ptr Vspluginfunction): cstring {.
        cdecl.}
    getpluginpath*: proc (a0: ptr Vsplugin): cstring {.cdecl.}
    getpluginversion*: proc (a0: ptr Vsplugin): cint {.cdecl.}
    invoke*: proc (a0: ptr Vsplugin; a1: cstring; a2: ptr Vsmap): ptr Vsmap {.
        cdecl.}
    createcore*: proc (a0: cint): ptr Vscore {.cdecl.}
    freecore*: proc (a0: ptr Vscore): void {.cdecl.}
    setmaxcachesize*: proc (a0: int64; a1: ptr Vscore): int64 {.cdecl.}
    setthreadcount*: proc (a0: cint; a1: ptr Vscore): cint {.cdecl.}
    getcoreinfo*: proc (a0: ptr Vscore; a1: ptr Vscoreinfo): void {.cdecl.}
    getapiversion*: proc (): cint {.cdecl.}
    logmessage*: proc (a0: cint; a1: cstring; a2: ptr Vscore): void {.cdecl.}
    addloghandler*: proc (a0: Vsloghandler; a1: Vsloghandlerfree; a2: pointer;
                          a3: ptr Vscore): ptr Vsloghandle {.cdecl.}
    removeloghandler*: proc (a0: ptr Vsloghandle; a1: ptr Vscore): cint {.cdecl.}
    clearnodecache*: proc (a0: ptr Vsnode): void {.cdecl.}
    clearcorecaches*: proc (a0: ptr Vscore): void {.cdecl.}
    getnodename*: proc (a0: ptr Vsnode): cstring {.cdecl.}
    getnodefiltermode*: proc (a0: ptr Vsnode): cint {.cdecl.}
    getnumnodedependencies*: proc (a0: ptr Vsnode): cint {.cdecl.}
    getnodedependency*: proc (a0: ptr Vsnode; a1: cint): ptr Vsfilterdependency {.
        cdecl.}
    getcorenodetiming*: proc (a0: ptr Vscore): cint {.cdecl.}
    setcorenodetiming*: proc (a0: ptr Vscore; a1: cint): void {.cdecl.}
    getnodeprocessingtime*: proc (a0: ptr Vsnode; a1: cint): int64 {.cdecl.}
    getfreednodeprocessingtime*: proc (a0: ptr Vscore; a1: cint): int64 {.cdecl.}

  Vscolorfamily* = enumvscolorfamily ## Generated based on /usr/include/vapoursynth/VapourSynth4.h:85:3
  Vssampletype* = enumvssampletype ## Generated based on /usr/include/vapoursynth/VapourSynth4.h:90:3
  Vspresetvideoformat* = enumvspresetvideoformat ## Generated based on /usr/include/vapoursynth/VapourSynth4.h:148:3
  Vsfiltermode* = enumvsfiltermode ## Generated based on /usr/include/vapoursynth/VapourSynth4.h:158:3
  Vsmediatype* = enumvsmediatype ## Generated based on /usr/include/vapoursynth/VapourSynth4.h:163:3
  structvsvideoformat* {.pure, inheritable, bycopy.} = object
    colorfamily*: cint       ## Generated based on /usr/include/vapoursynth/VapourSynth4.h:165:16
    sampletype*: cint
    bitspersample*: cint
    bytespersample*: cint
    subsamplingw*: cint
    subsamplingh*: cint
    numplanes*: cint

  Vsvideoformat* = structvsvideoformat ## Generated based on /usr/include/vapoursynth/VapourSynth4.h:175:3
  Vsaudiochannels* = enumvsaudiochannels ## Generated based on /usr/include/vapoursynth/VapourSynth4.h:203:3
  structvsaudioformat* {.pure, inheritable, bycopy.} = object
    sampletype*: cint        ## Generated based on /usr/include/vapoursynth/VapourSynth4.h:205:16
    bitspersample*: cint
    bytespersample*: cint
    numchannels*: cint
    channellayout*: uint64

  Vsaudioformat* = structvsaudioformat ## Generated based on /usr/include/vapoursynth/VapourSynth4.h:211:3
  Vspropertytype* = enumvspropertytype ## Generated based on /usr/include/vapoursynth/VapourSynth4.h:223:3
  Vsmappropertyerror* = enumvsmappropertyerror ## Generated based on /usr/include/vapoursynth/VapourSynth4.h:231:3
  Vsmapappendmode* = enumvsmapappendmode ## Generated based on /usr/include/vapoursynth/VapourSynth4.h:236:3
  structvscoreinfo* {.pure, inheritable, bycopy.} = object
    versionstring*: cstring  ## Generated based on /usr/include/vapoursynth/VapourSynth4.h:238:16
    core*: cint
    api*: cint
    numthreads*: cint
    maxframebuffersize*: int64
    usedframebuffersize*: int64

  Vscoreinfo* = structvscoreinfo ## Generated based on /usr/include/vapoursynth/VapourSynth4.h:245:3
  structvsvideoinfo* {.pure, inheritable, bycopy.} = object
    format*: Vsvideoformat   ## Generated based on /usr/include/vapoursynth/VapourSynth4.h:247:16
    fpsnum*: int64
    fpsden*: int64
    width*: cint
    height*: cint
    numframes*: cint

  Vsvideoinfo* = structvsvideoinfo ## Generated based on /usr/include/vapoursynth/VapourSynth4.h:254:3
  structvsaudioinfo* {.pure, inheritable, bycopy.} = object
    format*: Vsaudioformat   ## Generated based on /usr/include/vapoursynth/VapourSynth4.h:256:16
    samplerate*: cint
    numsamples*: int64
    numframes*: cint

  Vsaudioinfo* = structvsaudioinfo ## Generated based on /usr/include/vapoursynth/VapourSynth4.h:261:3
  Vsactivationreason* = enumvsactivationreason ## Generated based on /usr/include/vapoursynth/VapourSynth4.h:267:3
  Vsmessagetype* = enumvsmessagetype ## Generated based on /usr/include/vapoursynth/VapourSynth4.h:275:3
  Vscorecreationflags* = enumvscorecreationflags ## Generated based on /usr/include/vapoursynth/VapourSynth4.h:281:3
  Vspluginconfigflags* = enumvspluginconfigflags ## Generated based on /usr/include/vapoursynth/VapourSynth4.h:285:3
  Vsdatatypehint* = enumvsdatatypehint ## Generated based on /usr/include/vapoursynth/VapourSynth4.h:291:3
  Vsrequestpattern* = enumvsrequestpattern ## Generated based on /usr/include/vapoursynth/VapourSynth4.h:301:3
  Vscachemode* = enumvscachemode ## Generated based on /usr/include/vapoursynth/VapourSynth4.h:307:3
  Vsgetvapoursynthapi* = proc (a0: cint): ptr Vsapi {.cdecl.} ## Generated based on /usr/include/vapoursynth/VapourSynth4.h:310:30
  Vspublicfunction* = proc (a0: ptr Vsmap; a1: ptr Vsmap; a2: pointer;
                            a3: ptr Vscore; a4: ptr Vsapi): void {.cdecl.} ## Generated based on /usr/include/vapoursynth/VapourSynth4.h:313:22
  Vsinitplugin* = proc (a0: ptr Vsplugin; a1: ptr Vspluginapi): void {.cdecl.} ## Generated based on /usr/include/vapoursynth/VapourSynth4.h:314:22
  Vsfreefunctiondata* = proc (a0: pointer): void {.cdecl.} ## Generated based on /usr/include/vapoursynth/VapourSynth4.h:315:22
  Vsfiltergetframe* = proc (a0: cint; a1: cint; a2: pointer; a3: ptr pointer;
                            a4: ptr Vsframecontext; a5: ptr Vscore;
                            a6: ptr Vsapi): ptr Vsframe {.cdecl.} ## Generated based on /usr/include/vapoursynth/VapourSynth4.h:316:32
  Vsfilterfree* = proc (a0: pointer; a1: ptr Vscore; a2: ptr Vsapi): void {.
      cdecl.}                ## Generated based on /usr/include/vapoursynth/VapourSynth4.h:317:22
  Vsframedonecallback* = proc (a0: pointer; a1: ptr Vsframe; a2: cint;
                               a3: ptr Vsnode; a4: cstring): void {.cdecl.} ## Generated based on /usr/include/vapoursynth/VapourSynth4.h:320:22
  Vsloghandler* = proc (a0: cint; a1: cstring; a2: pointer): void {.cdecl.} ## Generated based on /usr/include/vapoursynth/VapourSynth4.h:321:22
  Vsloghandlerfree* = proc (a0: pointer): void {.cdecl.} ## Generated based on /usr/include/vapoursynth/VapourSynth4.h:322:22
  structvsfilterdependency* {.pure, inheritable, bycopy.} = object
    source*: ptr Vsnode      ## Generated based on /usr/include/vapoursynth/VapourSynth4.h:330:16
    requestpattern*: cint

  Vsfilterdependency* = structvsfilterdependency ## Generated based on /usr/include/vapoursynth/VapourSynth4.h:333:3
  ptrdifft* = clong          ## Generated based on /usr/lib/clang/17/include/stddef.h:35:26
when 4 is static:
  const
    Vapoursynthapimajor* = 4 ## Generated based on /usr/include/vapoursynth/VapourSynth4.h:28:9
else:
  let Vapoursynthapimajor* = 4 ## Generated based on /usr/include/vapoursynth/VapourSynth4.h:28:9
when 1 is static:
  const
    Vapoursynthapiminor* = 1 ## Generated based on /usr/include/vapoursynth/VapourSynth4.h:29:9
else:
  let Vapoursynthapiminor* = 1 ## Generated based on /usr/include/vapoursynth/VapourSynth4.h:29:9
when 3072 is static:
  const
    Vsaudioframesamples* = 3072 ## Generated based on /usr/include/vapoursynth/VapourSynth4.h:32:9
else:
  let Vsaudioframesamples* = 3072 ## Generated based on /usr/include/vapoursynth/VapourSynth4.h:32:9
proc getvapoursynthapi*(version: cint): ptr Vsapi {.cdecl,
    importc: "getVapourSynthAPI".}