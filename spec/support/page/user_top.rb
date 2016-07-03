class UserTop < PageObject
  def logout
    click_on 'ログアウト'
    wait_load(Home.new)
  end

  def go_edit_user()
    find('#edit_user_header').click
    wait_load(UserRegistrations.new)
  end
end
