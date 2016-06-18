class Relationship < ActiveRecord::Base

  # あるユーザー（user_id)は別のユーザーをfollowingしていて、following先のユーザーをfollowing_user_idを記録している
  # user_id -> following_user_id (following)
  belongs_to :following_relationship, class_name: 'User', foreign_key: 'following_user_id'

  # followingされているユーザーから見て、自らをfollowing先に指定しているユーザーをfollowerとする。
  # そのため、followingとは逆にfollowerはuser_idをキーにする
  # following_user_id <- user_id (follower)
  belongs_to :follower_relationship, class_name: 'User', foreign_key: 'user_id'

  # followingレコードの増えたとすると、増えたレコードのuser_idを持つUserのフォロー数が増えたことになり、
  # following_user_idに指定されているUserのフォロワー数が増えたことになる。
  belongs_to :user, counter_cache: 'following_count'
  belongs_to :following_user, class_name: 'User', foreign_key: 'following_user_id', counter_cache: 'followers_count'

  validates :user_id, presence: true, uniqueness: {scope: [:following_user_id]}
  validates :following_user_id, presence: true

end
