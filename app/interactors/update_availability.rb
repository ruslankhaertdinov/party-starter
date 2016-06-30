class UpdateAvailability
  attr_reader :event, :user, :intervals
  private :event, :user, :intervals

  def initialize(event, user, intervals)
    @event = event
    @user = user
    @intervals = intervals
  end

  def call
    ActiveRecord::Base.transaction do
      destroy_old_availability
      build_new_availability
    end
  end

  private

  def destroy_old_availability
    user.availabilities.where(event_id: event.id).destroy_all
  end

  def build_new_availability
    user.availabilities.create!(availability_params)
  end

  def availability_params
    {
      event_id: event.id,
      intervals: intervals
    }
  end
end
