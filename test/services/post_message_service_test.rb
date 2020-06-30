require 'test_helper'

class PostMessageServiceTest < ActiveSupport::TestCase

  test '.call with a recent original message' do
    Message.create(
      body: 'Original message',
      outbox: outboxes(:doctor),
      inbox: inboxes(:patient)
    )

    message = PostMessageService.call(
      'Testing message',
      from: User.current,
      to: User.default_doctor
    )

    assert_not message.read
    assert_equal message.inbox, User.default_doctor.inbox
  end

  test '.call with more then a week older original message' do
    Message.create(
      body: 'Original message',
      outbox: outboxes(:doctor),
      inbox: inboxes(:patient),
      created_at: (Date.current - 10.days)
    )

    message = PostMessageService.call(
      'Testing message',
      from: User.current,
      to: User.default_doctor
    )

    assert_not message.read
    assert_equal message.inbox, User.default_admin.inbox
  end
end
