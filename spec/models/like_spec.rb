require 'rails_helper'

RSpec.describe Like, type: :model do
  describe '#create' do
    context '正常系' do
      it 'ユーザーとイイねするツィートが揃えれば保存出来ること' do
        like = build(:like, user: User.find(5), tweet: User.find(1).tweets.last)

        expect(like.save).to be_truthy
      end
    end

    context '異常系' do
      it '空ユーザーは登録できないこと' do
        like = build(:like)
        like.user_id = ''
        like.tweet = User.find(1).tweets.last

        not_to_be_valid_presence(like, :user)
      end

      it '空のツィートは登録できないこと' do
        like = build(:like)
        like.user = User.find(5)
        like.tweet_id = ''

        not_to_be_valid_presence(like, :tweet)
      end

      it '同じユーザーフォローは登録できないこと' do
        like = build(:like, user: User.find(5), tweet: User.find(1).tweets.last)
        expect(like.save).to be_truthy

        like = build(:like, user: User.find(5), tweet: User.find(1).tweets.last)
        expect(like.save).to be_falsey
      end
    end
  end

  describe '#destroy' do
    context '正常系' do
      it 'イイねを削除してもイイね先のツィートは削除されないこと' do
        like = build(:like, user: User.find(5), tweet: User.find(1).tweets.last)
        liked_tweet_id = User.find(1).tweets.last.id
        expect(like.save).to be_truthy

        like.destroy

        expect(Tweet.find(liked_tweet_id)).to be_present
      end
    end
  end
end
