RSpec::Matchers.define :be_an_event_user_representation do
  match do |json|
    response_attributes = %w(uid)

    expect(json).to be
    expect(json.keys).to match_array(response_attributes)
  end
end
