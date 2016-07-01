App.user_notice = App.cable.subscriptions.create "UserNoticeChannel",
  connected: ->

  disconnected: ->

  received: (data) ->
    $('#user_notice').html data['notice_html']

  send_notice: (data) ->
    @perform 'send_notice', notice: data
