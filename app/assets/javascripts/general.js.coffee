ready = ->
  options = $("#page-data").data('players')
  $("input[type=search]").autocomplete({source: options, autoFocus: true, messages: {noResults: "", results: ->}})
  $("input[type=search]").attr("autocomplete", "off")


  $("input.datepicker").datepicker({dateFormat: "yy/mm/dd"})
  $('#ui-datepicker-div').css('display','none');
  $("input.datepicker").datepicker('setDate', new Date())


$(document).ready(ready)
$(document).on('page:load', ready)
