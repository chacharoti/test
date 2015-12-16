class Api::V1::Posts::EmotionSerializer < ActiveModel::Serializer
  attributes :id, :emotion_type_id, :created_at, :latitude, :longitude, :user_likes_count

  has_one :user, serializer: Api::V1::Posts::UserSerializer
end
