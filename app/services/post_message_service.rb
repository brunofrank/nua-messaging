class PostMessageService < ApplicationService
  def initialize(body, from: nil, to: nil)
    @body = body
    @from = from
    @to = to
  end

  def call
    Message.create(
      body: body,
      outbox: from.outbox,
      inbox: message_destination.inbox
    )
  end

  private

  attr_reader :body, :from, :to, :original_message

  def message_destination
    can_reach_doctor? ? to : User.default_admin
  end

  def can_reach_doctor?
    original_message && original_message.posted_last_week?
  end

  def original_message
    from.inbox.messages.last
  end
end
