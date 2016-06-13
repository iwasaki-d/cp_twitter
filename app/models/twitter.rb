class Twitter < ActiveRecord::Base
  validates :text, presence: true, length: {minimum: 1, maximum: 140}

  belongs_to :user

end
