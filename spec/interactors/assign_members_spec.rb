require "rails_helper"

describe AssignMembers do
  let!(:event) { create(:event) }
  let(:user_1) { create(:user, uuid: "uuid_1") }
  let(:user_ids) { %w(uuid_1 uuid_2 uuid_3) }
  let(:service) { described_class.new(event, user_ids) }

  before do
    event.add_member(user_1)
  end

  it "creates missed users" do
    expect { service.call }.to change { User.count }.by(2)
  end

  it "assigns members" do
    expect { service.call }.to change { event.users.count }.by(2)
  end
end
