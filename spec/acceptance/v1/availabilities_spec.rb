require "rails_helper"
require "rspec_api_documentation/dsl"

resource "Availabilities" do
  header "Accept", "application/json"

  subject(:response) { json_response_body }

  let(:user) { create(:user) }
  let(:uid) { user.authentication_token }
  let(:event) { create(:event) }
  let(:event_id) { event.id }
  let(:intervals) do
    {
      monday: [{ start_at: "11", end_at: "12" }, { start_at: "15", end_at: "17" }],
      tuesday: [{ start_at: "9", end_at: "10" }, { start_at: "18", end_at: "19" }]
    }
  end

  before do
    event.users << user
  end

  get "/v1/availabilities/:id" do
    parameter :event_id, "Event id", required: true, scope: :availability
    parameter :uid, "User oauth uid", required: true

    before do
      create(:availability, event: event, user: user)
    end

    example_request "Getting availability details for given event" do
      expect(response_status).to eq 200
      expect(response["availability"]).to be_an_availability_representation
    end
  end

  post "/v1/availabilities" do
    parameter :event_id, "Event id", required: true, scope: :availability
    parameter :intervals, "Available intervals", required: true, scope: :availability

    parameter :uid, "User oauth uid", required: true

    example_request "Creating new availability or updating existing one" do
      expect(response_status).to eq 201
      expect(response["availability"]).to be_an_availability_representation
    end
  end
end
