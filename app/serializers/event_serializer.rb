class EventSerializer < ApplicationSerializer
  attributes :id, :name, :description, :start_at, :end_at

  belongs_to :owner, serializer: UserSerializer

  has_many :participants, serializer: EventUserSerializer
  has_many :checked_participants, serializer: EventUserSerializer

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
    # TODO: need refactoring
    user_ids = Availability.where(event_id: object.id).pluck(:user_id)
    User.where(id: user_ids)
  end
end
