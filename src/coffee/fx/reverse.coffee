window.fx = if fx? then fx else []

fx.push

  name: "Rewind Selecta!"

  play: (sample, callback) ->
    iL = sample.getChannelData 0
    iR = sample.getChannelData 1

    reverse = context.createBuffer 2, iL.length, context.sampleRate * 2
    oL = reverse.getChannelData 0
    oR = reverse.getChannelData 1

    lastIndex = iL.length - 1
    for i in [0..lastIndex]
      oL[lastIndex - i] = iL[i]
      oR[lastIndex - i] = iR[i]

    source = context.createBufferSource()
    source.buffer = reverse
    source.connect context.destination
    source.onended = callback
    source.start 0