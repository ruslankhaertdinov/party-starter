class FetchIntersection
  attr_reader :event
  private :event

  def initialize(event)
    @event = event
  end

  def call
    week_intersections = {}
    sorted_availabilities.each do |day_name, intervals|
      current_count = 0
      day_intersections = []

      (intervals.first["start_at"]..intervals.last["end_at"]).each do |time|
        previous_count = current_count
        current_count += opened_intervals_count(intervals, time)
        current_count -= closed_intervals_count(intervals, time)

        if interval_started?(previous_count, current_count)
          day_intersections << { start_at: time }
        end
        if interval_finished?(previous_count, current_count)
          day_intersections.last[:end_at] = time
        end
      end

      week_intersections[day_name.to_sym] = day_intersections if day_intersections.any?
    end

    week_intersections
  end

  private

  def sorted_availabilities
    @sorted_availabilities ||=
      {}.tap do |h|
        availabilities.each do |k, v|
          h[k] = v.sort_by { |interval| interval["start_at"]  }
        end
      end
  end

  def availabilities
    @availabilities ||=
      {}.tap do |h|
        checked_users.each do |user|
          day_names.each do |day_name|
            availability = user.availability_for_event(event)
            next unless availability

            intervals = availability.intervals[day_name]
            if intervals
              h[day_name] ||= []
              h[day_name] += intervals
            end
          end
        end
      end
  end

  def day_names
    Date::DAYNAMES.map(&:downcase)
  end

  def checked_users
    @checked_users ||= event.users.joins(:availabilities).where(availabilities: { event_id: event.id })
  end

  def checked_users_count
    checked_users.count
  end

  def interval_finished?(previous_count, current_count)
    previous_count == checked_users_count && current_count != checked_users_count
  end

  def interval_started?(previous_count, current_count)
    previous_count != checked_users_count && current_count == checked_users_count
  end

  def opened_intervals_count(intervals, time)
    intervals.select { |a| a["start_at"] == time }.size
  end

  def closed_intervals_count(intervals, time)
    intervals.select { |a| a["end_at"] == time }.size
  end
end
