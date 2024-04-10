## About
This project aims to wrap VapourSynth's API 4 version.

# Development
## API
https://vapoursynth.com/doc/api/vapoursynth4.h.html

## Wrapping
The library was wrapped using [futhark]. The file `create.nim` will create the files:
- `vapoursynth4.nim`
- `vsconstants4.nim`

`lib/` provides a friendlier API.

An `api` instance is created in `libapi.nim` and also a `core` instance in `helper.nim`.

VSMaps are like python's dictionaries.



## Plugins
Plugins are files that provide a number of functions when loaded.

There some functions to deal with the plugins available. 

Other set of functions are to deal with the functions available within a plugin.

Then `invoke` is used to call one of those functions with parameters.

For instance, `Source` is function within the plugin `ffms2` and we can call it using `invoke`.


The file `wrapper/plugin_generator.nim` is used to create the files contained in `plugins4`. These defines Nim functions with Nim times that help calling the functions defined in the plugins. This way we won't need to use invoke. These definitions use `invoke` by us.


## Audio
https://www.vapoursynth.com/2020/01/audio-support-and-how-it-works/

Create the file `demo.vpy`:
```python
import vapoursynth as vs
audio = vs.core.bas.Source("file_example_MP3_700KB.mp3", track=-1)
video = vs.core.std.BlankClip()
video.set_output(0)
audio.set_output(1)
```

```sh
vspipe -o 1 -c wav "demo.vpy" - | ffmpeg -i pipe: -c:a pcm_s16le Output.wav
vspipe -o 0 -c y4m "demo.vpy" - | ffmpeg -i pipe: -i Output.wav -c:v prores -c:a copy "Output.mkv"
rm Output.wav
```


**QUÉ HACER EN EL CASO DE NIM**. Supongo que habría que hacer algo como en `output.nim``
https://github.com/vapoursynth/vapoursynth/blob/master/src/vspipe/vspipe.cpp


https://ffmpeg.org/nut.html

## Link
https://forum.doom9.org/showthread.php?t=173194
https://vapoursynth.com/doc/pythonreference.html#VideoNode.set_output