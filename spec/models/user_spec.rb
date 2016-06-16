require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    context '正常系' do
      before { @user = build(:auto_id_user, name: "test01", password: "pass01", password_confirmation: "pass01") }

      it 'nameとpassword、password確認で保存出来ること' do
        expect(@user.save).to be_truthy
      end

      it 'nameと最小文字数のpassword、password確認で保存出来ること。' do
        newuser = build(:auto_id_user, name: "test01", password: "1", password_confirmation: "1")
        expect(newuser.save).to be_truthy
      end

      it 'followingで対象ユーザーがフォローしているユーザー一覧が取得出来ること' do
        expect(User.find_by(id: 2).following.pluck(:id)).to match_array [3, 4]
      end

      it 'followersで対象ユーザーをフォローしているユーザー一覧が取得出来ること' do
        expect(User.find_by(id: 3).followers.pluck(:id)).to match_array [1, 2]
      end

      it 'followingを登録したユーザーのフォロー数が増えること' do
        # counter_cacheを利用するのでフォロー数が減るケースはやらない。
        # counter_cacheが機能していることを確認する
        user = User.find_by(id: 3)
        new_following_user = User.find_by(id: 5)

        new_following = build(:following,
                              user_id: user,
                              following_user_id: new_following_user)
        new_following.save
        expect { new_following.run_callbacks(:commit)}.to change { user.following_count }.by(1)
      end

      it 'followingされたユーザーのフォロワー数が増えること' do
        # counter_cacheが機能していることを確認する
        user = User.find_by(id: 3)
        new_following_user = User.find_by(id: 5)

        new_following = build(:following,
                              user_id: user,
                              following_user_id: new_following_user)
        new_following.save
        expect { new_following.run_callbacks(:commit) }.to change { new_following_user.followers_count }.by(1)
      end

    end

    context '異常系' do
      before { @user = create(:auto_id_user, name: "test01", password: "pass01", password_confirmation: "pass01") }

      it '同じ名前の登録は許可しないこと' do
        new_user = build(:auto_id_user, name: "test01", password: "pass02", password_confirmation: "pass02")
        expect(new_user.save).to be_falsey
      end

      it '名前なしの登録は許可しないこと' do
        new_user = build(:auto_id_user, name: "", password: "pass", password_confirmation: "pass")
        expect(new_user.save).to be_falsey
      end

      it 'パスワードなしの登録は許可しないこと' do
        new_user = build(:auto_id_user, name: "test01", password: "", password_confirmation: "")
        expect(new_user.save).to be_falsey
      end
    end
  end
end
