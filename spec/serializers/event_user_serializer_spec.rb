require "rails_helper"

describe EventUserSerializer do
  let(:user) { build :user }
  let(:json) { ActiveModel::SerializableResource.serialize(user, serializer: described_class).to_json }
  let(:user_json) { parse_json(json)["user"] }

  it "returns user" do
    expect(user_json).to be_an_event_user_representation
  end
end
