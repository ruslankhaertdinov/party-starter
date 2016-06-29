module V1
  class EventsController < ApplicationController
    before_action :ensure_user_found

    def index
      render json: events, each_serializer: BriefEventSerializer
    end

    def show
      event = events.find(params[:id])
      render json: event
    end

    def create
      event = Event.new(event_params)
      event.owner = found_user

      if event.save
        event.users << found_user
        render json: event, serializer: BriefEventSerializer
      else
        render json: { error: event.errors.to_a }, status: :unprocessable_entity
      end
    end

    private

    def event_params
      params.require(:event).permit(:name, :description)
    end

    def events
      found_user.events
    end
  end
end
