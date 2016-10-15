module TokenAuthentication
  extend ActiveSupport::Concern

  def authenticate_user!
    authenticate_user_from_token!
    super
  end

  def authenticate_user_from_token!
    user = user_token && User.find_by_authentication_token(user_token)
    sign_in(user, store: false) if user
  end

  private

  def user_token
    request.headers["X-AUTH-TOKEN"].presence
  end
end
