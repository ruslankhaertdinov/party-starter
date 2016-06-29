require "rails_helper"

describe BriefEventSerializer do
  let(:event) { build(:event) }
  let(:json) { ActiveModel::SerializableResource.serialize(event, serializer: described_class).to_json }
  let(:event_json) { parse_json(json)["event"] }

  it "returns event data" do
    expect(event_json).to be_a_brief_event_representation
  end
end
