class EventUser < ActiveRecord::Base
  belongs_to :event
  belongs_to :user

  validates :event, :user, presence: true
  validates :user, uniqueness: { scope: :event_id }
end
