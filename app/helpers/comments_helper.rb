module CommentsHelper

  def build_comment(login_user, commented_tweet)
    comment = login_user.tweets.build(parent: commented_tweet)
    comment.body = "@#{commented_tweet.user.name}"

    return comment
  end
end
