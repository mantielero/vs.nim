import vs
proc main =
  let clip = source("2sec.mkv")# [0..100]
  let c2 = clip * 3
  var nframes = (clip * 3).saveY4M("demo.y4m") 
  echo nframes, " frames written to 'demo.y4m'"
  echo clip
main()