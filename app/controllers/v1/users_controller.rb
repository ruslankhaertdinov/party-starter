module V1
  class UsersController < ApplicationController
    before_action :key_valid?, only: %i(create)

    def create
      user = EnsureUserExistence.new(params[:uid]).call
      render json: user, status: 200
    end

    private

    def user_params
      params.require(:user).permit(:uid)
    end

    def key_valid?
      params[:key] == ENV.fetch("APP_KEY")
    end
  end
end
