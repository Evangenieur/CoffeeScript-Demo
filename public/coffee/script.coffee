editor =
  init: ->
    @config_editor()
    @default_script()
  
  default_script: ->
    @coffeeEditor.getSession().setValue '''
    _ '"Please modify this code to create errors"'
    _ "Begining Test"
    _ tablo = (i for i in [0..10] when not (i % 2) ) # Get pair numbers
    _ "#{tablo[2..4]} | #{tablo[4..]}"
    obj = 
      me: 
        firstname: "evan"
        lastname: "genieur"
        nickname: -> "#{@firstname}#{@lastname}"
    _ obj.me.nickname?()
    _ obj.me.nickname.toString()
    console.log obj
    '''
    @refresh_js()
    
  run: ->
    $("#console-log").html ""
    $("#runtime-alert").html ""
    try
      eval @get_js_code on, '''
        _ = (outs...) -> 
            $('#console-log').append(out + " \n") for out in outs
            $('#console-log').append("<br/>")
        '''
    catch e
      $("#runtime-alert").html """
      <div class="alert alert-error">
        <strong>#{e.constructor.name} : </strong> #{e.message}
      </div>
      """
      console.log "run", e
    
  get_js_code: (alert = off, pre_code = "") ->
    $("#compile-alert").html ""
    try
      CoffeeScript.compile pre_code + "\n" + @coffeeEditor.getSession().getValue()
    catch e
      $("#compile-alert").html """
      <div class="alert alert-error">
        <strong>#{e.constructor.name} : </strong> #{e.message}
      </div>
      """
      console.log "get_js_code", e
    
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
    
    @coffeeEditor.getSession().on 'change', =>
      @refresh_js()

$ ->
  editor.init()
  

