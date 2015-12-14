class EmotionPostUser < ActiveRecord::Base
  belongs_to :post, counter_cache: :emotions_count
  belongs_to :emotion
  belongs_to :user
end
