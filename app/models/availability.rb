class Availability < ActiveRecord::Base
  belongs_to :event
  belongs_to :user

  validates :event, :user, presence: true
  validates :event, uniqueness: { scope: :user }

  scope :for_event, -> (event) { where(event_id: event.id) }
end
