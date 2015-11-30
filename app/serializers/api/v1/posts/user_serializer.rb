class Api::V1::Posts::UserSerializer < ActiveModel::Serializer
  attributes :id, :nickname

  has_one :profile_photo, serializer: Api::V1::Posts::MediaSerializer
end
