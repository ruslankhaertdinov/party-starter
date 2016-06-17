class FetchIntersection
  attr_reader :users
  private :users

  def initialize(users)
    @users = users
  end

  def call
    intersections = Hash.new([])

    user.availabilities.each do |availability|
      comparable_users.each do |comparable_user|
        overlaped = overlaped_availabilities(comparable_user, availability)
        intersections.delete(availability.id) and break if overlaped.empty? # check until first blank overlapping

        intersections[availability.id] |= overlaped.map { |a| a.start_time..a.end_time }
        intersections[availability.id] |= range_for(availability)
      end
    end

    intersections.values.map(&:intersection)
  end

  private

  def user
    users.first
  end

  def comparable_users
    User.where.not(id: user.id)
  end

  def overlaped_availabilities(user, availability)
    user
      .availabilities
      .where("('#{availability.start_time}', '#{availability.end_time}') OVERLAPS (start_time, end_time)")
  end

  def range_for(availability)
    [availability.start_time..availability.end_time]
  end
end
