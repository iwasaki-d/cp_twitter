module Header
  def go_create_user_on_header()
    find('#create_user_header').click
    wait_load(SignUp.new)
  end

  def logout
    click_on 'ログアウト'
    wait_load(Home.new)
  end
end
