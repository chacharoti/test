class AskForFollowingActivity < Activity
  belongs_to :follower_user, foreign_key: 'connection_id'

  def start_following
    self.follower_user = self.to_user.follower_users.create(follower_id: self.from_user_id)
    self.save
  end
end
