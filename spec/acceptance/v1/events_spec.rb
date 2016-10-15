require "rails_helper"
require "rspec_api_documentation/dsl"

resource "Events" do
  header "Accept", "application/json"

  subject(:response) { json_response_body }

  let!(:user) { create :user }

  before do
    header "X-AUTH-TOKEN", user.authentication_token
  end

  get "/v1/events" do
    let!(:event_1) { create(:event) }
    let!(:event_2) { create(:event) }
    let!(:event_3) { create(:event) }

    before do
      event_1.add_member(user)
      event_2.add_member(user)
    end

    example_request "Get events where user participant" do
      expect(response_status).to eq 200
      expect(response["events"].size).to eq(2)
      expect(response["events"].first).to be_a_brief_event_representation
    end
  end

  get "/v1/events/:id" do
    let(:event) { create(:event) }
    let(:id) { event.id }

    before do
      event.users << user
    end

    example_request "Show event" do
      expect(response_status).to eq 200
      expect(response["event"]).to be_an_event_representation
    end
  end

  post "/v1/events" do
    let(:user_1) { create(:user) }
    let(:user_2) { create(:user) }
    let(:user_ids) { [user_1.authentication_token, user_2.authentication_token] }

    parameter :name, "Event name", required: true, scope: :event
    parameter :description, "Event description", scope: :event
    parameter :user_ids, "Participants of event", scope: :event

    example_request "Creates event with valid params", event: { name: "Meeting" } do
      expect(response_status).to eq 200
      expect(response["event"]).to be_a_brief_event_representation
    end

    example_request "Creates event with invalid params", event: { name: "" } do
      expect(response_status).to eq 422
      expect(response["error"]).to eq(["Name can't be blank"])
    end
  end

  delete "/v1/events/:id" do
    let(:event) { create(:event, owner: user) }
    let(:id) { event.id }
    let(:participant) { create(:user, authentication_token: "participant_token") }

    before do
      event.users << participant
    end

    example_request "Delete own event" do
      expect(response_status).to eq 200
      expect(response["event"]).to be_a_brief_event_representation
    end
  end

  patch "/v1/events/:id" do
    let(:event) { create(:event, owner: user) }
    let(:id) { event.id }
    let(:participant) { create(:user, authentication_token: "participant_token") }

    before do
      event.users << participant
    end

    parameter :name, "Event title", required: true, scope: :event
    parameter :description, "Event description", scope: :event

    example_request "Update event with valid params", name: "New name" do
      expect(response["event"]).to be_a_brief_event_representation
      expect(response["event"]["name"]).to eq("New name")
    end

    example_request "Update event with invalid params", name: "" do
      expect(response_status).to eq 422
      expect(response["error"]).to eq(["Name can't be blank"])
    end
  end
end
