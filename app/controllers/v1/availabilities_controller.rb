module V1
  class AvailabilitiesController < ApplicationController
    before_action :authenticate_user!

    def show
      availability = current_user.availability_for_event(event) || NullAvailability.new
      render json: availability, serializer: AvailabilitySerializer
    end

    def create
      availability = UpdateAvailability.new(event, current_user, availability_params[:intervals]).call
      respond_with(availability)
    end

    def destroy
      availability = current_user.availability_for_event(event)
      status = availability.destroy ? :ok : :unprocessable_entity
      render nothing: true, status: status
    end

    private

    def event
      current_user.events.find(availability_params[:event_id])
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
