require "rails_helper"
require "rspec_api_documentation/dsl"

resource "Users" do
  header "Accept", "application/json"

  subject(:response) { json_response_body }

  let(:uid) { SecureRandom.hex(6) }
  let(:key) { ENV.fetch("APP_KEY") }

  post "/v1/users" do
    parameter :uid, "User oauth uid", required: true
    parameter :key, "App secret key", required: true

    example_request "Creating new user" do
      expect(response_status).to eq 201
      expect(response["user"]).to be_a_user_representation
      expect(response["user"]["uid"]).to be
    end
  end

  put "/v1/users/:id" do
    let!(:user) { create(:user, authentication_token: "secret") }

    let(:availability) do
      {
        monday: [{ start_at: "11", end_at: "12" }, { start_at: "15", end_at: "17" }],
        tuesday: [{ start_at: "9", end_at: "10" }, { start_at: "18", end_at: "19" }]
      }
    end

    parameter :availability, "User weekly availability", required: true, scope: :user
    parameter :uid, "User oauth uid", required: true

    example_request "Updates availability", uid: "secret" do
      expect(response_status).to eq 200
      expect(response["user"]).to be_a_user_representation
    end
  end
end
