App.notice = App.cable.subscriptions.create "NoticeChannel",
  connected: ->

  disconnected: ->

  received: (data) ->
    alert ''

  send_notice: (notice) ->
    @perform 'send_notice', notice: notice
