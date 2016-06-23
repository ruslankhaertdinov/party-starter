module V1
  class AvailabilitiesController < ApplicationController
    before_action :ensure_user_found, only: :create

    def index
      render json: found_user.availabilities, each_serializer: AvailabilitySerializer
    end

    def create
      availabilities = ReplaceAvailabilities.new(intervals, found_user).call
      render json: availabilities, each_serializer: AvailabilitySerializer
    end

    private

    def availability_params
      params.require(:availability).permit(intervals: [:start_at, :end_at])
    end

    def intervals
      availability_params[:intervals]
    end
  end
end
