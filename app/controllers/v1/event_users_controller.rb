module V1
  class EventUsersController < ApplicationController
    before_action :authenticate_user!

    def create
      # TODO: handle user_ids, because there are not uuids in this particular case
      AssignMembers.new(event, params[:user_ids]).call
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
      User.find_by(id: event_user_params[:user_id])
    end

    def event_user_params
      params.permit(:event_id, :user_id)
    end
  end
end
