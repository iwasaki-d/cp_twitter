require 'rails_helper'

feature 'ユーザー削除操作' do

  background do
    # javascriptのテストもfeatureテストで行うためseleniumを利用する
    # しかしその場合にUserモデルを取得してログインするとテスト側でuserをロックしているためログイン操作がうまくできない
    # そのため、テストユーザーのIDや名前を直接利用し、userモデルを取得しない方法でテストを行う。
    @id = 1
    @name = 'user1'
    @password = 'pass1'
  end

  scenario 'ユーザーの削除画面へ移動することができる' do
    user_top = Home.new().open.login(@name, @password)
    user_top.go_edit_user
  end

  scenario 'ユーザー削除画面から削除を実行できる' do
    user_top = Home.new().open.login(@name, @password)
    user_top.go_edit_user.destroy_user_success
  end

end
