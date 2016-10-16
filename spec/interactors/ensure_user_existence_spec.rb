require "rails_helper"

describe EnsureUserExistence do
  let(:uuid) { SecureRandom.hex(6) }
  let(:service) { described_class.new(uuid) }
  let(:user) { User.last }

  it "creates user with uuid" do
    expect { service.call }.to change { User.count }.by(1)
    expect(user.email).to match(EnsureUserExistence::DEFAULT_EMAIL)
    expect(user.uuid).to eq(uuid)
    expect(user.authentication_token).to be
  end
end
