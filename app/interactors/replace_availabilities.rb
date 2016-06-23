class ReplaceAvailabilities
  attr_reader :intervals, :user
  private :intervals, :user

  def initialize(intervals, user)
    @intervals = intervals
    @user = user
  end

  def call
    ActiveRecord::Base.transaction do
      user.availabilities.destroy_all

      intervals.each do |interval|
        user.availabilities.create!(
          time_params(interval)
        )
      end
    end
    user.reload.availabilities
  end

  private

  def time_params(interval)
    {
      start_at: Time.zone.at(interval["start_at"].to_i),
      end_at: Time.zone.at(interval["end_at"].to_i)
    }
  end
end
