App.combineDateTime =
  init: (item) ->
    toChange = $(item).data('change')
    targetElement = $('input[name*="\[' + toChange + '\]"]')

    date = $('input[name*="\[' + toChange + '_date\]"]').val()
    time = $('input[name*="\[' + toChange + '_time\]"]').val()

    targetElement.val(date + 'T' + time)

$(document).on 'change', 'input[type="date"][data-change], input[type="time"][data-change]', ->
  App.combineDateTime.init(@)
