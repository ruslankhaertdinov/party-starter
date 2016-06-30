RSpec::Matchers.define :be_a_user_representation do |user|
  match do |json|
    response_attributes = %w(uid)

    expect(json).to be
    expect(json.keys).to match_array(response_attributes)
  end
end
