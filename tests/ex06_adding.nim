import vs
var c1 = source("2sec.mkv")# [0..100]
#echo c1
var c2 = source("2sec.mkv")# [101..200]
var nframes = (c1 + c2).saveY4M("demo.y4m")
echo nframes, " frames written to 'demo.y4m'"