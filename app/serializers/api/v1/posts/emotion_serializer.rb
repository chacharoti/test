class Api::V1::Posts::EmotionSerializer < ActiveModel::Serializer
  attributes :id, :name, :created_at, :latitude, :longitude, :user_likes_count

  has_one :user, serializer: Api::V1::Posts::UserSerializer

  def name
    object.emotion.name
  end
end
