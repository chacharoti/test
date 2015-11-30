class Api::V1::Posts::MediaSerializer < ActiveModel::Serializer
  attributes :id, :file_key
end
