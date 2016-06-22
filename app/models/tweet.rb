class Tweet < ActiveRecord::Base
  validates :user, presence: true
  validates :body, presence: true, length: {minimum: 1, maximum: Constants::MAX_LENGTH_TWEET}

  belongs_to :user, counter_cache:  'tweets_count'

  scope :order_latest, -> { order("created_at desc") }


end
