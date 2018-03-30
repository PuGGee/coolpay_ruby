require "coolpay_ruby/http"

module Coolpay
  class Payment < API::Resource

    @path = '/payments'

    def self.list(auth_token = nil)
      return Http.get(@path, headers: headers(auth_token))['payments'].
                  map(&method(:new))
    end

    def self.create(auth_token = nil, attributes)
      body = {
        payment: attributes
      }
      return new(
        Http.post(@path, headers: headers(auth_token), body: body)['payment']
      )
    end

    def self.create!(auth_token = nil, attributes)
      create(auth_token, attributes).tap do |payment|
        raise FailedCreateException unless payment.valid?
      end
    end

    attr :id, :amount, :currency, :recipient_id, :status
  end
end
