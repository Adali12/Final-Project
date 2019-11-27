class Conversation < ApplicationRecord
     # The conversation associates the concept of User divided into sender and recipient.
  belongs_to :sender, foreign_key: :sender_id, class_name:'User'
  belongs_to :recipient, foreign_key: :recipient_id, class_name:'User'
  # One conversation is one-to-many that contains lots of messages.
  has_many :messages, dependent: :destroy

  # Set validation to prevent [: sender_id,: recipient_id] from being saved in the same combination.
  validates_uniqueness_of :sender_id, scope: :recipient_id

  # Explained below
  scope :between, -> (sender_id,recipient_id) do
    where("(conversations.sender_id = ? AND conversations.recipient_id =?) OR (conversations.sender_id = ? AND  conversations.recipient_id =?)", sender_id,recipient_id, recipient_id, sender_id)
  end

  # Explained below
  def target_user(current_user)
    if sender_id == current_user.id
      User.find(recipient_id)
    elsif recipient_id == current_user.id
      User.find(sender_id)
    end
  end
  after_commit :create_notifications, on: :create

  private

  def create_notifications
    Notification.create do |notification|
      notification.notify_type = 'message'
      notification.actor = self.conversation
      notification.user = self.message.conversation
      notification.target = self
      notification.second_target = self.message
    end
  end
  
end
