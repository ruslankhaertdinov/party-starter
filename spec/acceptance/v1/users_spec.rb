require "rails_helper"
require "rspec_api_documentation/dsl"

resource "Users" do
  header "Accept", "application/json"

  subject(:response) { json_response_body }

  let(:id) { SecureRandom.hex(6) }

  post "/v1/users" do
    parameter :id, "User oauth id", required: true

    example_request "Adds new member to event" do
      expect(response_status).to eq 201
      expect(response["user"]).to be_a_user_representation
      expect(response["user"]["authentication_token"]).to be
    end
  end
end
