class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :authentication_keys => [:name]

  validates :name, presence: true, uniqueness: true

  has_many :tweets

  has_many :following_relationships, class_name: 'Relationship', foreign_key: 'user_id'
  has_many :following, through: :following_relationships, source: :following_relationship

  # このuserをfollowしている関係なのでこのuser.idがrelationships.following_user_idに格納されているレコードが対象になる
  has_many :follower_relationships, class_name: 'Relationship', foreign_key: 'following_user_id'
  has_many :followers, through: :follower_relationships, source: :follower_relationship


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
