module V1
  class UsersController < ApplicationController
    def create
      user = CreateUser.new(token).call
      respond_with(user)
    end

    private

    def token
      params.permit(:id)[:id]
    end
  end
end
