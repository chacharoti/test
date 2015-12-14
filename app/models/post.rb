class Post < ActiveRecord::Base
  belongs_to :user
  has_many :photos, -> { uniq }, as: :owner
  has_one :video, as: :owner
  has_many :comments, class_name: 'CommentPostUser', dependent: :destroy
  has_many :emotions, class_name: 'EmotionPostUser', dependent: :destroy
  has_many :post_user_follows, -> { uniq }, dependent: :destroy
  has_many :followers, through: :post_user_follows, source: :user

  def add_comment user, params
    self.comments.create(params.merge(user_id: user.id))
  end

  def followed_by user, params
    if self.post_user_follows.where(user_id: user.id).count == 0
      self.post_user_follows.create(params.merge(user_id: user.id))
    end
  end

  def unfollowed_by user
    self.post_user_follows.where(user_id: user.id).destroy_all
  end
end
