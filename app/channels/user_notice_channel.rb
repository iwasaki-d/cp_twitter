class UserNoticeChannel < ApplicationCable::Channel
  def subscribed
    stream_from "#{current_user.id}_notice_channel"
    stream_from "user_notice_channel"
  end

  def send_notice(data)
    ActionCable.server.broadcast 'user_notice_channel', notice_html: " <p> #{data['notice']}さんのタイムラインが更新されました。</p> "
  end
end
