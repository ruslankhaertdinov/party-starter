class AssignMembers
  attr_reader :event, :uuids
  private :event, :uuids

  def initialize(event, uuids)
    @event = event
    @uuids = uuids
  end

  def call
    ensure_users_exist
    assign_members
  end

  private

  def ensure_users_exist
    uuids.each do |uuid|
      EnsureUserExistence.new(uuid).call
    end
  end

  def assign_members
    participants.each { |user| event.add_member(user) }
  end

  def participants
    User.by_uuid(uuids)
  end
end
