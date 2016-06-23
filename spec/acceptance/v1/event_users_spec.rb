require "rails_helper"
require "rspec_api_documentation/dsl"

resource "Event Users" do
  header "Accept", "application/json"

  subject(:response) { json_response_body }

  let!(:owner) { create(:user) }
  let(:user) { create(:user) }
  let(:event) { create(:event, owner: owner) }
  let(:token) { owner.authentication_token }
  let(:user_id) { user.id }
  let(:event_id) { event.id }

  post "/v1/event_users" do
    parameter :user_id, "User id", required: true
    parameter :event_id, "Event id", required: true
    parameter :token, "Authentication token", required: true

    example_request "Adds new member to event" do
      expect(response_status).to eq 201
      expect(response["event"]).to be_an_event_representation
      expect(response["event"]["users"].first).to be_an_event_user_representation
    end
  end

  delete "/v1/event_users/:id" do
    parameter :user_id, "User id", required: true
    parameter :event_id, "Event id", required: true
    parameter :token, "Authentication token", required: true

    before do
      event.add_member(user)
    end

    example_request "Removes member from event" do
      expect(response_status).to eq 200
      expect(response["event"]).to be_an_event_representation
      expect(response["event"]["users"]).to be_empty
    end
  end
end
