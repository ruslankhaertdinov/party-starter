module V1
  class OwnerEventsController < ApplicationController
    before_action :ensure_user_found

    def index
      respond_with(found_user.own_events)
    end
  end
end
