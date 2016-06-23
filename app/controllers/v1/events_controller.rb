module V1
  class EventsController < ApplicationController
    before_action :ensure_user_found

    def index
      respond_with(own_events)
    end

    def show
      event = own_events.find(params[:id])
      render json: event, serializer: DetailedEventSerializer
    end

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

    def own_events
      found_user.own_events
    end
  end
end
