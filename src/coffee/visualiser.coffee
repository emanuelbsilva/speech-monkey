context.createVisualiser = () ->
  # HTML Canvas
  canvas = document.querySelector('canvas');
  drawCtx = canvas.getContext('2d');
  HEIGHT = canvas.height
  WIDTH = canvas.width
  
  # Analyser Node
  analyser = context.createAnalyser()
  analyser.smoothingTimeConstant = 0.925;
  analyser.fftSize = 64;

  timeDomain = new Uint8Array(analyser.frequencyBinCount)
  freqDomain = new Uint8Array(analyser.frequencyBinCount)

  renderFrequency = ->
    barWidth = WIDTH / analyser.frequencyBinCount
    drawCtx.fillStyle = 'blue'
    
    analyser.getByteFrequencyData freqDomain
    for i of freqDomain
      value = freqDomain[i]
      percent = value / 256
      height = HEIGHT * percent
      offset = HEIGHT - height
      hue = i / analyser.frequencyBinCount * 360
      drawCtx.clearRect(i * barWidth, 0, barWidth, HEIGHT)
      drawCtx.fillRect(i * barWidth, offset, barWidth - 3, height)

  renderTime = ->
    analyser.getByteTimeDomainData timeDomain
    for i of timeDomain
      value = timeDomain[i]
      percent = value / 256
      height = HEIGHT * percent
      offset = HEIGHT - height - 1
      barWidth = WIDTH / analyser.frequencyBinCount
      drawCtx.fillStyle = 'white'
      drawCtx.fillRect i * barWidth, offset, 1, 1

  render = ->
    renderFrequency()
    #renderTime()
    requestAnimFrame render

  render()

  analyser
