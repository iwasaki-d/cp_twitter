@countTweetBody = ($input, $counter) ->
  textCharactors = $input.val().replace(/\n/g, "")
  newLineCharactors = $input.val().replace(/[^\n]/g, "")

  bodyLength = (textCharactors.length + newLineCharactors.length * 2)
  remainsLength = window.cpTwitter.MAX_LENGTH_TWEET - bodyLength

  if remainsLength > window.cpTwitter.WARNING_REMAINS_LENGTH_TWEET
    $counter.html(remainsLength).removeClass("text-warning")
  else
    $counter.html(remainsLength).addClass("text-warning")
