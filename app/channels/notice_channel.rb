class NoticeChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'notice_channel'
  end

  def unsubscribed
  end

  def send_notice(data)
    ActionCable.server.broadcast 'notice_channel', notice: data['message']
  end

end
