jQuery ->
  $('#courses_search').submit( ->
    $.get(this.action, $(this).serialize(), null, 'script')
    false
  )

  $('#courses_search input').keyup( ->
    $.get($("#courses_search").attr("action"), $("#courses_search").serialize(), null, 'script')
    false
  )