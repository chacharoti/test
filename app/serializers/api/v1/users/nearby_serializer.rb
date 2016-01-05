class Api::V1::Users::NearbySerializer < ActiveModel::Serializer
  attributes :id, :nickname, :first_name, :last_name, :gender, :birthday, :latitude, :longitude

  has_one :profile_photo, serializer: Api::V1::MediaSerializer
  has_many :top_photos, serializer: Api::V1::MediaSerializer
end
