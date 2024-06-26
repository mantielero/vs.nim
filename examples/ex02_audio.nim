import vs, options
# file_example_MP3_700KB.mp3
# audio_32bits_signed_PCM.wav
  # VSAudioInfoObj:
  #   format: (sampletype: 0, bitspersample: 32, bytespersample: 4, numchannels: 2, channellayout: 3)
  #   sampleRate: 44100
  #   numSamples: 1854720
  #   numFrames:  604
# audio_16bits_signed_PCM.wav
  # VSAudioInfoObj:
  #   format: (sampletype: 0, bitspersample: 16, bytespersample: 2, numchannels: 2, channellayout: 3)
  #   sampleRate: 44100
  #   numSamples: 1854720
  #   numFrames:  604


# ../media/audio_24bits_signed_PCM.wav
# audio_32bits_signed_PCM.wav  # OK
# audio_24bits_signed_PCM.wav  # OK
# audio_16bits_signed_PCM.wav  # OK
var audio = asource("../media/audio_24bits_signed_PCM.wav", track = -1.some)
echo audio  # VSMapObj

var node = audio.getNode("clip", 0)  # VSNodeObj
echo typeof(node)
var audioInfo = node.getAudioInfo()
echo audioInfo

audio.saveWave("../media/borrame.wav")
echo "Written: ../media/borrame.wav"