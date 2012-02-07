editor =
  init: ->
    @config_editor()
    @default_script()
    @bind_events()

  clear:->
    $('.tabs li > a[href="#coffee"]').trigger 'click'
    @coffeeEditor.getSession().setValue ""
    $('#console-log').html("")
  
  default_script: ->
    @coffeeEditor.getSession().setValue '''
    tablo = (i for i in [0..10])
    obj = 
      moi: 
        firstname: "evan"
        lastname: "genieur"
        nickname: -> "#{@firstname}#{@lastname}"
    _ "Begining Test"
    '''
    @refresh_js()
    
  run: ->
    $('#console-log').html("")
    try
      eval @get_js_code on, '''
        _ = (outs...) -> 
            $('#console-log').append(out + " \n") for out in outs
            $('#console-log').append("<br/>")
        '''
    catch e
      console.log e
    
  get_js_code: (alert = off, pre_code = "") ->
    try
      CoffeeScript.compile pre_code + "\n" + @coffeeEditor.getSession().getValue()
    catch e
      console.log e
    
  refresh_js: ->
    if text = @get_js_code()
      $("#compiled-js").text(text)
      @run()
      prettyPrint()
    
  config_editor: ->
    @coffeeEditor = ace.edit 'coffee-editor'
    @coffeeEditor.setTheme "ace/theme/twilight"
    Mode = require("ace/mode/coffee").Mode
    @coffeeEditor.getSession().setMode(new Mode())
    @coffeeEditor.renderer.setShowPrintMargin false
    @coffeeEditor.getSession().setTabSize 2
    @coffeeEditor.getSession().setUseSoftTabs true
    @coffeeEditor.getSession().setUseWrapMode true
    
  bind_events: ->
    $("#run").click (event) =>
      @run()
      off
    $("#clear").click =>
      @clear()
      off

    @coffeeEditor.getSession().on 'change', =>
      @refresh_js()

$ ->
  editor.init()
  

