import vs
proc main =
  let clip = source("../media/2sec.mkv")# [0..100]
  let c2 = clip * 3
  var nframes = (clip * 3).saveY4M("../media/demo.y4m") 
  echo nframes, " frames written to '../media/demo.y4m'"
  echo clip
main()