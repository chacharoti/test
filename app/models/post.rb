class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :location, class_name: 'UserLocation'

  has_many :photos, -> { uniq }, as: :owner
  accepts_nested_attributes_for :photos

  has_one :video, as: :owner
  accepts_nested_attributes_for :video

  has_many :comments, class_name: 'CommentPostUser', dependent: :destroy
  has_many :emotions, class_name: 'EmotionPostUser', dependent: :destroy
  has_many :post_user_follows, dependent: :destroy
  has_many :followers, through: :post_user_follows, source: :user

  has_many :post_user_seens, dependent: :destroy
  has_many :seen_users, through: :post_user_seens, source: :user, dependent: :destroy
  has_many :top_seen_users, -> { limit(5) }, through: :post_user_seens, source: :user

  has_one :top_comment, -> { order('user_likes_count DESC, created_at ASC') }, class_name: 'CommentPostUser'
  has_one :top_emotion, -> { order('user_likes_count DESC, created_at ASC') }, class_name: 'EmotionPostUser'
  has_one :top_post_user_follow, -> { order('created_at ASC') }, class_name: 'PostUserFollow'
  has_one :top_follower, through: :top_post_user_follow, source: :user

  def score
    self.id
  end

  def self.latest_items
    Post.includes({user: [:profile_photo]}, :location, :photos, :video, {top_comment: [:user]}, {top_emotion: [:user]}, :top_follower).limit(AppSetting.posts_page_size).order("id DESC")
  end

  def self.new_items highest_score
    self.latest_items.where("id > ?", highest_score)
  end

  def self.more_items lowest_score
    self.latest_items.where("id < ?", lowest_score)
  end

  def add_comment user, params
    self.comments.create(params.merge(user_id: user.id, location_id: user.current_location_id))
  end

  def followed_by user
    if self.post_user_follows.where(user_id: user.id).count == 0
      self.post_user_follows.create(user_id: user.id, location_id: user.current_location_id)
    else
      nil
    end
  end

  def unfollowed_by user
    self.post_user_follows.where(user_id: user.id).destroy_all
  end

  def add_emotion user, emotion_params
    if self.emotions.where(user_id: user.id).count == 0
      self.emotions.create(emotion_params.merge(user_id: user.id, location_id: user.current_location_id))
    else
      return nil
    end
  end

  def remove_emotion user
    self.emotions.where(user_id: user.id).destroy_all
  end

  def added_emotion_already_by user
    self.emotions.exists?(user_id: user.id)
  end

  def followed_already_by user
    self.post_user_follows.exists?(user_id: user.id)
  end

  def all_emotions
    self.emotions.includes([:emotion_type, :location, {user: [:profile_photo]}])
  end

  def all_comments
    self.comments.includes([:location, {user: [:profile_photo]}])
  end

  def latitude
    self.location.try(:latitude)
  end

  def longitude
    self.location.try(:longitude)
  end
end
