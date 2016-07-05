class AssignMembers
  attr_reader :event, :user_ids
  private :event, :user_ids

  def initialize(event, user_ids)
    @event = event
    @user_ids = user_ids
  end

  def call
    ensure_users_exist
    assign_members
  end

  private

  def ensure_users_exist
    user_ids.each do |uid|
      EnsureUserExistence.new(uid).call
    end
  end

  def assign_members
    participants.each { |user| event.add_member(user) }
  end

  def participants
    User.by_uid(user_ids)
  end
end
