class Availability < ActiveRecord::Base
  belongs_to :event
  belongs_to :user

  validates :event, :user, presence: true
  validates :event, uniqueness: { scope: :user }
end
