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
    parameter :description, description, required: true, scope: :event

    example "Sign in with valid password" do
      do_request(token: user.authentication_token)
      expect(response["event"]).to be_an_event_representation
    end
  end
end
