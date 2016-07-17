require 'support/page/page_object'
require 'support/page/header'

class SignUp < PageObject
  include Header

  def create_user_success(name, password)
    fill_in 'アカウント名称', with: name
    fill_in 'パスワード', with: password
    fill_in 'パスワード確認', with: password

    click_button 'アカウント作成'

    wait_load UserTop.new
  end
end
