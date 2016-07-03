class UserTop < PageObject
  def logout
    click_on 'ログアウト'
    wait_load(Home.new)
  end
end
