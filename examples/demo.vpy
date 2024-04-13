import vapoursynth as vs
audio = vs.core.bas.Source("file_example_MP3_700KB.mp3", track=-1)
video = vs.core.std.BlankClip()
video.set_output(0)
audio.set_output(1)