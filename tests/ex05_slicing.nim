import vs
var nframes = source("2sec.mkv")[10..50].saveY4M("demo.y4m")
echo nframes, " frames written to 'demo.y4m'"