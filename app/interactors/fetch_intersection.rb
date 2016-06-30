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
        if prev == users_count && counter != users_count
          intersections[day_name.to_sym].last[:end_at] = n
        end
        if prev != users_count && counter == users_count
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
        users.each do |user|
          day_names.each do |day_name|
            day_availabilities = user.availabilities.where(event_id: event.id).first.intervals[day_name]
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

  def users_count
    users.size
  end

  def users
    event.users
  end
end
