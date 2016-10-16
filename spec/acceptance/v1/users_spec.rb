require "rails_helper"
require "rspec_api_documentation/dsl"

resource "Users" do
  header "Accept", "application/json"

  subject(:response) { json_response_body }

  let(:uuid) { SecureRandom.hex(6) }
  let(:key) { ENV.fetch("APP_KEY") }

  post "/v1/users" do
    parameter :uuid, "User oauth uuid", required: true, scope: :user
    parameter :key, "App secret key", required: true

    example_request "Creating new user" do
      expect(response_status).to eq 201
      expect(response["user"]).to be_a_session_representation(User.last)
    end
  end
end
