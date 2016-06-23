module V1
  class AvailabilitiesController < ApplicationController
    before_action :ensure_user_found

    def index
      respond_with(found_user.availabilities)
    end

    def create
      availabilities = ReplaceAvailabilities.new(intervals, found_user).call
      respond_with(availabilities)
    end

    private

    def intervals
      props = params.require(:availability).permit(intervals: [:start_at, :end_at])
      props[:intervals]
    end
  end
end
