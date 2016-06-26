$ ->
  $('.card-tweet .card-header').click ->
    $tweetLink = $('a[data-show-tweet]', this)[0]
    $tweetLink.click() if $tweetLink?

  #  $('#comment_body').on('input', ->
  #    countTweetBody($(this), $('#comment_body_length'))
  #  )

