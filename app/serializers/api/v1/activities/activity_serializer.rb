class Api::V1::Activities::ActivitySerializer < ActiveModel::Serializer
  attributes :id, :type, :message, :seen, :read, :created_at

  has_one :from_user, serializer: Api::V1::UserSerializer
end
