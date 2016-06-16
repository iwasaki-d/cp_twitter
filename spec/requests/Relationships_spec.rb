require 'rails_helper'

RSpec.describe "Relationship", type: :request do
  describe "GET /relationship" do
    it "works! (now write some real specs)" do
      get relationships_index_path
      expect(response).to have_http_status(200)
    end
  end
end
