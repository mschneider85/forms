$(document).on "turbolinks:load", ->
  if $(".forms.edit").length
    $('#form').formEditor
      url: '/forms/' + $('#form').data('slug')
      method: 'PATCH'

  if $(".forms.new").length
    $('#form').formEditor()

do ($ = jQuery, window, document) ->
  pluginName = 'formEditor'
  defaults =
    toolbar: '#toolbar'
    url: '/forms/'
    method: 'POST'
    debug: false

  class Plugin
    constructor: (@element, options) ->
      @settings = $.extend {}, defaults, options
      @_defaults = defaults
      @_name = pluginName
      @init()

    init: ->
      $(@element).on 'blur click keypress', '[contenteditable]', @onLabelEdit.bind(@)
      $(@element).on 'sortstop', @serializeForm.bind(@)
      $(@element).on 'change', ':checkbox', @serializeForm.bind(@)
      $(@settings.toolbar).on 'dragstart', @onToolbarDrag.bind(@)
      $(@element).on 'serialized', @onSerialized.bind(@)

      # --- INIT DRAGGABLE TOOLBAR ---
      $("#{@settings.toolbar} .col").draggable
        appendTo: 'body'
        cancel: ''
        connectToSortable: '.row'
        cursorAt: { left: 20, top: 20 }
        helper: 'clone'
        scroll: false

      # --- INIT SORTABLE ROWS ---
      $(@element).sortable
        items: '> .row:not(:first-child):not(:last-child)'
        handle: '.row-handle'
        placeholder: 'row sortable-placeholder'
        tolerance: 'pointer'

      # --- INIT SORTABLE COLS ---
      @makeColsSortable $(@element).find('.row')

      # --- INIT SORTABLE ROW HANDELS ---
      @refreshRowHandles()

    # --- SORTABLE COLS ---
    makeColsSortable: (elements) ->
      elements.sortable
        items: '.col:not(.placeholder)'
        cancel: 'label'
        connectWith: '.row'
        cursorAt: { left: 20, top: 20 }
        placeholder: 'col sortable-placeholder'
        scroll: false
        tolerance: 'pointer'
        sort: ->
          $(this).removeClass 'ui-state-default'
          $('.row-handle').hide()
        over: (event, ui) ->
          otherItems = $(event.target).find('.col:not(.ui-sortable-placeholder, .ui-sortable-helper, .sortable-placeholder)').size()
          # adjust width
          $(ui.helper.context).width($(event.target).width() / (otherItems + 1))
          # adjust height
          helperHeight = $(ui.helper.context).children().height()
          targetHeight = $(event.target).height()
          if targetHeight > helperHeight
            $(ui.helper.context).height($(event.target).height())
        stop: =>
          draggable = $(@element).find('.col.ui-draggable')
          draggable.removeAttr('style').removeClass().addClass('col')

          $(@element).find('.row').each ->
            unless $(@).children('.col').length
              $(@).remove()

          if $(@element).find('.row').first().is(':not(:empty)')
            @makeColsSortable $(@newRow).prependTo($(@element))

          if $(@element).find('.row').last().is(':not(:empty)')
            @makeColsSortable $(@newRow).appendTo($(@element))

          @refreshRowHandles()

    # --- SORTABLE ROW HANDELS ---
    refreshRowHandles: ->
      $('.row-handle').remove()
      $(@element).find('.row:not(:empty)').prepend('<span class="row-handle"></span>')

    newRow: '<div class="row"></div>'

    # --- CONTENT EDITABLE ---
    onLabelEdit: (e) ->
      switch e.type
        when 'click'
          document.execCommand('selectAll', false, null)
        when 'focusout'
          unless $(e.target).text().length
            $(e.target).text($(e.target).data('default'))
          @serializeForm(@)
        when 'keypress'
          return unless e.which == 13
          e.preventDefault()
          window.getSelection().removeAllRanges()
          $(e.target).blur()

    # --- DRAGGABLE HELPER ---
    onToolbarDrag: (e, ui) ->
      $(ui.helper).addClass('draggable-helper').attr('data-id', uuid.v4())

    # --- SERIALIZE FORM ---
    serializeForm: (e) ->
      $(e.target).blur()
      data = {}
      rows = []
      $(@element).find('.row:not(:empty)').each (row_index, row) ->
        cols = []
        $(row).find('.col').each (col_index, col) ->
          cols.push(
            id: $(col).attr('data-id'),
            index: col_index + 1,
            type: type = $(col).find('input, textarea').attr('type'),
            label: $(col).find('label').text().replace(/(\r\n|\n|\r)/gm,''),
            checked: $(col).find('input, textarea').is(':checked') if type == 'checkbox'
          )
        rows.push(
          id: row_index + 1,
          columns: cols
        )

      data['rows'] = rows
      $(@element).trigger 'serialized', JSON.stringify(data)

    # -- PERSISTENCE --
    onSerialized: (event, data) ->
      if @settings.debug
        console.debug data
      else
        $.ajax(
          type: @settings.method
          url: @settings.url
          data: form: structure: data
        )

  $.fn[pluginName] = (options) ->
    @each ->
      if !$.data(@, "plugin_#{pluginName}")
        $.data(@, "plugin_#{pluginName}", new Plugin(@, options))
