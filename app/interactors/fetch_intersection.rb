class FetchIntersection
  attr_reader :event
  private :event

  def initialize(event)
    @event = event
  end

  def call
    intersections = {}
    sorted_availabilities.each do |day_name, intervals|
      counter = 0
      intersections[day_name.to_sym] ||= []
      first = intervals.first["start_at"]
      last = intervals.last["end_at"]

      (first..last).each do |n|
        prev = counter
        counter += intervals.select { |a| a["start_at"] == n }.size
        counter -= intervals.select { |a| a["end_at"] == n }.size
        if prev == checked_users_count && counter != checked_users_count
          intersections[day_name.to_sym].last[:end_at] = n
        end
        if prev != checked_users_count && counter == checked_users_count
          intersections[day_name.to_sym] << { start_at: n }
        end
      end
    end

    intersections
  end

  private

  def joined_availabilities
    @joined_availabilities ||=
      {}.tap do |h|
        checked_users.each do |user|
          day_names.each do |day_name|
            day_availabilities = user.availability_for_event(event).intervals[day_name]
            if day_availabilities
              h[day_name] ||= []
              h[day_name] += day_availabilities
            end
          end
        end
      end
  end

  def sorted_availabilities
    @sorted_availabilities ||=
      {}.tap do |h|
        joined_availabilities.each do |k, v|
          h[k] = v.sort_by { |interval| interval["start_at"]  }
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
end
