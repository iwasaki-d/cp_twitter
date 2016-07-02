$ ->
  $('#user_profile').on('input', ->
    countTweetBody($(this), $('#user_profile_length'))
  )
