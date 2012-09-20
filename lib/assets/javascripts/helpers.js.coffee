$ ->


  # switch html block
  $('body').on('click', '[data-switch-selector]', ->
    $el = $('body').find($(@).attr('data-switch-selector'))
    $el.css('height', $el.css('height'))
    if $el.hasClass('faded')
      $el.animate({'height': 'show', 'opacity': 1}, 'fast', ->
        $el.removeClass('faded')
        $el.css('height', 'auto')
      )
    else
      $el.animate({'height': 'hide', 'opacity': 0}, 'fast', -> $el.addClass('faded'))
    false
  )

  # open links in a new window
  $('body').on('click', 'a.new_window', ->
    window.open($(@).attr('href'))
    false
  )

  # set hidden field's (with name remove_<mounted_as>) value to 1 or 0
  # when click on 'button.remove_mounted' with close icon (X)
  $('body').on('click', '.remove_mounted', ->
    $(@).next('div').find('input[type=hidden]').val($(@).hasClass('active') ? 1 : 0)
  )
