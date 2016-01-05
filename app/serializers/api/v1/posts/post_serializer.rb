class Api::V1::Posts::PostSerializer < ActiveModel::Serializer
  attributes :id, :latitude, :longitude, :message, :interactions_count, :emotions_count, :comments_count, :followers_count, :seen_users_count, :created_at, :added_emotion_already, :followed_already

  has_one :user, serializer: Api::V1::Posts::UserSerializer
  has_many :photos, serializer: Api::V1::MediaSerializer
  has_one :video, serializer: Api::V1::MediaSerializer
  has_many :top_seen_users, serializer: Api::V1::Posts::UserSerializer
  has_one :top_comment, serializer: Api::V1::Posts::CommentSerializer
  has_one :top_emotion, serializer: Api::V1::Posts::EmotionSerializer
  has_one :top_follower, serializer: Api::V1::Posts::UserSerializer

  def interactions_count
    object.emotions_count + object.comments_count + object.followers_count
  end

  def added_emotion_already
    current_user = serialization_options[:current_user]
    object.added_emotion_already_by(current_user)
  end

  def followed_already
    current_user = serialization_options[:current_user]
    object.followed_already_by(current_user)
  end
end