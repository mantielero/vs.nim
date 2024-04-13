import vs
let 
  s1 = source("../media/2sec.mkv")
  s2 = source("../media/2sec.mkv")

let nframes = stackHorizontal(@[s1,s2]).saveY4M("../media/demo.y4m")
echo nframes, " written to '../media/demo.y4m'"