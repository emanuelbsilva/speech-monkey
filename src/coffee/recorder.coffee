context.createRecorder = () ->
  recorder = context.createScriptProcessor(2048)
  recording = false
  buffer =
    leftChannel: []
    rightChannel: []

  # Record
  recorder.onaudioprocess = (e) ->
    oL = e.outputBuffer.getChannelData(0)
    oR = e.outputBuffer.getChannelData(1)
    iL = e.inputBuffer.getChannelData(0)
    iR = e.inputBuffer.getChannelData(1)

    for i in [0..oL.length]
      oL[i] = if recording then iL[i] else 0
      oR[i] = if recording then iR[i] else 0

      if recording
        buffer.leftChannel.push iL[i]
        buffer.rightChannel.push iR[i]

  recorder.startRecord = -> 
    buffer.leftChannel = buffer.rightChannel = []
    recording = true

  recorder.stopRecord = ->
    recording = false
    l = buffer.leftChannel
    r = buffer.rightChannel

    audiobuffer = context.createBuffer 2, buffer.leftChannel.length, context.sampleRate * 2
    L = audiobuffer.getChannelData(0)
    R = audiobuffer.getChannelData(0)

    for i in [0..buffer.leftChannel.length]
      L[i] = l[i]
      R[i] = r[i]

    audiobuffer

  recorder
