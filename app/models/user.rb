class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :profile_photo, as: :owner
  has_many :devices, -> { distinct }
  has_many :media, -> { distinct }, as: :owner, dependent: :destroy
  has_many :photos, -> { distinct }, as: :owner, dependent: :destroy
  has_many :top_photos, -> { order("id DESC").limit(5) }, class_name: "Photo", as: :owner
  has_many :posts, dependent: :destroy
  has_many :locations, class_name: 'UserLocation', dependent: :destroy
  belongs_to :current_location, class_name: 'UserLocation'
  has_many :activities, foreign_key: 'to_user_id', dependent: :destroy

  before_create :downcase_email

  def downcase_email
    self.email.downcase
  end

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

  def update_profile_photo profile_photo_params
    if old_profile_photo = self.profile_photo
      old_profile_photo.destroy
    end
    self.create_profile_photo(profile_photo_params)
  end

  def add_new_post params
    self.posts.create(params.merge(location_id: self.current_location_id))
  end

  def update_location params
    location = self.locations.create(params)
    self.current_location = location
    self.save
    location
  end

  def latitude
    self.current_location.try(:latitude)
  end

  def longitude
    self.current_location.try(:longitude)
  end

  def recent_activities page
    self.activities.includes(:from_user).where('deleted != 1').order('id DESC').page(page).per(AppSetting.activities_page_size)
  end
end
