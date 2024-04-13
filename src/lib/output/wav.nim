# AUDIO: save as WAV file
import ../audio/[audioinfo,audioformat]
import ../frame/[libvsframe]#, libapi, , libvsnode, info, helper]
import ../vsmap/libvsmap
#import ../../wrapper/vapoursynth4
import easywave # https://github.com/johnnovak/easywave

proc saveWave*(vsmap:VSMapRef; filename:string):int {.discardable.} =
  ## Saves the video in `filename`
  #echo "ok0"
  let 
    node = getFirstNode(vsmap)
    audioInfo = node.getAudioInfo()
    format = audioInfo.format()
    sampleRate = audioInfo.sampleRate
    numSamples = audioInfo.numSamples
    numframes = audioInfo.numFrames
    sampleType     = format.sampleType
    bitsPerSample  = format.bitsPerSample
    bytesPerSample = format.bytesPerSample
    numChannels    = format.numChannels
    channelLayout  = format.channelLayout
  
  #echo audioInfo

  let endian = littleEndian  # bigEndian
  var rw = createRiffFile(filename, FourCC_WAVE, endian)

  # Write header
  let wf = WaveFormat(
    sampleFormat:  sfPCM,  # sfFloat
    bitsPerSample: format.bitsPerSample,
    sampleRate:    audioInfo.sampleRate,
    numChannels:   format.numChannels
  )

  rw.writeFormatChunk(wf)
  rw.beginChunk(FourCC_WAVE_data)
  # Format: sfPCM, 8, 16, 24, 32
  for i in 0..<numframes:
    let 
      frame = node.getFrame(i)
      fmt = frame.getAudioFrameFormat()
      nChannels = fmt.numChannels
      nSamples  = frame.getFrameLength()
      bytesPerOutputSample = (fmt.bitsPerSample + 7) div 8
      toOutput = bytesPerOutputSample * nSamples * nChannels   

    var punteros = newSeq[uint](nChannels)
    for channel in 0..<nChannels:
      punteros[channel] = frame.getReadPtr(channel)

    if bytesPerOutputSample == 2:
      var data = newSeq[ptr UncheckedArray[uint16]](nChannels)
      for channel in 0..<nChannels:
        data[channel] = cast[ptr UncheckedArray[uint16]](frame.getReadPtr(channel))

      var newData = newSeq[uint16]( nSamples * numChannels )
      for i in 0..<nSamples:
        for channel in 0..<nChannels:
          newData[nChannels*i + channel]   = data[channel][i]

      rw.write(newData,0, nSamples*nChannels - 1)
    
    elif bytesPerOutputSample == 3:
      var data = newSeq[ptr UncheckedArray[uint8]](nChannels)
      for channel in 0..<nChannels:
        data[channel] = cast[ptr UncheckedArray[uint8]](frame.getReadPtr(channel))

      var newData = newSeq[uint8]( nSamples * numChannels * 3)  # 3 bytes per sample (24bits)
      for i in 0..<nSamples:
        for channel in 0..<nChannels:
          newData[nChannels*i*3 + channel * 3 ]    = data[channel][i * 4 + 1]
          newData[nChannels*i*3 + channel * 3 + 1] = data[channel][i * 4 + 2]
          newData[nChannels*i*3 + channel * 3 + 2] = data[channel][i * 4 + 3]

      rw.write(newData,0, nSamples*nChannels*3 - 1)

    elif bytesPerOutputSample == 4:
      #echo "uint32"
      var data = newSeq[ptr UncheckedArray[uint32]](nChannels)
      for channel in 0..<nChannels:
        data[channel] = cast[ptr UncheckedArray[uint32]](frame.getReadPtr(channel))

      var newData = newSeq[uint32]( nSamples * numChannels )
      for i in 0..<nSamples:
        for channel in 0..<nChannels:
          newData[nChannels*i + channel]   = data[channel][i]

      rw.write(newData,0, nSamples*nChannels - 1)

  rw.endChunk()
  rw.close()
