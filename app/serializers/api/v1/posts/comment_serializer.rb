class Api::V1::Posts::CommentSerializer < ActiveModel::Serializer
  attributes :id, :message, :created_at, :latitude, :longitude, :user_likes_count

  has_one :user, serializer: Api::V1::Posts::UserSerializer
end
