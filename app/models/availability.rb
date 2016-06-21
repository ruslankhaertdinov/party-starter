class Availability < ActiveRecord::Base
  belongs_to :user

  validates :user, :start_time, :end_time, presence: true
end
