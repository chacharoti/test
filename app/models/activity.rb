class Activity < ActiveRecord::Base
  belongs_to :from_user, class_name: 'User'
  belongs_to :to_user, class_name: 'User'
  validates_inclusion_of :status, in: ['', 'deleted', 'accepted']

  def available_for_accept?
    self.status.empty?
  end

  def accept
    if self.available_for_accept?
      self.update_attribute(:status, 'accepted')
      if self.type == AskForPrivateChatActivity.to_s
        self.start_new_conversation
      elsif self.type == AskForFollowingActivity.to_s
        self.start_following
      end
    end
  end
end
