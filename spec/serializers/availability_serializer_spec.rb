require "rails_helper"

describe AvailabilitySerializer do
  let(:availability) { build(:availability) }
  let(:json) { ActiveModel::SerializableResource.serialize(availability, serializer: described_class).to_json }
  let(:event_json) { parse_json(json)["availability"] }

  it "returns event data" do
    expect(event_json).to be_an_availability_representation
  end
end
