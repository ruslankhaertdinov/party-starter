class Event < ActiveRecord::Base
  belongs_to :owner, class_name: "User", foreign_key: :user_id
  has_many :event_users, dependent: :destroy
  has_many :users, through: :event_users
  has_many :availabilities, through: :users
end
