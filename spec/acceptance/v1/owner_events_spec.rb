require "rails_helper"
require "rspec_api_documentation/dsl"

resource "Owner Events" do
  header "Accept", "application/json"

  subject(:response) { json_response_body }

  let!(:user) { create :user }
  let(:token) { user.authentication_token }

  get "/v1/owner_events" do
    let!(:own_event) { create(:event, owner: user) }
    let!(:event_1) { create(:event) }
    let!(:event_2) { create(:event) }

    parameter :token, "Authentication token", required: true

    example_request "Returns own events" do
      expect(response_status).to eq 200
      expect(response["events"].size).to eq(1)
      expect(response["events"].first).to be_an_event_representation
    end
  end
end
