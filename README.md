## About
This project aims to wrap VapourSynth's API 4 version.

## Status
Right now it is possible:
- to play and transform videos
- to play audio

## Differences with original project
1. In order to allow chaining function calls, the first argument of a function is always a VSMap and all functions return VSMap. For that reason, functions are created within the folder `src/plugins4`.
2. Those functions my receive optional paramenter. In Nim, I decided to use `std/options` for that. This is why you might see in some examples values like: `-1.some` or `none(whatever)`.




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

The function "Source" from BestAudioSource has been renamed into "asource". This avoids having to specify if we are referring to `ffms2.source` or `bas.source`. We will use `source` and `asource` instead.


## Comparing Nim and python
### Python
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

## Nim
TBD

## Link
https://forum.doom9.org/showthread.php?t=173194
https://vapoursynth.com/doc/pythonreference.html#VideoNode.set_output


# TODO
- [ ] Memory issue with `tests/ex06_adding.nim` and `tests/ex07_repeating.nim`
  - https://nim-lang.org/docs/destructors.html
- [X] Slicing a video clip
- [ ] Slicing an audio clip
- [ ] Custom filters: https://mantielero.github.io/VapourSynth.nim/docs/filters/
  - I managed to create Nim based filters as performant as C++ but leveraging Nim's macros.
  - python example: https://forum.doom9.org/showthread.php?t=172206
  - c example: [crop filter](https://github.com/vapoursynth/vapoursynth/blob/master/src/core/simplefilters.c#L136-L296) in `std`
  - 
- [ ] libnut support: 
  - https://github.com/lu-zero/nut/blob/master/src/libnut/libnut.h
  - https://ffmpeg.org/nut.html

- Low priority:
  - being able to use VapourSynth python scripts.
  - supporting Avisynth plugins.
  - AviSynth scripts: is this possible?
  - Supporting more formats: I have not investigated much in this front.
  - Interop with other libraries: 
    - Cairo (or Skia, which should be more performant), 
    - OpenCV
    - ...
  - Look for some inspiration in MoviePy:
    - For example, making easier the composition/position of clips.



# Blablabla
## VSMap
