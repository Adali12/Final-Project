class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user
  validates_presence_of :body, :conversation_id, :user_id
  
  def message_time
    created_at.strftime("%m/%d/%y at %l:%M %p")
  end
def message_conv
user_id = current_user.id
@conv=Message.where('read=false and user_id').count 
reurn @conv
end
end 
