class Post < ActiveRecord::Base
  belongs_to :user
  has_many :photos, -> { distinct }, as: :owner
  has_one :video, as: :owner
  has_many :comments, class_name: 'CommentPostUser'
  has_many :emotions, class_name: 'EmotionPostUser'
  has_many :post_user_follows
  has_many :followers, through: :post_user_follows, source: :user
end
