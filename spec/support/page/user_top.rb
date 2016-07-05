class UserTop < PageObject
  include Header

  def tweet_id_from_card
    first('.card-tweet')['data-card-id']
  end

  def go_tweet_update(tweet_id)
    find(".card-tweet[data-card-id='#{tweet_id}'] .card-edit .btn-primary").click
    wait_load TweetEdit.new
  end

  def delete(tweet_id)
    find(".card-tweet[data-card-id='#{tweet_id}'] .card-edit .btn-danger").click
    wait_load TweetTop.new
  end

end
