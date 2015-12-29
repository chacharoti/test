class Api::V1::MediaSerializer < ActiveModel::Serializer
  attributes :id, :file_key, :meta_data
end
