require 'test_helper'

class InboxTest < ActiveSupport::TestCase
  setup do
    Message.skip_callback(:save, :after, :refresh_inbox_unread_messages_count)
    Message.skip_callback(:destroy, :after, :refresh_inbox_unread_messages_count)
  end

  teardown do
    Message.set_callback(:save, :after, :refresh_inbox_unread_messages_count)
    Message.set_callback(:destroy, :after, :refresh_inbox_unread_messages_count)
  end

  test '.refresh_unread_messages_count!' do
    doctor_inbox = User.default_doctor.inbox

    message = Message.create(
      body: 'Hi',
      outbox: User.current.outbox,
      inbox: doctor_inbox
    )

    assert_not_equal doctor_inbox.unread_messages_count, doctor_inbox.messages.where(read: false).count

    doctor_inbox.refresh_unread_messages_count!

    assert_equal doctor_inbox.unread_messages_count, doctor_inbox.messages.where(read: false).count
  end
end
