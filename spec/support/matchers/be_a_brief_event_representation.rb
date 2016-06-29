RSpec::Matchers.define :be_a_brief_event_representation do
  match do |json|
    response_attributes = %w(
      id
      name
      description
      owner
      is_weekly
    )

    expect(json).to be
    expect(json.keys).to match_array(response_attributes)
  end
end
