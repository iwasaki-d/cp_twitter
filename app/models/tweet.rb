class Tweet < ActiveRecord::Base
  validates :user, presence: true
  validates :body, presence: true, length: { minimum: 1, maximum: Constants::MAX_LENGTH_TWEET }

  belongs_to :user, counter_cache: 'tweets_count'
  has_many :likes, dependent: :destroy

  scope :order_latest, -> { order('tweets.created_at desc') }

  has_many :like_users, through: :likes, source: :user

  belongs_to :parent, class_name: 'Tweet', foreign_key: 'parent_tweet_id', counter_cache: 'comments_count'
  has_many :comments, class_name: 'Tweet', foreign_key: 'parent_tweet_id'

  after_commit :user_notice_broadcast

  private

  def user_notice_broadcast
    # destroyの時にNoticeToFollowerJobを呼び出すとエラーが起きるので厳禁
    if transaction_include_any_action?([:create])
      NoticeToFollowerJob.perform_later self
    end
  end
end
