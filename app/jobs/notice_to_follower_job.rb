class NoticeToFollowerJob < ActiveJob::Base
  queue_as :default
  include Rails.application.routes.url_helpers

  def perform(tweet)
    tweet.user.followers.each do |follower|
      ActionCable.server.broadcast "#{follower.id}_notice_channel", notice_html: build_html(follower)
    end
  end

  private

  def build_html(follower)
    #コントローラー外からrenderを呼び出す為
    lookup_context = ActionView::LookupContext.new('./app/views')
    view_context = ActionView::Base.new(lookup_context)
    view_context.assign(user: follower)
    view_context.render('shared/user_notice')
  end
end
