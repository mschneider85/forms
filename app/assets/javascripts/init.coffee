window.App ||= {}

App.init = ->
  $('#modal').on 'shown.bs.modal', ->
    $('#modal input:visible').first().focus()

    if $('#form').length
      new App.Slugify

  if $('.campaigns.new').length
    new App.Slugify
      blacklistPath: '/campaigns'

$(document).on "turbolinks:load", ->
  App.init()
