class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :authentication_keys => [:name]

  validates :name, presence: true, uniqueness: true

  validates :profile, length: { maximum: Constants::MAX_LENGTH_TWEET }
  validate :valid_image_dimensions?, on: :update

  has_many :following_relationships, class_name: 'Relationship', foreign_key: 'user_id', dependent: :destroy
  has_many :following, through: :following_relationships, source: :following_relationship

  # このuserをfollowしている関係なのでこのuser.idがrelationships.following_user_idに格納されているレコードが対象になる
  has_many :follower_relationships, class_name: 'Relationship', foreign_key: 'following_user_id'
  has_many :followers, through: :follower_relationships, source: :follower_relationship

  has_many :likes, dependent: :destroy
  has_many :tweets, dependent: :destroy

  mount_uploader :image, ImageUploader

  RECOMMEND_USER_AMOUNT = 5
  MIN_IMAGE_HEIGHT_PIXELS = 200
  MIN_IMAGE_WIDTH_PIXELS = 200

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if conditions.has_key?(:name)
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
    Tweet.where(
      'tweets.user_id = ? '+
        ' OR EXISTS ( SELECT * FROM relationships a WHERE tweets.user_id = a.following_user_id AND a.user_id = ? )' +
        ' OR EXISTS ( SELECT * FROM likes b WHERE tweets.id = b.tweet_id AND b.user_id = ? )',
      self.id, self.id, self.id)
      .eager_load(:user).order_latest.page(load_page).per(Constants::DEFAULT_TWEETS_PAR)
  end

  def to_param
    self.name
  end

  def self.find_by_param(user_name)
    User.find_by_name(user_name)
  end

  def recommend
    # RANDOMはSQLLITE,POSTGRESQL依存。かつ、ほとんどのUSERのレコードが対象になりランダムに取得する重い処理なのでUsersの全レコード数に注意すること。今回はコピーサービスなのでそのまま
    User.where('NOT EXISTS ( SELECT * FROM relationships a WHERE users.id = a.following_user_id AND a.user_id = ?) AND users.id <> ? ', self.id, self.id)
      .order('RANDOM()').limit(RECOMMEND_USER_AMOUNT)
  end

  private

  def valid_image_dimensions?
    return true unless self.image.file

    dimensions = self.image.dimensions
    if dimensions && (dimensions[:width] < MIN_IMAGE_WIDTH_PIXELS || dimensions[:height] < MIN_IMAGE_HEIGHT_PIXELS)
      Rails.logger.info "Image upload dimensions: #{dimensions[:width]}x#{dimensions[:height]}"
      errors.add :image, "#{MIN_IMAGE_WIDTH_PIXELS}x"+
        "#{MIN_IMAGE_HEIGHT_PIXELS}ピクセル以上のサイズの画像をアップロードしてください"+
        "(現在：#{dimensions[:width]}x#{dimensions[:height]})"
    end
  end
end
