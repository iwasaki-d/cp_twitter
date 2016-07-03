require 'rails_helper'

feature 'ユーザー作成操作' do
  background :all do
    @name = 'test01'
    @password = 'pass01'
  end

  after :all do
    # セレニウムを使っているためトランザクションが別々。
    # テストで作成してユーザーを削除する
    @name = 'test01'
    @password = 'pass01'
    user_top = Home.new().open.login(@name, @password)
    user_top.go_edit_user.destroy_user_success
  end

  scenario 'ホームのボディのリンクからユーザーの作成画面へ移動することができる' do
    Home.new().open.go_create_user_on_home
    expect(page).to have_current_path(new_user_registration_path)
  end

  scenario 'ホームのヘッダのリンクからユーザーの作成画面へ移動することができる' do
    Home.new().open.go_create_user_on_header
    expect(page).to have_current_path(new_user_registration_path)
  end

  scenario 'ユーザーを作成することができる' do
    sing_up = Home.new().open.go_create_user_on_header
    sing_up.create_user_success(@name, @password)
    expect(page).to have_content('Welcome! You have signed up successfully.')
  end
end
