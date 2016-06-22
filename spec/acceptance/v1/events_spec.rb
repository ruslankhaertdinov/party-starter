require "rails_helper"
require "rspec_api_documentation/dsl"

resource "Events" do
  header "Accept", "application/json"

  subject(:response) { json_response_body }

  post "/v1/events" do
    let(:user) { create :user }
    let(:name) { "Meeting" }
    let(:description) { "Repetition" }

    parameter :name, name, required: true, scope: :event
    parameter :description, description, scope: :event

    example "Creates event with valid params" do
      do_request(token: user.authentication_token)
      expect(response["event"]).to be_an_event_representation
    end

    example_request "Creates event with invalid user token" do
      expect(response_status).to eq 401
      expect(response["error"]).to eq("Unauthorized")
    end

    example "Creates event with invalid params" do
      do_request(token: user.authentication_token, event: { name: "", description: "" })

      expect(response_status).to eq 422
      expect(response["error"]).to eq(["Name can't be blank"])
    end
  end
end
