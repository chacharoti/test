class Api::V1::PacketsController < ApplicationController
  skip_before_action :require_doorkeeper_authorization, only: [:index]

  def index
    @packets = Packet.get_new_packets(params[:old_packets])

    render json: @packets, each_serializer: Api::V1::Packets::PacketSerializer, root: 'packets'
  end
end
