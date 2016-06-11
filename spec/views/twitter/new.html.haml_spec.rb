require 'rails_helper'

RSpec.describe "twitter/new", type: :view do
  before(:each) do
    assign(:twitter, Twitter.new(
      :text => "MyString",
      :user_id => 1
    ))
  end

  it "renders new twitter form" do
    render

    assert_select "form[action=?][method=?]", twitter_index_path, "post" do

      assert_select "input#twitter_text[name=?]", "twitter[text]"

      assert_select "input#twitter_user_id[name=?]", "twitter[user_id]"
    end
  end
end
