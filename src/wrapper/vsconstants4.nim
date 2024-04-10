
from macros import hint

when not declared(enumvscolorrange):
  type
    enumvscolorrange* {.size: sizeof(cuint).} = enum
      Vscrangefull = 0, Vscrangelimited = 1
else:
  static :
    hint("Declaration of " & "enumvscolorrange" &
        " already exists, not redeclaring")
when not declared(enumvschromalocation):
  type
    enumvschromalocation* {.size: sizeof(cuint).} = enum
      Vscchromaleft = 0, Vscchromacenter = 1, Vscchromatopleft = 2,
      Vscchromatop = 3, Vscchromabottomleft = 4, Vscchromabottom = 5
else:
  static :
    hint("Declaration of " & "enumvschromalocation" &
        " already exists, not redeclaring")
when not declared(enumvsfieldbased):
  type
    enumvsfieldbased* {.size: sizeof(cuint).} = enum
      Vscfieldprogressive = 0, Vscfieldbottom = 1, Vscfieldtop = 2
else:
  static :
    hint("Declaration of " & "enumvsfieldbased" &
        " already exists, not redeclaring")
when not declared(enumvsmatrixcoefficients):
  type
    enumvsmatrixcoefficients* {.size: sizeof(cuint).} = enum
      Vscmatrixrgb = 0, Vscmatrixbt709 = 1, Vscmatrixunspecified = 2,
      Vscmatrixfcc = 4, Vscmatrixbt470bg = 5, Vscmatrixst170m = 6,
      Vscmatrixst240m = 7, Vscmatrixycgco = 8, Vscmatrixbt2020ncl = 9,
      Vscmatrixbt2020cl = 10, Vscmatrixchromaticityderivedncl = 12,
      Vscmatrixchromaticityderivedcl = 13, Vscmatrixictcp = 14
else:
  static :
    hint("Declaration of " & "enumvsmatrixcoefficients" &
        " already exists, not redeclaring")
when not declared(enumvstransfercharacteristics):
  type
    enumvstransfercharacteristics* {.size: sizeof(cuint).} = enum
      Vsctransferbt709 = 1, Vsctransferunspecified = 2, Vsctransferbt470m = 4,
      Vsctransferbt470bg = 5, Vsctransferbt601 = 6, Vsctransferst240m = 7,
      Vsctransferlinear = 8, Vsctransferlog100 = 9, Vsctransferlog316 = 10,
      Vsctransferiec6196624 = 11, Vsctransferiec6196621 = 13,
      Vsctransferbt202010 = 14, Vsctransferbt202012 = 15,
      Vsctransferst2084 = 16, Vsctransferst428 = 17, Vsctransferaribb67 = 18
else:
  static :
    hint("Declaration of " & "enumvstransfercharacteristics" &
        " already exists, not redeclaring")
when not declared(enumvscolorprimaries):
  type
    enumvscolorprimaries* {.size: sizeof(cuint).} = enum
      Vscprimariesbt709 = 1, Vscprimariesunspecified = 2,
      Vscprimariesbt470m = 4, Vscprimariesbt470bg = 5, Vscprimariesst170m = 6,
      Vscprimariesst240m = 7, Vscprimariesfilm = 8, Vscprimariesbt2020 = 9,
      Vscprimariesst428 = 10, Vscprimariesst4312 = 11, Vscprimariesst4321 = 12,
      Vscprimariesebu3213e = 22
else:
  static :
    hint("Declaration of " & "enumvscolorprimaries" &
        " already exists, not redeclaring")
type
  Vscolorrange_520095065 = enumvscolorrange_520095064 ## Generated based on /usr/include/vapoursynth/VSConstants4.h:27:3
  Vschromalocation_520095069 = enumvschromalocation_520095068 ## Generated based on /usr/include/vapoursynth/VSConstants4.h:36:3
  Vsfieldbased_520095073 = enumvsfieldbased_520095072 ## Generated based on /usr/include/vapoursynth/VSConstants4.h:42:3
  Vsmatrixcoefficients_520095077 = enumvsmatrixcoefficients_520095076 ## Generated based on /usr/include/vapoursynth/VSConstants4.h:58:3
  Vstransfercharacteristics_520095081 = enumvstransfercharacteristics_520095080 ## Generated based on /usr/include/vapoursynth/VSConstants4.h:77:3
  Vscolorprimaries_520095085 = enumvscolorprimaries_520095084 ## Generated based on /usr/include/vapoursynth/VSConstants4.h:92:3
  enumvsmatrixcoefficients_520095076 = (when declared(enumvsmatrixcoefficients):
    enumvsmatrixcoefficients
   else:
    enumvsmatrixcoefficients_520095075)
  enumvscolorrange_520095064 = (when declared(enumvscolorrange):
    enumvscolorrange
   else:
    enumvscolorrange_520095062)
  Vsfieldbased_520095074 = (when declared(Vsfieldbased):
    Vsfieldbased
   else:
    Vsfieldbased_520095073)
  Vschromalocation_520095070 = (when declared(Vschromalocation):
    Vschromalocation
   else:
    Vschromalocation_520095069)
  enumvscolorprimaries_520095084 = (when declared(enumvscolorprimaries):
    enumvscolorprimaries
   else:
    enumvscolorprimaries_520095083)
  Vsmatrixcoefficients_520095078 = (when declared(Vsmatrixcoefficients):
    Vsmatrixcoefficients
   else:
    Vsmatrixcoefficients_520095077)
  Vscolorprimaries_520095086 = (when declared(Vscolorprimaries):
    Vscolorprimaries
   else:
    Vscolorprimaries_520095085)
  enumvstransfercharacteristics_520095080 = (when declared(
      enumvstransfercharacteristics):
    enumvstransfercharacteristics
   else:
    enumvstransfercharacteristics_520095079)
  Vscolorrange_520095066 = (when declared(Vscolorrange):
    Vscolorrange
   else:
    Vscolorrange_520095065)
  Vstransfercharacteristics_520095082 = (when declared(Vstransfercharacteristics):
    Vstransfercharacteristics
   else:
    Vstransfercharacteristics_520095081)
  enumvsfieldbased_520095072 = (when declared(enumvsfieldbased):
    enumvsfieldbased
   else:
    enumvsfieldbased_520095071)
  enumvschromalocation_520095068 = (when declared(enumvschromalocation):
    enumvschromalocation
   else:
    enumvschromalocation_520095067)
when not declared(Vsfieldbased):
  type
    Vsfieldbased* = Vsfieldbased_520095073
else:
  static :
    hint("Declaration of " & "Vsfieldbased" & " already exists, not redeclaring")
when not declared(Vschromalocation):
  type
    Vschromalocation* = Vschromalocation_520095069
else:
  static :
    hint("Declaration of " & "Vschromalocation" &
        " already exists, not redeclaring")
when not declared(Vsmatrixcoefficients):
  type
    Vsmatrixcoefficients* = Vsmatrixcoefficients_520095077
else:
  static :
    hint("Declaration of " & "Vsmatrixcoefficients" &
        " already exists, not redeclaring")
when not declared(Vscolorprimaries):
  type
    Vscolorprimaries* = Vscolorprimaries_520095085
else:
  static :
    hint("Declaration of " & "Vscolorprimaries" &
        " already exists, not redeclaring")
when not declared(Vscolorrange):
  type
    Vscolorrange* = Vscolorrange_520095065
else:
  static :
    hint("Declaration of " & "Vscolorrange" & " already exists, not redeclaring")
when not declared(Vstransfercharacteristics):
  type
    Vstransfercharacteristics* = Vstransfercharacteristics_520095081
else:
  static :
    hint("Declaration of " & "Vstransfercharacteristics" &
        " already exists, not redeclaring")