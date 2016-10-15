module V1
  class SessionsController < Devise::SessionsController
    wrap_parameters :user

    def create
      user = AuthenticateUser.call(uuid: params[:uuid]).user
      if user
        sign_in(user, store: false) if user
        respond_with user, serializer: SessionSerializer
      else
        render json: error.to_json, status: :unauthorized
      end
    end

    private

    def error
      RailsApiFormat::Error.new(status: :unauthorized, error: "Invalid UUID.")
    end
  end
end
