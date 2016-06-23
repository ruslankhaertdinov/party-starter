require "rails_helper"
require "rspec_api_documentation/dsl"

resource "Events" do
  header "Accept", "application/json"

  subject(:response) { json_response_body }

  let!(:user) { create :user }
  let(:token) { user.authentication_token }

  get "/v1/events" do
    let!(:event_1) { create(:event) }
    let!(:event_2) { create(:event) }
    let!(:event_3) { create(:event) }

    before do
      event_1.users << user
      event_2.users << user
    end

    parameter :token, "Authentication token", required: true

    example_request "Returns events where user was added" do
      expect(response_status).to eq 200
      expect(response["events"].size).to eq(2)
      expect(response["events"].first).to be_an_event_representation
    end
  end

  get "/v1/events/:id" do
    let(:event) { create(:event) }
    let(:id) { event.id }

    before do
      event.users << user
    end

    parameter :token, "Authentication token", required: true

    example_request "Shows detailed event information" do
      expect(response_status).to eq 200
      expect(response["event"]).to be_an_event_representation
    end
  end

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
end
