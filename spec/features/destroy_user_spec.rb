require 'rails_helper'

feature 'ユーザー削除操作' do

  background :all do
    # javascriptのテストもfeatureテストで行うためseleniumを利用する
    # しかしその場合にUserモデルを取得してログインするとテスト側でuserをロックしているためログイン操作がうまくできない
    # そのため、テストユーザーのIDや名前を直接利用し、userモデルを取得しない方法でテストを行う。
    @id = 1
    @name = 'delete_test01'
    @password = 'pass1'

    sing_up = Home.new().open.go_create_user_on_header
    sing_up.create_user_success(@name, @password).logout
  end

  scenario 'ユーザーの削除画面へ移動することができる' do
    user_top = Home.new().open.login(@name, @password)
    user_top.go_edit_user
    expect(page).to have_current_path(edit_user_registration_path)
    user_top.logout
  end

  scenario 'ユーザー削除画面から削除を実行できる' do
    user_top = Home.new().open.login(@name, @password)
    user_top.go_edit_user.destroy_user_success
    expect(page).to have_content('Your account has been successfully cancelled.')
  end

end
