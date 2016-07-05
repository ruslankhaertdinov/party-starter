module V1
  class AvailabilitiesController < ApplicationController
    before_action :ensure_user_found

    def show
      availability = found_user.availability_for_event(event) || NullAvailability.new
      render json: availability, serializer: AvailabilitySerializer
    end

    def create
      availability = UpdateAvailability.new(event, found_user, availability_params[:intervals]).call
      respond_with(availability)
    end

    private

    def event
      found_user.events.find(availability_params[:event_id])
    end

    def availability_params
      params.require(:availability).permit(:event_id, intervals: intervals_hash)
    end

    def intervals_hash
      {}.tap do |h|
        Date::DAYNAMES.each do |day_name|
          h[day_name.downcase.to_sym] = %i(start_at end_at)
        end
      end
    end
  end
end
