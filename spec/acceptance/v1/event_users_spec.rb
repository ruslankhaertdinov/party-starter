require "rails_helper"
require "rspec_api_documentation/dsl"

resource "Event Users" do
  header "Accept", "application/json"

  subject(:response) { json_response_body }

  let!(:owner) { create(:user) }
  let!(:event_id) { create(:event, owner: owner).id }
  let!(:user_id) { create(:user).id }
  let(:token) { owner.authentication_token }

  post "/v1/event_users" do
    parameter :user_id, "User id", required: true
    parameter :event_id, "Event id", required: true
    parameter :token, "Authentication token", required: true

    example_request "Returns events where user was added" do
      expect(response_status).to eq 201
      expect(response["event"]).to be_an_event_representation
    end
  end
end
