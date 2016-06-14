require 'rails_helper'

RSpec.describe "following/index", type: :view do
  before(:each) do
    assign(:following, [
      Following.create!(
        :user_id => 1,
        :following_user_id => 2
      ),
      Following.create!(
        :user_id => 1,
        :following_user_id => 2
      )
    ])
  end

  it "renders a list of following" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
