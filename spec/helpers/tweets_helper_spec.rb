require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the CommentsHelper. For example:
#
# describe CommentsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe TweetsHelper, type: :helper do
  describe 'initialize_remains_body_characters' do
    it '典型的なユーザー名' do
      expect(helper.initialize_remains_body_characters('@user1')).to eq(134)
    end

    it 'ユーザー名入力がなかった場合' do
      expect(helper.initialize_remains_body_characters('')).to eq(140)
    end
  end
end
