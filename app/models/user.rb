class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :profile_photo, as: :owner
  has_one :cover_photo, as: :owner
  has_many :devices, -> { distinct }
  has_many :media, -> { distinct }, as: :owner, dependent: :destroy
  has_many :photos, -> { distinct }, as: :owner, dependent: :destroy
  has_many :top_photos, -> { order("id DESC").limit(5) }, class_name: "Photo", as: :owner
  has_many :posts, dependent: :destroy
  has_many :top_posts, -> { order("id DESC").limit(5) }, class_name: "Post"
  has_many :locations, class_name: 'UserLocation', dependent: :destroy
  belongs_to :current_location, class_name: 'UserLocation'
  has_many :activities, foreign_key: 'to_user_id', dependent: :destroy
  has_many :conversation_users, dependent: :destroy
  has_many :conversations, through: :conversation_users
  has_many :joining_conversation_users, -> { joining }, class_name: 'ConversationUser'
  has_many :joining_conversations, through: :joining_conversation_users, source: :conversation

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

  def recent_conversations
    self.joining_conversations.includes(:joining_users, :top_message).order('conversations.updated_at DESC, conversations.id DESC').limit(AppSetting.inbox_page_size)
  end

  def more_conversations last_conversation_updated_at
    self.recent_conversations.where('conversations.updated_at < ?', last_conversation_updated_at)
  end

  def new_conversations first_conversation_updated_at
    self.recent_conversations.where('conversations.updated_at > ?', first_conversation_updated_at)
  end

  def self.load_profile(user_id)
    User.includes(:profile_photo, :cover_photo, :top_photos, top_posts: [{user: [:profile_photo]}, :location, :photos, :video, {top_comment: [:user]}, {top_emotion: [:user]}, :top_follower]).find_by(id: user_id)
  end

  def following_count
    0
  end

  def followers_count
    0
  end

  def photos_count
    self.photos.count
  end

  def block_user_with_id blocked_user_id
    # TODO: block user
    return true
  end
end
