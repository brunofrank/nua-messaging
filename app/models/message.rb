class Message < ApplicationRecord

  belongs_to :inbox
  belongs_to :outbox

  def posted_last_week?
    created_at >= (Date.current - 1.week)
  end
end
