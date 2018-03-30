require "coolpay_ruby/http"

module Coolpay
  class Session

    @path = '/login'

    class << self
      attr :auth_token
    end

    def self.create
      body = {
        username: Coolpay.config.username,
        apikey: Coolpay.config.apikey
      }
      return Http.post(@path, body: body)['token']
    end

    def self.authorize(auth_token = nil, &block)
      @auth_token = auth_token || create
      block.call
    ensure
      @auth_token = nil
    end
  end
end
