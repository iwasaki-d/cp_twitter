class UserNoticeChannel < ApplicationCable::Channel
  def subscribed
    stream_from "#{current_user.id}_notice_channel"
  end
end
