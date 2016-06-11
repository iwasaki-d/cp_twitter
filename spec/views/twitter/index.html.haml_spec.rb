require 'rails_helper'

RSpec.describe "twitter/index", type: :view do
  before(:each) do
    assign(:twitter, [
      Twitter.create!(
        :text => "Text",
        :user_id => 1
      ),
      Twitter.create!(
        :text => "Text",
        :user_id => 1
      )
    ])
  end

  it "renders a list of twitter" do
    render
    assert_select "tr>td", :text => "Text".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
