module V1
  class UsersController < ApplicationController
    before_action :ensure_user_found, only: %i(update)

    def create
      user = CreateUser.new(params[:uid]).call
      respond_with(user)
    end

    def update
      found_user.update(user_params)
      respond_with(found_user)
    end

    private

    def user_params
      params.require(:user).permit(availability: availability_hash)
    end

    def availability_hash
      {}.tap do |h|
        Date::DAYNAMES.each do |day_name|
          h[day_name.downcase.to_sym] = %i(start_at end_at)
        end
      end
    end
  end
end
