class UserSerializer < ApplicationSerializer
  attributes :id, :availability, :uid

  def uid
    object.authentication_token
  end
end
