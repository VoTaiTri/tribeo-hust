jQuery ->
  $('#subjects_search').submit( ->
    $.get(this.action, $(this).serialize(), null, 'script')
    false
  )

  $('#subjects_search input').keyup( ->
    $.get($("#subjects_search").attr("action"), $("#subjects_search").serialize(), null, 'script')
    false
  )