

getLiveAudioInput = (onStream, onStreamError) ->
  navigator.webkitGetUserMedia audio: true, onStream, onStreamError

onStream = (stream) ->
  window.stream = stream
  window.input = context.createMediaStreamSource stream
  window.recorder = context.createRecorder()
  window.visualiser = context.createVisualiser()

  input.connect recorder
  recorder.connect visualiser

onStreamError = (err) -> console.error err

# Init audio
getLiveAudioInput onStream, onStreamError


# Load Effects
model.fx fx.map (fx) ->
  name: fx.name
  play: ->
    fx.play window.sample
