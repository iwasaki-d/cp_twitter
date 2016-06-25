class Like < ActiveRecord::Base
  validates :user, presence: true
  validates :tweet, presence: true

  belongs_to :tweet, counter_cache: true
  belongs_to :user

end
