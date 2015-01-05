http = require('http')
express = require('express')
app = express()


process.on 'SIGTERM', ->
  console.log 'Serever shutting down...'
  process.exit(0)

http.createServer(app).listen 9000, ->
  console.log("Express server start")

