require "rails_helper"

describe FetchIntersection do
  let(:event) { create(:event, owner: user_1) }
  let(:user_1) { create(:user) }
  let(:user_2) { create(:user) }
  let(:user_3) { create(:user) }
  let(:service) { described_class.new(event.users) }

  context "when 1 to 1 availability matching" do
    let(:expected_intersections) do
      [
        Time.zone.parse("Fri, 17 Jun 2016 12:20:00")..Time.zone.parse("Fri, 17 Jun 2016 13:00:00"),
        Time.zone.parse("Fri, 17 Jun 2016 14:20:00")..Time.zone.parse("Fri, 17 Jun 2016 15:00:00")
      ]
    end

    before do
      event.users << user_1
      event.users << user_2
      event.users << user_3
    end


    it "returns intersections" do
      pending

      expect(service.call).to eq(expected_intersections)
    end
  end
end
