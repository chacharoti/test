class EmotionPostUser < ActiveRecord::Base
  belongs_to :emotion
  belongs_to :user
  belongs_to :post
end
