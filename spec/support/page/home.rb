require 'support/page/page_object'

class Home < PageObject
  include Header

  # クラスメソッドにするとcapybara::DSL(visit等々)が動作しなかった
  def open
    visit @@url_helpers.root_path
    wait_load(self)
  end

  def login(name, password)
    fill_in 'アカウント名', with: name
    fill_in 'パスワード', with: password
    click_button 'ログイン'
    wait_load(UserTop.new)
  end

  def go_create_user_on_home()
    find('#create_user_home').click
    wait_load(SignUp.new)
  end
end
