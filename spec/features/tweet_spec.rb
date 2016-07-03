require 'rails_helper'

feature 'ツィート操作' do
  background :all do
    @name = 'tweet_test_01'
    @password = 'pass01'
    @tweet_body = 'features/tweet_spec.rb テストツィート'

    sing_up = Home.new().open.go_create_user_on_header
    sing_up.create_user_success(@name, @password).logout
  end

  after :all do
    @name = 'tweet_test_01'
    @password = 'pass01'

    user_top = Home.new().open.login(@name, @password)
    user_top.go_edit_user.destroy_user_success
  end

  scenario 'ツィートを行う' do
    user_top = Home.new().open.login(@name, @password)
    user_top.tweet(@tweet_body)
    expect(page).to have_content(@tweet_body)
  end
end
