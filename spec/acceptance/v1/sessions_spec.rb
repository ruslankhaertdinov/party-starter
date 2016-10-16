require "rails_helper"
require "rspec_api_documentation/dsl"

resource "Sessions" do
  header "Accept", "application/json"

  subject(:response) { json_response_body }

  post "/v1/users/sign_in" do
    let!(:user) { create :user, uuid: "secret" }
    let(:uuid)  { user.uuid }

    parameter :uuid, "UUID from social network", required: true

    example_request "Sign in with valid uuid" do
      expect(response["user"]).to be_a_session_representation(user)
    end

    example_request "Sign in with invalid uuid", uuid: "" do
      expect(response_status).to eq 401
      expect(response).to be_an_error_representation(:unauthorized, "Invalid UUID.")
    end
  end
end
