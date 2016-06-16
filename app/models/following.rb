class Following < ActiveRecord::Base
  validates :following_relation, presence: true
  validates :follower_relation, presence: true

  #あるユーザー（user_id)は別のユーザーをfollowingしていて、following先のユーザーをfollowing_user_idを記録している
  # user_id -> following_user_id (following)
  belongs_to :following_relation, class_name: 'User', foreign_key: 'following_user_id'

  #followingされているユーザーから見て、自らをfollowing先に指定しているユーザーをfollowerとする。
  #そのため、followingとは逆にfollowerはuser_idをキーにする
  #following_user_id <- user_id (follower)
  belongs_to :follower_relation, class_name: 'User', foreign_key: 'user_id'

  #followingレコードの増えたとすると、増えたレコードのuser_idを持つUserのフォロー数が増えたことになる。
  belongs_to :following_count, class_name: 'User', foreign_key: 'user_id',  counter_cache: 'following_count'

  #followingレコードの増えたとすると、増えたレコードのfollowing_user_idに指定されているUserのフォロワー数が増えたことになる。
  belongs_to :followers_count, class_name: 'User', foreign_key: 'following_user_id',  counter_cache: 'followers_count'

end

