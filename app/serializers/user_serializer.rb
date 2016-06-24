class UserSerializer < ApplicationSerializer
  attributes :id, :authentication_token, :availability
end
