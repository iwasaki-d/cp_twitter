module ApplicationHelper
  def current_user?(user)
    current_user == user
  end

  def my_tweet?(tweet)
    tweet.user == current_user
  end

  def default_user_image(user)
    user_image(user, '45x45')
  end

  def header_user_image(user)
    user_image(user, '35x35')
  end

  private

  def user_image(user, size)
    if user.image?
      image_tag user.image.thumb.url, size: size, class: 'img-rounded', style: 'display:flexbox;'
    else
      image_tag 'thumb-noimage.png', size: size, class: 'img-rounded', style: 'display:flexbox;'
    end
  end
end
