import vs
var c1 = source("../media/2sec.mkv")
# echo c1
# echo c1[0..100]
var c2 = source("../media/2sec.mkv")# [101..200]

var nframes = (c1 + c2).saveY4M("../media/demo.y4m")
#var nframes = (c1[0..100] + c1[101..200]).saveY4M("demo.y4m")   # <--- NOT WORKING
echo nframes, " frames written to '../media/demo.y4m'"