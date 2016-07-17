class Like < ActiveRecord::Base
  validates :user, presence: true, uniqueness: { scope: [:tweet_id] }
  validates :tweet, presence: true

  belongs_to :tweet, counter_cache: true
  belongs_to :user

end
