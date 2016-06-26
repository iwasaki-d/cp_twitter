class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :authentication_keys => [:name]

  validates :name, presence: true, uniqueness: true

  has_many :following_relationships, class_name: 'Relationship', foreign_key: 'user_id' , dependent: :destroy
  has_many :following, through: :following_relationships, source: :following_relationship

  # このuserをfollowしている関係なのでこのuser.idがrelationships.following_user_idに格納されているレコードが対象になる
  has_many :follower_relationships, class_name: 'Relationship', foreign_key: 'following_user_id'
  has_many :followers, through: :follower_relationships, source: :follower_relationship

  has_many :likes, dependent: :destroy
  has_many :tweets, dependent: :destroy

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

  def timeline(load_page)
    Tweet.where('tweets.user_id = ? OR EXISTS ( SELECT * FROM relationships a WHERE tweets.user_id = a.following_user_id AND a.user_id = ? )' +
      ' OR EXISTS ( SELECT * FROM likes b WHERE tweets.id = b.tweet_id AND b.user_id = ? )', self.id, self.id, self.id)
    .eager_load(:user).order_latest.page(load_page).per(Constants::DEFAULT_TWEETS_PAR)
  end

  def self.recommend(recommended_user)
    # RANDOMはSQLLITE,POSTGRESQL依存。かつ、ほとんどのUSERのレコードが対象になりランダムに取得する重い処理なのでUsersの全レコード数に注意すること。今回はコピーサービスなのでそのまま
    User.where('NOT EXISTS ( SELECT * FROM relationships a WHERE users.id = a.following_user_id AND a.user_id = ?) AND users.id <> ? ', recommended_user, recommended_user)
      .order('RANDOM()').limit(Constants::RECOMMEND_USER_AMOUNT)
  end

end
