class EventUserSerializer < ApplicationSerializer
  attributes :uid

  def uid
    object.authentication_token
  end
end
