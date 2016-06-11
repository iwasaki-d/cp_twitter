require 'rails_helper'

RSpec.describe "twitter/edit", type: :view do
  before(:each) do
    @twitter = assign(:twitter, Twitter.create!(
      :text => "MyString",
      :user_id => 1
    ))
  end

  it "renders the edit twitter form" do
    render

    assert_select "form[action=?][method=?]", twitter_path(@twitter), "post" do

      assert_select "input#twitter_text[name=?]", "twitter[text]"

      assert_select "input#twitter_user_id[name=?]", "twitter[user_id]"
    end
  end
end
