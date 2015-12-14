class PostUserFollow < ActiveRecord::Base
  belongs_to :post, counter_cache: :followers_count
  belongs_to :user
end
