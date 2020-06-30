class PaymentProviderFactory
  class Provider
    def debit_card(user)
      true
    end
  end

  def self.provider
    @provider ||= Provider.new
  end
end
