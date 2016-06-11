require 'rails_helper'

RSpec.describe "twitter/show", type: :view do
  before(:each) do
    @twitter = assign(:twitter, Twitter.create!(
      :text => "Text",
      :user_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Text/)
    expect(rendered).to match(/1/)
  end
end
