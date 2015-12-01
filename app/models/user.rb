class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :profile_photo, as: :owner
  has_many :devices, -> { distinct }
  has_many :media, -> { distinct }, as: :owner
  has_many :photos, -> { distinct }, as: :owner

  def unique_identifier
    Digest::SHA1.hexdigest(self.id.to_s + ENV['HASH_SALT'])
  end

  def add_device device
    self.devices << device
  end

  def add_media media_params
    media = []
    media_params.each do |medium_params|
      media << self.media.create(medium_params)
    end
    media
  end

  def update_profile_photo file_key
    self.create_profile_photo(file_key: file_key)
  end
end
