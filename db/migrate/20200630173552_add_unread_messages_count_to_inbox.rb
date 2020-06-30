class AddUnreadMessagesCountToInbox < ActiveRecord::Migration[5.0]
  def change
    add_column :inboxes, :unread_messages_count, :integer, default: 0, null: false

    reversible do |direction|
      direction.up { Inbox.all.each(&:refresh_unread_messages_count!) }
    end
  end
end
