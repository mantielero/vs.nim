import vs
let clip = source("2sec.mkv")# [0..100]
echo clip
let c2 = clip * 3
echo "ok"
var nframes = (clip * 3).saveY4M("demo.y4m") 
echo nframes, " frames written to 'demo.y4m'"
