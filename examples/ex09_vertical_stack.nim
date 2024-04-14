import vs

let 
  clip = source("../media/2sec.mkv")

let nframes = stackVertical(@[clip[0..99],clip[99..0]]).saveY4M("../media/demo.y4m")
echo nframes, " written to '../media/demo.y4m'"

