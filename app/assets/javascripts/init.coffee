window.App ||= {}

App.init = ->
  $('#modal').on 'shown.bs.modal', ->
    $('#modal input:visible').first().focus()
    
    if $('#form').length
      new App.Slugify

$(document).on "turbolinks:load", ->
  App.init()
