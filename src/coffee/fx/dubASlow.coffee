window.fx = if fx? then fx else []

fx.push

  name: "Dub N' Slow"

  play: (sample, callback) ->
    source = context.createBufferSource()
    source.buffer = sample
    source.connect context.destination
    source.playbackRate.value = 0.5
    source.onended = callback
    source.start 0