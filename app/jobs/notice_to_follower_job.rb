class NoticeToFollowerJob < ActiveJob::Base
  queue_as :default

  def perform(tweet)
    tweet.user.followers.each do |follower|
      ActionCable.server.broadcast "#{follower.id}_notice_channel", notice_html: build_html(follower)
    end
  end

  private

  def build_html(follower)
    " <p class=\"alert alert-info\"> #{follower.name}さんのタイムラインが更新されました。</p> "
  end
end
