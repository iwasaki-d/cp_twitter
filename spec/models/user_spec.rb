require 'rails_helper'

RSpec.describe User, type: :model do
  include ActionDispatch::TestProcess

  describe '#create' do
    context '正常系' do
      before { @user = build(:auto_id_user, name: 'test01', password: 'pass01', password_confirmation: 'pass01') }

      it 'nameとpassword、password確認で保存出来ること' do
        expect(@user.save).to be_truthy
      end

      it 'nameと最小文字数のpassword、password確認で保存出来ること。' do
        newuser = build(:auto_id_user, name: 'test01', password: '1', password_confirmation: '1')
        expect(newuser.save).to be_truthy
      end

      it '日本語英語記号混在でもプロフィール140文字以内であれば保存できること' do
        @user.profile = make_max_length_body

        expect(@user.save).to be_truthy
      end

      it 'プロフィール・プロフィール画像の指定がなくても作成できること' do
        @user = build(:auto_id_user, name: 'test01')
        @user.profile = ''
        @user.image = ''
        expect(@user.save).to be_truthy
      end
    end

    context '異常系' do
      it '同じ名前の登録は許可しないこと' do
        new_user = build(:auto_id_user, name: 'test01', password: 'pass02', password_confirmation: 'pass02')
        expect(new_user.save).to be_truthy

        new_user = build(:auto_id_user, name: 'test01', password: 'pass02', password_confirmation: 'pass02')
        expect(new_user.save).to be_falsey
      end

      it '名前なしの登録は許可しないこと' do
        new_user = build(:auto_id_user, name: '', password: 'pass', password_confirmation: 'pass')
        expect(new_user.save).to be_falsey
      end

      it 'パスワードなしの登録は許可しないこと' do
        new_user = build(:auto_id_user, name: 'test01', password: '', password_confirmation: '')
        not_to_be_valid_presence(new_user, :password)
      end

      it '日本語英語記号混在でも140文字制限を超えるプロフィールは保存できないこと' do
        new_user = build(:auto_id_user, name: 'test01')

        new_user.profile = make_max_length_body + 'a'
        not_to_be_valid_max_length(new_user, :profile)
      end
    end
  end

  describe '#update' do
    context '正常系' do

      it 'プロフィール画像がなくても保存できること' do
        user = User.find(3)
        expect(user.update(name: 'user3')).to be_truthy
      end

      it 'プロフィール画像が規定のサイズ以上であれば保存できること' do
        user = User.find(3)
        expect(user.update(image: fixture_file_upload('/images/200x200.png', 'image/png'))).to be_truthy
      end
    end

    context '異常系' do
      it 'プロフィール画像のwidthが規定のサイズ未満であれば保存させないこと' do
        user = User.find(3)
        expect(user.update(image: fixture_file_upload('/images/199x200.png', 'image/png'))).to be_falsey
      end

      it 'プロフィール画像のheightが規定のサイズ未満であれば保存させないこと' do
        user = User.find(3)
        expect(user.update(image: fixture_file_upload('/images/200x199.png', 'image/png'))).to be_falsey
      end
    end
  end

  describe '#destroy' do
    context '正常系' do
      it '削除することで関連データも削除されること' do
        delete_user = User.find(5)
        delete_user.following_relationships.create(following_user_id: 1)

        expect(Relationship.where(user_id: delete_user.id).size).to be > 0
        expect(Tweet.where(user_id: delete_user.id).size).to be > 0
        expect(Like.where(user_id: delete_user.id).size).to be > 0

        delete_user.destroy
        expect(Relationship.where(user_id: delete_user.id).size).to eq(0)
        expect(Tweet.where(user_id: delete_user.id).size).to eq(0)
        expect(Like.where(user_id: delete_user.id).size).to eq(0)
      end
    end
  end

  describe '#following' do
    context '正常系' do
      it 'followingで対象ユーザーがフォローしているユーザー一覧が取得出来ること' do
        expect(User.find(2).following.pluck(:id)).to match_array [3, 4]
      end
    end
  end

  describe '#followers' do
    context '正常系' do
      it 'followersで対象ユーザーをフォローしているユーザー一覧が取得出来ること' do
        expect(User.find(3).followers.pluck(:id)).to match_array [1, 2]
      end
    end
  end

  describe '#timeline' do
    context '正常系' do
      it 'ユーザーのタイムラインには自身のツィート・フォローしているユーザーのツィート・いいねしたツィートが含まれること' do

        user = User.find(1)
        expect_tweets = user.tweets.pluck(:id)
        user.following.each do |following|
          expect_tweets.concat(following.tweets.pluck(:id))
        end
        expect_tweets.concat(user.likes.pluck(:tweet_id))

        # 取得したタイムラインの1ページ目の要素全てがexpect_tweetsのいずれかに含まれているかチェックしたい
        user.timeline(0).pluck(:id).each do |tweet_id|
          expect(expect_tweets.include?(tweet_id)).to be_truthy
        end
      end
    end
  end

  describe '#recommend' do
    context '正常系' do
      it 'ユーザーにリコメンドするおすすめユーザーにフォローしているユーザーは含まれないこと' do
        user = User.find(1)
        expect_users = user.following.pluck(:id)

        # 取得したタイムラインの1ページ目の要素全てがexpect_usersのいずれかにも含まれていないかチェックしたい
        user.recommend.pluck(:id).each do |recommend_user_id|
          expect(expect_users.include?(recommend_user_id)).to be_falsey
        end
      end
    end
  end


  private

  def make_max_length_body
    # 改行コードは2文字分
    'あア阿aA0.@¥n' * 14
  end
end
