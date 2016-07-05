class NullAvailability
  def intervals
    {}.tap do |h|
      Date::DAYNAMES.each do |day_name|
        h[day_name.downcase.to_sym] = []
      end
    end
  end
end