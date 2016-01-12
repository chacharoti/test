class ConversationUser < ActiveRecord::Base
  belongs_to :conversation
  belongs_to :user
  validates_inclusion_of :status, in: %w( joining left )

  scope :joining, -> { where(status: 'joining') }
end
