require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    context '正常系' do
      before { @user = build(:user, name: "test01", password: "pass01", password_confirmation: "pass01") }

      it 'nameとpassword、password確認で保存出来ること' do
        expect(@user.save).to be_truthy
      end
    end

    context '異常系' do
      before { @user = create(:user, name: "test01", password: "pass01", password_confirmation: "pass01") }

      it '同じ名前の登録は許可しないこと' do
        new_user = build(:user, name: "test01", password: "pass02", password_confirmation: "pass02")
        expect(new_user.save).to be_falsey
      end
    end

  end
end
