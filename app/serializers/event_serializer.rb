class EventSerializer < ApplicationSerializer
  attributes :id, :name, :description, :start_at, :end_at, :intersections

  has_many :users, serializer: EventUserSerializer

  def start_at
    object.start_at.to_i
  end

  def end_at
    object.end_at.to_i
  end

  def intersections
    FetchIntersection.new(object.users).call
  end
end
