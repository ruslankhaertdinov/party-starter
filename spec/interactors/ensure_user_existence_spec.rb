require "rails_helper"

describe EnsureUserExistence do
  let(:token) { SecureRandom.hex(6) }
  let(:service) { described_class.new(token) }
  let(:user) { User.last }

  it "creates user with token" do
    expect { service.call }.to change { User.count }.by(1)
    expect(user.email).to match(EnsureUserExistence::DEFAULT_EMAIL)
    expect(user.authentication_token).to eq(token)
  end
end
