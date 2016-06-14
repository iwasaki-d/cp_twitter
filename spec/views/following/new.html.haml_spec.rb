require 'rails_helper'

RSpec.describe "following/new", type: :view do
  before(:each) do
    assign(:following, Following.new(
      :user_id => 1,
      :following_user_id => 1
    ))
  end

  it "renders new following form" do
    render

    assert_select "form[action=?][method=?]", following_index_path, "post" do

      assert_select "input#following_user_id[name=?]", "following[user_id]"

      assert_select "input#following_following_user_id[name=?]", "following[following_user_id]"
    end
  end
end
