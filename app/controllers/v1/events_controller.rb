module V1
  class EventsController < ApplicationController
    def create
      event = Event.new(event_params)
      event.owner = found_user
      event.save!
      respond_with(event)
    end

    private

    def event_params
      params.require(:event).permit(:name, :description)
    end

    def found_user
      @found_user = User.find_by(authentication_token: params[:token])
    end
  end
end
