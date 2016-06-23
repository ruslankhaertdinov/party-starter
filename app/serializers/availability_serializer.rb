class AvailabilitySerializer < ApplicationSerializer
  attributes :id, :start_at, :end_at

  def start_at
    object.start_at.to_i
  end

  def end_at
    object.end_at.to_i
  end
end
