class Activity < ActiveRecord::Base
  belongs_to :from_user, class_name: 'User'
  belongs_to :to_user, class_name: 'User'
  validates_inclusion_of :status, in: %w( waiting deleted accepted )

  scope :waiting, -> { where(status: 'waiting') }

  def accept
    self.update_attribute(:status, 'accepted')
    if self.type == AskForPrivateChatActivity.to_s
      self.start_new_conversation
    end
  end
end
