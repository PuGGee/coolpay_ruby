require 'uri'

module Coolpay
  class Recipient < API::Resource

    @path = '/recipients'

    def self.list(auth_token = nil)
      return Http.get(@path, headers: headers(auth_token))['recipients'].
                  map(&method(:new))
    end

    def self.find(auth_token = nil, recipient_name)
      params = "?name=#{URI.escape(recipient_name)}"
      return new(
        Http.get(@path + params, headers: headers(auth_token))['recipients'].first
      )
    end

    def self.create(auth_token = nil, attributes)
      body = {
        recipient: attributes
      }
      return new(
        Http.post(@path, headers: headers(auth_token), body: body)['recipient']
      )
    end

    def self.create!(auth_token = nil, attributes)
      create(auth_token, attributes).tap do |recipient|
        raise FailedCreateException unless recipient.valid?
      end
    end

    attr :id, :name
  end
end
