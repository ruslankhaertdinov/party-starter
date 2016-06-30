require "rails_helper"

describe FetchIntersection do
  let(:event) { create(:event) }
  let(:user_1) { create(:user) }
  let(:user_2) { create(:user) }
  let(:user_3) { create(:user) }

  let!(:availability_1) do
    create(:availability, user: user_1, event: event, intervals: {
      monday: [
        { start_at: 0, end_at: 24 }
      ],
      tuesday: [
        { start_at: 0, end_at: 3 },
        { start_at: 7, end_at: 24 }
      ]
    })
  end

  let!(:availability_2) do
    create(:availability, user: user_2, event: event, intervals: {
      monday: [
        { start_at: 3, end_at: 12 },
        { start_at: 14, end_at: 16 },
        { start_at: 20, end_at: 24 }
      ],
      tuesday: [
        { start_at: 1, end_at: 10 }
      ]
    })
  end

  let!(:availability_3) do
    create(:availability, user: user_3, event: event, intervals: {
      monday: [
        { start_at: 5, end_at: 15 },
        { start_at: 20, end_at: 22 }
      ],
      tuesday: [
        { start_at: 0, end_at: 2 },
        { start_at: 3, end_at: 12 }
      ]
    })
  end
  let(:service) { described_class.new(event) }

  let(:expected_intersections) do
    {
      monday: [
        { start_at: 5, end_at: 12 },
        { start_at: 14, end_at: 15 },
        { start_at: 20, end_at: 22 }
      ],
      tuesday: [
        { start_at: 1, end_at: 2 },
        { start_at: 7, end_at: 10 }
      ]
    }
  end

  before do
    event.users << user_1
    event.users << user_2
    event.users << user_3
  end


  it "returns intersections" do
    expect(service.call).to eq(expected_intersections)
  end
end
