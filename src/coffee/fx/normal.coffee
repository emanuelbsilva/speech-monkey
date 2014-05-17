window.fx = if fx? then fx else []

fx.push

  name: 'Normal'

  play: (sample, callback) ->
    source = context.createBufferSource()
    source.buffer = sample
    source.connect context.destination
    source.onended = callback
    source.start 0