$ ->
  $('.card-tweet .card-header').on('click', ->
    $('a[data-show-tweet]', this)[0].click()
  )
