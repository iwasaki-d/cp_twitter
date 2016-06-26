$ ->
  $('#tweet_body').on('input', ->
    countTweetBody($(this),$('#tweet_body_length'))
  )
