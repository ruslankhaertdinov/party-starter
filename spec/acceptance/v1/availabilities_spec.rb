require "rails_helper"
require "rspec_api_documentation/dsl"

resource "Availabilities" do
  header "Accept", "application/json"

  let!(:user) { create :user, authentication_token: "secret" }
  let(:token) { user.authentication_token }

  subject(:response) { json_response_body }

  post "/v1/availabilities" do
    let(:intervals) { [{ start_at: "1466625300", end_at: "1466625400" }] }

    parameter :intervals, "User availability intervals", required: true, scope: :availability
    parameter :token, "Authentication token", required: true

    example_request "Creates availabilities", token: "secret" do
      expect(response_status).to eq 201
      expect(response["availabilities"]).to be
      expect(response["availabilities"].first).to be_an_availability_representation
    end
  end

  get "/v1/availabilities" do
    parameter :token, "Authentication token", required: true

    before do
      create_list(:availability, 2, user: user)
      create(:availability)
    end

    example_request "Fetches user availabilities" do
      expect(response_status).to eq 200
      expect(response["availabilities"]).to be
      expect(response["availabilities"].size).to eq(2)
      expect(response["availabilities"].first).to be_an_availability_representation
    end
  end
end
