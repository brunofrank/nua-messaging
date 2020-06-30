require 'test_helper'

class PrescriptionRequestServiceTest < ActiveSupport::TestCase
  test '.call' do
    PrescriptionRequestService.call(User.current)

    assert_match(/copy of a prescription/, User.current.outbox.messages.last.body)
  end
end
