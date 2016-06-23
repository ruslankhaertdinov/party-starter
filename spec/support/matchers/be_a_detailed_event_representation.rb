RSpec::Matchers.define :be_an_event_representation do
  match do |json|
    response_attributes = %w(
      id
      name
      description
      start_at
      end_at
    )

    expect(json).to be
    expect(json.keys).to match_array(response_attributes)
  end
end
