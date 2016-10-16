module V1
  class EventsController < ApplicationController
    before_action :authenticate_user!

    def index
      render json: events
    end

    def show
      event = events.find(params[:id])
      render json: event
    end

    def create
      event = Event.new(event_params)
      event.owner = current_user

      if event.save
        assign_members(event)
        render json: event
      else
        render json: { error: event.errors.to_a }, status: :unprocessable_entity
      end
    end

    def update
      event = own_events.find(params[:id])

      if event.update(event_params)
        render json: event
      else
        render json: { error: event.errors.to_a }, status: :unprocessable_entity
      end
    end

    def destroy
      event = own_events.find(params[:id])
      status = event.destroy ? :ok : :unprocessable_entity
      render json: event, status: status
    end

    private

    def event_params
      params.require(:event).permit(:name, :description)
    end

    def events
      current_user.events
    end

    def own_events
      current_user.own_events
    end

    def assign_members(event)
      uuids = params[:event][:uuids] || []
      uuids << current_user.uuid
      AssignMembers.new(event, uuids).call
    end
  end
end
