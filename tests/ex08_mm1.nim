import vs
import std/[strutils]

proc main =
  var c1 = source("2sec.mkv")    # OK
  discard c1.saveY4M("demo.y4m") # OK
  echo c1                        # OK 
  `=destroy`(c1) # shows 'destroying VSMapObj'
  `=wasMoved`(c1)
  echo c1.handle == nil
  echo c1
  #c1.handle = nil
  #echo api.handle.mapNumKeys(c1.handle).int
  #echo c1.handle.isNil # shows 'false'
  #echo cast[int](c1.handle).toHex
  # shows 'destroying VSMapObj' again

main()