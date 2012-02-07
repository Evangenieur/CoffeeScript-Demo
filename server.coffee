coffee = require 'coffee-script'
stylus = require 'stylus'
express = require 'express'
colors = require 'colors'

config = require './lib/config'
routes = require "./lib/routes"

port = process.env.PORT || config.express.port
app = express.createServer()

app.configure ->
  public = __dirname + '/public'
  views = __dirname + '/views'
  
  app.use stylus.middleware src: public
  app.use express.methodOverride()
  app.use express.bodyParser()
  app.use express.cookieParser()
  app.use express.session secret: "keyboardmouse"
  app.set "view options", layout: false
  app.set 'views', views
  app.use '/', express.static(public)
  app.use app.router

 routes app, config

app.listen port
console.log "Listening on port #{port}".red
