App.user_notice = App.cable.subscriptions.create "UserNoticeChannel",
  connected: ->

  disconnected: ->

  received: (data) ->
    $('#user_notice').html data['notice_html']
    $('.notice_up.hide').removeClass('hide')

  send_notice: (data) ->
    @perform 'send_notice', notice: data
