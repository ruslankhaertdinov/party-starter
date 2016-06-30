require "rails_helper"

describe UpdateAvailability do
  let(:event) { create(:event) }
  let(:user) { create(:user) }
  let(:service) { described_class.new(event, user, intervals) }
  let(:availability) { Availability.last }

  let(:intervals) do
    {
      monday: [{ start_at: "11", end_at: "12" }, { start_at: "15", end_at: "17" }],
      tuesday: [{ start_at: "9", end_at: "10" }, { start_at: "18", end_at: "19" }]
    }.deep_stringify_keys
  end

  it "creates new availability for user" do
    expect { service.call }.to change { user.availabilities.count }.by(1)
    expect(availability.intervals).to eq(intervals)
    expect(availability.user).to eq(user)
    expect(availability.event).to eq(event)
  end
end
