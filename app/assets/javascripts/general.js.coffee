jQuery ->
  options = $("#page-data").data('players')
  $("input[type=search").autocomplete({source: options, autoFocus: true, messages: {noResults: "", results: ->}})
  $("input[type=search").attr("autocomplete", "on")


  $("input.datepicker").datepicker()
  $("input.datepicker").datepicker('setDate', new Date())
