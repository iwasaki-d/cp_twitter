require 'rails_helper'

RSpec.describe Relationship, type: :model do
  describe '#create' do
    context '正常系' do
      it 'ユーザーとフォローするユーザーを揃えれば保存出来ること' do
        new_relationship = Relationship.new
        new_relationship.user = User.find(5)
        new_relationship.following_user = User.find(1)

        expect(new_relationship.save).to be_truthy
      end
    end

    context '異常系' do
      it '空ユーザーは登録できないこと' do
        new_relationship = Relationship.new
        new_relationship.user = User.new
        new_relationship.following_user = User.find(1)

        not_to_be_valid_presence(new_relationship, :user_id)
      end

      it '空のユーザーフォローは登録できないこと' do
        new_relationship = Relationship.new
        new_relationship.user = User.find(5)
        new_relationship.following_user = User.new

        not_to_be_valid_presence(new_relationship, :following_user_id)
      end

      it '同じユーザーフォローは登録できないこと' do
        new_relationship = Relationship.new
        new_relationship.user = User.find(1)
        new_relationship.following_user = User.find(2)

        expect(new_relationship.save).to be_falsey
      end
    end
  end

  describe '#destroy' do
    context '正常系' do
      it 'フォローを削除してもフォロー先のユーザーは削除されないこと' do
        following_relationship = User.find(3).following_relationships.first
        following_user_id = following_relationship.following_user_id

        following_relationship.destroy

        expect(User.find(following_user_id)).to be_present
      end
    end
  end
end
