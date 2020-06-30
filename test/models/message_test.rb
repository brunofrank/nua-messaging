require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  test 'post message increments inbox counter' do
    assert_difference 'User.default_doctor.inbox.unread_messages_count' do
      Message.create(
        body: 'Hi',
        outbox: User.current.outbox,
        inbox: User.default_doctor.inbox
      )
    end
  end

  test 'read message descrements inbox counter' do
    message = Message.create(
      body: 'Hi',
      outbox: User.current.outbox,
      inbox: User.default_doctor.inbox
    )

    assert_difference 'User.default_doctor.inbox.unread_messages_count', -1 do
      message.read = true
      message.save
    end
  end

  test 'destroy message decrement inbox counter' do
    message = Message.create(
      body: 'Hi',
      outbox: User.current.outbox,
      inbox: User.default_doctor.inbox
    )

    assert_difference 'User.default_doctor.inbox.unread_messages_count', -1 do
      message.destroy
    end
  end
end
