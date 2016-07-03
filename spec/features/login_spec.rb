require 'rails_helper'

feature 'ログイン操作' do

  background :all do
    # javascriptのテストもfeatureテストで行うためseleniumを利用する
    # しかしその場合にUserモデルを取得してログインするとテスト側でuserをロックしているためログイン操作がうまくできない
    # そのため、テストユーザーのIDや名前を直接利用し、userモデルを取得しない方法でテストを行う。
    @id = 1
    @name = 'user1'
    @password = 'pass1'
  end

  scenario 'ログインする' do
    Home.new().open.login(@name, @password)
    expect(page).to have_current_path(user_path(@id))
    expect(page).to have_content('Signed in successfully. ')
  end

  scenario 'ログアウトする' do
    user_top = Home.new().open.login(@name, @password)
    user_top.logout

    expect(page).to have_current_path(root_path)
    expect(page).to have_content('Signed out successfully.')
  end
end
