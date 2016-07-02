require "rails_helper"
require "rspec_api_documentation/dsl"

resource "Events" do
  header "Accept", "application/json"

  subject(:response) { json_response_body }

  let!(:user) { create :user }
  let(:uid) { user.authentication_token }

  get "/v1/events" do
    let!(:event_1) { create(:event) }
    let!(:event_2) { create(:event) }
    let!(:event_3) { create(:event) }

    before do
      event_1.add_member(user)
      event_2.add_member(user)
    end

    parameter :uid, "User uid", required: true

    example_request "Returns events where user was added" do
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

    parameter :uid, "User uid", required: true

    example_request "Shows detailed event information" do
      expect(response_status).to eq 200
      expect(response["event"]).to be_an_event_representation
    end
  end

  post "/v1/events" do
    let(:user_1) { create(:user) }
    let(:user_2) { create(:user) }
    let(:name) { "Meeting" }
    let(:description) { "Repetition" }
    let(:user_ids) { [user_1.authentication_token, user_2.authentication_token] }

    parameter :name, name, required: true, scope: :event
    parameter :description, description, scope: :event
    parameter :user_ids, "Participants of event", scope: :event
    parameter :uid, "User uid", required: true

    example_request "Creates event with valid params" do
      expect(response["event"]).to be_a_brief_event_representation
    end

    example_request "Creates event with invalid user token", uid: "wrong_uid" do
      expect(response_status).to eq 401
      expect(response["error"]).to eq("Unauthorized")
    end

    example "Creates event with invalid params" do
      do_request(event: { name: "", description: "" })

      expect(response_status).to eq 422
      expect(response["error"]).to eq(["Name can't be blank"])
    end
  end

  delete "/v1/events/:id" do
    let(:event) { create(:event) }
    let(:id) { event.id }

    before do
      event.users << user
    end

    parameter :uid, "User uid", required: true

    example_request "Returns deleted resource document" do
      expect(response_status).to eq 200
      expect(response["event"]).to be_a_brief_event_representation
    end
  end
end
