class Api::V1::Users::ProfileSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :nickname, :birthday, :gender, :following_count, :followers_count, :photos_count, :top_posts

  has_one :profile_photo, serializer: Api::V1::MediaSerializer
  has_one :cover_photo, serializer: Api::V1::MediaSerializer
  has_many :top_photos, serializer: Api::V1::MediaSerializer

  def top_posts
    current_user = serialization_options[:current_user]
    object.top_posts.map { |post|
      Api::V1::Users::PostSerializer.new(post, current_user).serializable_hash
    }
  end
end
