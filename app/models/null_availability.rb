class NullAvailability
  include ActiveModel::Serialization

  def self.model_name
    "Availability"
  end

  def id
  end

  def intervals
    {}.tap do |h|
      Date::DAYNAMES.each do |day_name|
        h[day_name.downcase.to_sym] = []
      end
    end
  end
end
