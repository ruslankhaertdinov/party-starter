class Event < ActiveRecord::Base
  belongs_to :owner, class_name: "User", foreign_key: :user_id
  has_many :event_users, dependent: :destroy
  has_many :users, through: :event_users
  has_many :availabilities, through: :users

  validates :name, presence: true

  def add_member(user)
    EventUser.where(
      event_id: id,
      user_id: user.id
    ).first_or_create!
  end

  def remove_member(user)
    EventUser.where(
      event_id: id,
      user_id: user.id
    ).destroy_all
  end
end
