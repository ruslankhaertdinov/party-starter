RSpec::Matchers.define :be_an_availability_representation do
  match do |json|
    response_attributes = %w(
      id
      start_at
      end_at
    )

    expect(json).to be
    expect(json.keys).to match_array(response_attributes)
  end
end
