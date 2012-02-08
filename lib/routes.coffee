helpers = require './helpers'

routes = (app, config) ->
  app.get '/', (req, res, next) ->

    res.render 'home.jade',
      company: config.company
      project: config.project
      page:
        name: "CoffeeXP"
      tweet:
        msg: encodeURIComponent("CoffeeXP : live #coffeescript coding experiments http://evangenieur.com/coffeexp cc @evangenieur")


module.exports = routes
