class Tweet < ActiveRecord::Base
  validates :user, presence: true
  validates :body, presence: true, length: {minimum: 1, maximum: 140}

  belongs_to :user
end
