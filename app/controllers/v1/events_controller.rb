module V1
  class EventsController < ApplicationController
    before_action :ensure_user_found, only: :create

    def create
      event = Event.new(event_params)
      event.owner = found_user

      if event.save
        respond_with(event)
      else
        render json: { error: event.errors.to_a }, status: :unprocessable_entity
      end
    end

    private

    def event_params
      params.require(:event).permit(:name, :description)
    end

    def found_user
      @found_user = User.find_by(authentication_token: params[:token])
    end

    def ensure_user_found
      render json: { error: "Unauthorized" }, status: :unauthorized unless found_user
    end
  end
end
