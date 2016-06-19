module ApplicationHelper
  def current_user?(user)
    current_user == user
  end

  def my_tweet?(tweet)
    tweet.user == current_user
  end
end
