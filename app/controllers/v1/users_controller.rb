module V1
  class UsersController < ApplicationController
    before_action :key_valid?, only: %i(create)

    def create
      user = EnsureUserExistence.new(user_params[:uuid]).call
      respond_with user, serializer: SessionSerializer
    end

    private

    def user_params
      params.require(:user).permit(:uuid)
    end

    def key_valid?
      params[:key] == ENV.fetch("APP_KEY")
    end
  end
end
