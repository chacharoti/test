class Api::V1::Messages::MessageSerializer < ActiveModel::Serializer
  attributes :id, :created_at

  has_one :user, serializer: Api::V1::UserSerializer
  has_one :text, serializer: Api::V1::TextSerializer
  has_one :photo, serializer: Api::V1::MediaSerializer
  has_one :video, serializer: Api::V1::MediaSerializer
end
