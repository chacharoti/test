class PostUserSeen < ActiveRecord::Base
  belongs_to :post, counter_cache: :seen_users_count
  belongs_to :user
end
