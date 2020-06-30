class Message < ApplicationRecord

  belongs_to :inbox
  belongs_to :outbox

  after_save :refresh_inbox_unread_messages_count
  after_destroy :refresh_inbox_unread_messages_count

  def posted_last_week?
    created_at >= (Date.current - 1.week)
  end

  private

  def refresh_inbox_unread_messages_count
    inbox.refresh_unread_messages_count!
  end
end
