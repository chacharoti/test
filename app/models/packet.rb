class Packet < ActiveRecord::Base
  def self.get_new_packets old_packets
    all_packets = Packet.where(is_public: 1)
    if old_packets.present?
      old_packet_names = old_packets.map do |packet_data|
        packet_data[:name]
      end
      # Get new packets
      packets = all_packets.where("name NOT IN (?)", old_packet_names).to_a

      # Update old packets
      old_packets.each do |packet_data|
        if packet = all_packets.where("name = ? AND version > ?", packet_data[:name], packet_data[:version]).first
          packets << packet
        end
      end

      packets
    else
      all_packets.to_a
    end
  end
end
