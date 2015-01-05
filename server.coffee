child_process = require("child_process")
path = require('path')
_    = require('lodash')


gulpserver = ->
  service = null
  
  defaultOptions = 
    cmd: 'coffee'
    env: 'development'
    file: 'app.coffee'
    port: 35729

  stopService = ->
    if service? # stop
      service.kill('SIGTERM')
      service = null

  process.on 'exit', (code) ->
    console.log 'main process exit ...'
    stopService()

  obj = 
    run: (newOptions) ->
      options = _.merge(defaultOptions, newOptions ? {})
      env = _.merge(process.env, {NODE_ENV: options.env})

      if service? # stop
        stopService()
      #else
        #livereload.start(options.port)

      service = child_process.spawn(options.cmd, [options.file], {env: env})

      service.stdout.setEncoding('utf8')
      service.stdout.on 'data', (data) ->
        process.stdout.write(data)

      service.stderr.on 'data', (data) ->
        process.stdout.write(data)

      service.on 'close', (code) ->
        console.log "service process close ... #{code}"


  return obj


module.exports = gulpserver()
