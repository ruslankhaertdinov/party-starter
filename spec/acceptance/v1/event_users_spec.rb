require "rails_helper"
require "rspec_api_documentation/dsl"

resource "Event Users" do
  header "Accept", "application/json"

  subject(:response) { json_response_body }

  let!(:owner) { create(:user) }
  let(:user) { create(:user) }
  let(:event) { create(:event, owner: owner) }
  let(:event_id) { event.id }

  before do
    header "X-AUTH-TOKEN", owner.authentication_token
  end

  post "/v1/event_users" do
    let(:uuids) { [user.uuid] }

    with_options required: true do |r|
      r.parameter :uuids, "User uuids"
      r.parameter :event_id, "Event id"
    end

    example_request "Add new members to event" do
      expect(response_status).to eq 201
      expect(response["event"]).to be_an_event_representation
      expect(response["event"]["participants"].first).to be_a_user_representation
    end
  end

  delete "/v1/event_users/" do
    let(:uuid) { user.uuid }

    with_options required: true do |r|
      r.parameter :uuid, "User uuid"
      r.parameter :event_id, "Event id"
    end

    before do
      event.add_member(user)
    end

    example_request "Remove member from event" do
      expect(response_status).to eq 200
      expect(response["event"]).to be_an_event_representation
      expect(response["event"]["participants"]).to be_empty
    end
  end
end
