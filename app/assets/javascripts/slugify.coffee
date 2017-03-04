class App.Slugify
  constructor: (options) ->
    @settings = $.extend {}, defaults, options
    @_defaults = defaults
    @init()

  defaults =
    selector: '[data-slug]'
    blacklist: []
    blacklistPath: '/forms/'
    remote: true

  init: ->
    @_loadBlacklist()
    $(document).on 'keyup change', @settings.selector, @onKeyUp.bind(@)

  onKeyUp: (e) ->
    @string = $(e.target).val()
    $("##{$(e.target).data('slug')}").val(@_slugify)

  _slugify: =>
    @_appendAddon(
      @string.toLowerCase()
             .substring(0, 30)
             .replace(/[^a-z0-9 ]/g, " ")
             .trim()
             .replace(/[ ]+/g, "-")
    )

  _appendAddon: (string) =>
    i = 0
    loop
      if i > 0
        addon = "-#{i}"
      else
        addon = ""
      break unless @settings.blacklist.indexOf(string + addon) != -1
      i++
    string + addon

  _loadBlacklist: ->
    settings = @settings
    if settings.remote
      $.getJSON settings.blacklistPath, (json) ->
        settings.blacklist.push.apply settings.blacklist, json
