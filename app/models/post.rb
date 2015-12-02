class Post < ActiveRecord::Base
  belongs_to :user
  has_many :photos, -> { distinct }, as: :owner
  has_one :video, as: :owner
  has_many :comments, class_name: 'CommentPostUser'
  has_many :emotions, class_name: 'EmotionPostUser'
end
