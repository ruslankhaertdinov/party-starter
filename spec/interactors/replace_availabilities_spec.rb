require "rails_helper"

describe ReplaceAvailabilities do
  let(:params) do
    [
      { "start_at" => "1466625300", "end_at" => "1466625400" },
      { "start_at" => "1466625500", "end_at" => "1466625600" }
    ]
  end
  let(:user) { create(:user) }
  let(:service) { described_class.new(params, user) }

  it "creates new availabilities for the user" do
    expect { service.call }.to change { user.availabilities.count }.by(2)
  end

  it "returns created availabilities list" do
    expect(service.call).to match_array(user.availabilities)
  end

  it "destroys existing availabilities" do
    availability = create(:availability, user: user)
    expect(Availability.where(id: availability.id)).to be

    service.call
    expect(Availability.where(id: availability.id)).to be_empty
  end
end
