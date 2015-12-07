class Api::V1::Packets::PacketSerializer < ActiveModel::Serializer
  attributes :id, :name, :version, :link
end
