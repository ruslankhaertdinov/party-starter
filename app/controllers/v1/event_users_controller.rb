module V1
  class EventUsersController < ApplicationController
    before_action :authenticate_user!

    def create
      AssignMembers.new(event, params[:uuids]).call
      respond_with(event)
    end

    def destroy
      event.remove_member(user)
      respond_with(event)
    end

    private

    def event
      own_events.find(event_user_params[:event_id])
    end

    def own_events
      current_user.own_events
    end

    def user
      User.find_by(uuid: event_user_params[:uuid])
    end

    def event_user_params
      params.permit(:event_id, :uuid)
    end
  end
end
