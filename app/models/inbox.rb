class Inbox < ApplicationRecord

  belongs_to :user
  has_many :messages

  def refresh_unread_messages_count!
    update(unread_messages_count: messages.where(read: false).count)
  end
end
