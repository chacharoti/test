class ConversationUser < ActiveRecord::Base
  belongs_to :conversation
  belongs_to :user
  validates_inclusion_of :status, in: %w( joined left )

  scope :joining, -> { where(status: 'joined') }
end
