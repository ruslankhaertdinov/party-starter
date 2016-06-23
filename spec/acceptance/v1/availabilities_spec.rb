require "rails_helper"
require "rspec_api_documentation/dsl"

resource "Availabilities" do
  header "Accept", "application/json"

  subject(:response) { json_response_body }

  post "/v1/availabilities" do
    let!(:user) { create :user, authentication_token: "secret" }
    let(:intervals) { [{ start_at: "1466625300", end_at: "1466625400" }] }

    parameter :intervals, "User availability intervals", required: true, scope: :availability

    example_request "Creates availabilities", token: "secret" do
      expect(response["availabilities"]).to be
      expect(response["availabilities"].first).to be_an_availability_representation
    end
  end
end
