class NoticeToFollowerJob < ActiveJob::Base
  queue_as :default

  def perform(tweet)
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
