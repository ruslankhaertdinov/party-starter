class EventSerializer < ApplicationSerializer
  attributes :id, :name, :description, :start_at, :end_at, :is_weekly, :intersections

  belongs_to :owner, serializer: UserSerializer

  has_many :participants
  has_many :checked_participants

  def start_at
    object.start_at.to_i
  end

  def end_at
    object.end_at.to_i
  end

  def participants
    object.users
  end

  def checked_participants
    object.users.joins(:availabilities).where(availabilities: { event_id: object.id })
  end

  def is_weekly
    true # stub
  end

  def intersections
    FetchIntersection.new(object).call
  end
end
