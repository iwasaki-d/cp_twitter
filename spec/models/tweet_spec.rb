require 'rails_helper'

RSpec.describe Tweet, type: :model do
  describe '#create' do
    context '正常系' do
      before do
        user = User.find_by(id: 1);
        @tweet = build(:tweet, user: user, body: "test_wteet")
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

    end

    context '異常系' do
      before { @tweet = Tweet.new }

      it 'bodyの入力なしでは保存できないこと' do
        @tweet.user = User.find_by(id: 1);
        expect(@tweet).not_to be_valid
        expect(@tweet.errors[:body].first).to include ("can't be blank")
      end

      it 'Userの入力なしでは保存できないこと' do
        @tweet.body = 'test_twwee'
        expect(@tweet).not_to be_valid
        expect(@tweet.errors[:user].first).to include ("can't be blank")
      end

      it '140文字制限を超える本文は保存できないこと' do
        @tweet.body = 'a'*141
        @tweet.user = User.find_by(id: 1);
        expect(@tweet).not_to be_valid
        expect(@tweet.errors[:body].first).to include ("too long")
      end

      it '日本語英語記号混在でも140文字制限を超える本文は保存できないこと' do
        @tweet.body = make_max_length_body + 'a'
        @tweet.user = User.find_by(id: 1);
        expect(@tweet).not_to be_valid
        expect(@tweet.errors[:body].first).to include ("too long")
      end

    end

  end

  def make_max_length_body
    # 改行コードは2文字分
    'あア阿aA0.@¥n' * 14
  end
end
