import vs
let 
  s1 = source("../media/2sec.mkv") # 100 frames

let nframes = stackHorizontal(@[s1[0..99],s1[99..0]]).saveY4M("../media/demo.y4m")
echo nframes, " written to '../media/demo.y4m'"