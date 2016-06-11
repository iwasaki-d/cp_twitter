require 'rails_helper'

RSpec.describe "Twitter", type: :request do
  describe "GET /twitter" do
    it "works! (now write some real specs)" do
      get twitter_index_path
      expect(response).to have_http_status(200)
    end
  end
end
