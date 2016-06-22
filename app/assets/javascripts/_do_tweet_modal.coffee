$ ->
  $('#tweet_body').on('input', ->
    textCharactors = $(this).val().replace(/\n/g, "")
    newLineCharactors = $(this).val().replace(/[^\n]/g, "")

    bodyLength = (textCharactors.length + newLineCharactors.length * 2)
    remainsLength = window.cpTwitter.MAX_LENGTH_TWEET - bodyLength

    if remainsLength > window.cpTwitter.WARNING_REMAINS_LENGTH_TWEET
      $('#tweet_body_length').html(remainsLength).removeClass("text-warning")
    else
      $('#tweet_body_length').html(remainsLength).addClass("text-warning")
  ) 
