module V1
  class UserEventsController < ApplicationController
    before_action :ensure_user_found

    def index
      respond_with(found_user.events)
    end
  end
end
