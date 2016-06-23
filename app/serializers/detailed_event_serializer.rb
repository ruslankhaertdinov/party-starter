class DetailedEventSerializer < EventSerializer
  has_many :users, each_serializer: EventUserSerializer
end
