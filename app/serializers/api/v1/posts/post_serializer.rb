class Api::V1::Posts::PostSerializer < ActiveModel::Serializer
  attributes :id, :latitude, :longitude, :message, :interactions_count, :emotions_count, :comments_count, :followers_count, :seen_users_count, :created_at

  has_one :user, serializer: Api::V1::Posts::UserSerializer
  has_many :photos, serializer: Api::V1::Posts::MediaSerializer
  has_one :video, serializer: Api::V1::Posts::MediaSerializer
end