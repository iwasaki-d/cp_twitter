require 'rails_helper'

feature 'ツィート操作' do
  background :all do
    @user_id = 6
    @name = 'user6'
    @password = 'pass6'
    @tweet_body = "features/tweet_spec.rb テストツィート#{Time.now.strftime '%Y/%m/%d %H:%M:%S'}"
  end

  scenario 'ツィートを行う' do
    user_top = Home.new.open.login(@name, @password)
    user_top.tweet(@tweet_body)
    expect(page).to have_content(@tweet_body)
  end

  scenario 'ツィートを詳細表示をモーダルダイアログで見ることができる' do
    user_top = Home.new.open.login(@name, @password)
    expect(page).to have_content(@tweet_body)

    tweet_id = user_top.tweet_id_from_card
    user_top.show_tweet_modal_dialog(tweet_id)
    expect(user_top.show_tweet_modal_dialog?).to be_truthy
  end

  scenario 'ツィートを編集する画面に移動できる' do
    user_top = Home.new.open.login(@name, @password)
    expect(page).to have_content(@tweet_body)

    tweet_id = user_top.tweet_id_from_card
    user_top.go_tweet_update tweet_id
    expect(page).to have_current_path(edit_user_tweet_path(@name, tweet_id))
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
    expect(page).to have_current_path(user_tweets_path @name)
  end
end
