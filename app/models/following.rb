class Following < ActiveRecord::Base
  validates :following, presence: true
  validates :follower, presence: true

  #あるユーザー（user_id)は別のユーザーをfollowingしている。
  #following先のユーザーをfollowing_user_idを記録している
  # user_id -> following_user_id (following)
  belongs_to :following, class_name: 'User', foreign_key: 'following_user_id'

  #followingユーザーから見て、自らをfollowing先に指摘しているユーザーをfollowerとする。
  #そのため、followingとは逆にfollowerはuser_idをキーにする
  #following_user_id <- user_id (follower)
  belongs_to :follower, class_name: 'User', foreign_key: 'user_id'

end
