require 'rails_helper'

RSpec.describe Tweet, type: :model do
  describe '#create' do
    context '正常系' do
      before do
        user = User.find_by(id: 1)
        @tweet = build(:tweet, user: user, body: 'test_tweet')
      end

      it 'bodyの入力で保存出来ること' do
        expect(@tweet.save).to be_truthy
      end

      it '140文字の日本語でbodyの入力で保存出来ること' do
        @tweet.body = 'あ'*140
        expect(@tweet.save).to be_truthy
      end

      it '140文字の日本語英語記号混在でbodyの入力で保存出来ること' do
        @tweet.body = make_max_length_body
        expect(@tweet.save).to be_truthy
      end

      it 'tweetについたコメントを取得する' do
        tweet = User.find_by(id: 1).tweets.first
        expect(tweet.comments.length).to eq(2)
      end
    end

    context '異常系' do
      before { @tweet = Tweet.new }

      it 'bodyの入力なしでは保存できないこと' do
        @tweet.user = User.find_by(id: 1)
        not_to_be_valid_presence(@tweet, :body)
      end

      it 'Userの入力なしでは保存できないこと' do
        @tweet.body = 'test_twwee'
        not_to_be_valid_presence(@tweet, :user)
      end

      it '140文字制限を超える本文は保存できないこと' do
        @tweet.body = 'a'*141
        @tweet.user = User.find_by(id: 1)
        not_to_be_valid_max_length(@tweet, :body)
      end

      it '日本語英語記号混在でも140文字制限を超える本文は保存できないこと' do
        @tweet.body = make_max_length_body + 'a'
        @tweet.user = User.find_by(id: 1)
        not_to_be_valid_max_length(@tweet, :body)
      end

    end
  end

  describe '#destroy' do
    context '正常系' do
      it '親ツィートが削除されてもコメントは残ること' do
        tweet = User.find_by(id: 1).tweets.first
        comment_id = tweet.comments.first.id

        tweet.destroy

        expect(Tweet.find_by(id: comment_id)).to be_present
      end
    end
  end

  private

  def make_max_length_body
    # 改行コードは2文字分
    'あア阿aA0.@¥n' * 14
  end
end
