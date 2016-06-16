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
