class UserSerializer < ApplicationSerializer
  attributes :uid

  def uid
    object.authentication_token
  end
end
