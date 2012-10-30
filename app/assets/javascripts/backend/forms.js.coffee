$ ->

  window.nestedFormEvents.insertFields = (content, assoc, link) ->
    $fieldset = $(link).closest('.' + assoc + '_collection')
    $(content).insertAfter($fieldset.find('.fields').last())

