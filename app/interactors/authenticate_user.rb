class AuthenticateUser
  include Interactor

  def call
    context.user = authenticated_user!
  end

  private

  def authenticated_user!
    User.find_by(uuid: context.uuid)
  end
end
