window.fx = if fx? then fx else []

fx.push

  name: 'Speedy Gonzalez'

  play: (sample, callback) ->
    source = context.createBufferSource()
    source.buffer = sample
    source.connect context.destination
    source.playbackRate.value = 1.5
    source.onended = callback
    source.start 0