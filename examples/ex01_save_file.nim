import vs
var nframes = source("../media/2sec.mkv").saveY4M("../media/demo.y4m")

echo nframes, " frames written to '../media/demo.y4m'"