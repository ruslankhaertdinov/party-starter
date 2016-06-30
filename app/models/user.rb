class User < ActiveRecord::Base
  acts_as_token_authenticatable

  devise :database_authenticatable, :registerable,
    :recoverable, :trackable, :validatable

  has_many :own_events, class_name: "Event", foreign_key: "user_id", dependent: :destroy
  has_many :event_users, dependent: :destroy
  has_many :events, through: :event_users
  has_many :availabilities, dependent: :destroy
end
