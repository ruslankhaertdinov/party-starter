class ApplicationController < ActionController::API
  include ActionController::ImplicitRender

  decent_configuration do
    strategy DecentExposure::StrongParametersStrategy
  end

  respond_to :json

  private

  def ensure_user_found
    render json: { error: "Unauthorized" }, status: :unauthorized unless found_user
  end

  def found_user
    @found_user = User.find_by(authentication_token: params[:uid])
  end
end
