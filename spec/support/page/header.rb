module Header
  def go_create_user_on_header()
    find('#create_user_header').click
    wait_load(SignUp.new)
  end

  def logout
    click_on 'ログアウト'
    wait_load(Home.new)
  end

  def tweet(body_string)
    click_button 'ツィートする'
    fill_in 'tweet[body]', with: body_string
    find('#do_tweet_on_dialog').click

    wait_load(TweetTop.new)
  end
end
