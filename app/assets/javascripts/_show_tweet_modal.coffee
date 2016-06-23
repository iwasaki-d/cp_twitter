$ ->
  $('.card-tweet .card-header').on('click', ->
    $tweetLink = $('a[data-show-tweet]', this)[0]
    $tweetLink.click() if $tweetLink?
  )
