require 'rails_helper'

feature 'ツィート操作' do
  background :all do
    @user_id = 6
    @name = 'user6'
    @password = 'pass6'
    @tweet_body = "features/tweet_spec.rb テストツィート#{Time.now.strftime '%Y/%m/%d %H:%M:%S'}"
  end

  after :all do
    # @name = 'tweet_test_01'
    # @password = 'pass01'
    #
    # user_top = Home.new().open.login(@name, @password)
    # user_top.go_edit_user.destroy_user_success
  end

  scenario 'ツィートを行う' do
    user_top = Home.new.open.login(@name, @password)
    user_top.tweet(@tweet_body)
    expect(page).to have_content(@tweet_body)
  end

  scenario 'ツィートを編集する画面に移動できる' do
    user_top = Home.new.open.login(@name, @password)
    expect(page).to have_content(@tweet_body)

    tweet_id = user_top.tweet_id_from_card
    user_top.go_tweet_update tweet_id
    expect(page).to have_current_path(edit_user_tweet_path(@user_id, tweet_id))
  end

  scenario 'ツィートを編集することができる' do
    user_top = Home.new.open.login(@name, @password)

    tweet_id = user_top.tweet_id_from_card
    tweet_edit = user_top.go_tweet_update tweet_id
    @tweet_body = @tweet_body + ' updated'
    tweet_edit.update(@tweet_body)

    expect(page).to have_content(@tweet_body)
  end

  scenario 'ツィートを削除することができる' do
    user_top = Home.new.open.login(@name, @password)
    expect(page).to have_content(@tweet_body)

    tweet_id = user_top.tweet_id_from_card
    user_top.delete tweet_id

    expect(page).not_to have_content(@tweet_body)
    expect(page).to have_current_path(user_tweets_path @user_id)
  end

end
