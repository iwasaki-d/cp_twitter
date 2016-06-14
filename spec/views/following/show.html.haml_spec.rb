require 'rails_helper'

RSpec.describe "following/show", type: :view do
  before(:each) do
    @following = assign(:following, Following.create!(
      :user_id => 1,
      :following_user_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
  end
end
