require 'rails_helper'

RSpec.describe TweetsHelper, type: :helper do
  describe 'initialize_remains_body_characters' do
    subject { helper.initialize_remains_body_characters(body) }

    context '入力がある場合' do
      let(:body) { '@user1' }
      it '入力可能な残り文字数を返すこと' do
        is_expected.to eq(134)
      end
    end

    context '入力がない場合' do
      let(:body) { '' }
      it '入力可能な残り文字数として最大文字数を返すこと' do
        is_expected.to eq(140)
      end
    end
  end
end
