class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :authentication_keys => [:name]

  validates :name, presence: true, uniqueness: true

  has_many :tweets

  has_many :my_following_relationship, class_name: 'Following', foreign_key: 'user_id'
  has_many :following, through: :my_following_relationship

  has_many :followed_me_relationship, class_name: 'Following', foreign_key: 'following_user_id'
  has_many :follower, through: :followed_me_relationship


  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      #認証の条件式を変更する
      where(conditions).where(["name = :value", {value: name}]).first
    else
      where(conditions).first
    end
  end

  def email_required?
    false
  end

  def email_changed?
    false
  end

  def get_tweets_include_tweets_of_following
    Tweet.order_latest.where(user_id: [self.id] << self.following.pluck(:following_user_id))
  end

end
