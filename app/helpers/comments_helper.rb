module CommentsHelper

  def build_comment(login_user, commented_tweet)
    login_user.tweets.build(parent: commented_tweet, body: "@#{commented_tweet.user.name}")
  end
end
