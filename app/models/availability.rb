class Availability < ActiveRecord::Base
  belongs_to :user

  validates :user, :start_at, :end_at, presence: true
end
