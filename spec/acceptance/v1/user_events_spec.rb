require "rails_helper"
require "rspec_api_documentation/dsl"

resource "User Events" do
  header "Accept", "application/json"

  subject(:response) { json_response_body }

  let!(:user) { create :user }
  let(:token) { user.authentication_token }

  get "/v1/user_events" do
    let!(:own_event) { create(:event, owner: user) }
    let!(:event_1) { create(:event) }
    let!(:event_2) { create(:event) }

    before do
      event_1.users << user
      event_2.users << user
    end

    parameter :token, "Authentication token", required: true

    example_request "Returns events where user was added" do
      expect(response_status).to eq 200
      expect(response["events"]).to be
      expect(response["events"].first).to be_an_event_representation
    end
  end
end
