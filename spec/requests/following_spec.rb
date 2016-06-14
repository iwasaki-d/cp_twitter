require 'rails_helper'

RSpec.describe "Following", type: :request do
  describe "GET /following" do
    it "works! (now write some real specs)" do
      get following_index_path
      expect(response).to have_http_status(200)
    end
  end
end
