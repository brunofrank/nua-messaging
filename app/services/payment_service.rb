class PaymentService < ApplicationService
  def initialize(user)
    @user = user
  end

  def call
    PaymentProviderFactory.provider.debit_card(user)

    record_successful_transaction
  rescue
    false
  end

  private

  attr_reader :user

  def record_successful_transaction
    Payment.create(user: user)
  end
end
