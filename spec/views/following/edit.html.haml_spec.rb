require 'rails_helper'

RSpec.describe "following/edit", type: :view do
  before(:each) do
    @following = assign(:following, Following.create!(
      :user_id => 1,
      :following_user_id => 1
    ))
  end

  it "renders the edit following form" do
    render

    assert_select "form[action=?][method=?]", following_path(@following), "post" do

      assert_select "input#following_user_id[name=?]", "following[user_id]"

      assert_select "input#following_following_user_id[name=?]", "following[following_user_id]"
    end
  end
end
