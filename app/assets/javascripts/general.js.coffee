ready = ->
  options = $("#page-data").data('players')
  $("input[type=search").autocomplete({source: options, autoFocus: true, messages: {noResults: "", results: ->}})
  $("input[type=search").attr("autocomplete", "on")


  $("input.datepicker").datepicker()
  $('#ui-datepicker-div').css('display','none');
  $("input.datepicker").datepicker('setDate', new Date())


$(document).ready(ready)
$(document).on('page:load', ready)
