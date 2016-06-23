require "rails_helper"
require "rspec_api_documentation/dsl"

resource "Events" do
  header "Accept", "application/json"

  subject(:response) { json_response_body }

  let!(:user) { create :user }
  let(:token) { user.authentication_token }

  post "/v1/events" do
    let(:name) { "Meeting" }
    let(:description) { "Repetition" }

    parameter :name, name, required: true, scope: :event
    parameter :description, description, scope: :event
    parameter :token, "Authentication token", required: true

    example_request "Creates event with valid params" do
      expect(response["event"]).to be_an_event_representation
    end

    example_request "Creates event with invalid user token", token: "wrong_token" do
      expect(response_status).to eq 401
      expect(response["error"]).to eq("Unauthorized")
    end

    example "Creates event with invalid params" do
      do_request(event: { name: "", description: "" })

      expect(response_status).to eq 422
      expect(response["error"]).to eq(["Name can't be blank"])
    end
  end

  get "/v1/events" do
    before do
      create_list(:event, 2, owner: user)
      create(:event)
    end

    parameter :token, "Authentication token", required: true

    example_request "Fetches own events" do
      expect(response["events"]).to be
      expect(response["events"].size).to eq(2)
      expect(response["events"].first).to be_an_event_representation
    end
  end
end
