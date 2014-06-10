jQuery ->
  options = $("#page-data").data('players')
  $("input[type=search").autocomplete({source: options, autoFocus: true, messages: {noResults: "", results: ->}})
