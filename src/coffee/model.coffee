window.model = {}

model.state = ko.observable 'init'

model.fx = ko.observableArray []

model.startRecord = ->
  model.state 'recording'
  recorder.startRecord()

model.stopRecord = ->
  window.sample = recorder.stopRecord()
  model.state 'fx'

ko.applyBindings model