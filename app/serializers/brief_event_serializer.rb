class BriefEventSerializer < ApplicationSerializer
  attributes :id, :name, :description, :is_weekly

  belongs_to :owner, serializer: UserSerializer

  def is_weekly
    true # stub
  end
end
