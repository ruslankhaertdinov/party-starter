module V1
  class EventUsersController < ApplicationController
    before_action :ensure_user_found

    def create
      event.add_member(user)
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
      found_user.own_events
    end

    def user
      User.find(event_user_params[:user_id])
    end

    def event_user_params
      params.permit(:event_id, :user_id)
    end
  end
end
