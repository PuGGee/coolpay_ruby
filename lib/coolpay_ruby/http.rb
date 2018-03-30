require 'json'
require 'httparty'

module Coolpay
  class Http

    @driver = HTTParty

    def self.get(relative_path, headers: {}, body: '')
      @driver.get(base_uri + relative_path,
        headers: merge_default_headers(headers),
        body: body
      )
    end

    def self.post(relative_path, headers: {}, body: '')
      @driver.post(base_uri + relative_path,
        headers: merge_default_headers(headers),
        body: body
      )
    end

    def self.set_driver(driver)
      @driver = driver
    end

    # private

    def self.base_uri
      if Coolpay.config.production?
        'https://coolpay.herokuapp.com/api'
      else
        'https://private-anon-6f5169e4f5-coolpayapi.apiary-mock.com/api'
      end
    end
    private_class_method :base_uri

    def self.merge_default_headers(headers)
      headers.merge(
        'Content-Type' => 'application/json'
      )
    end
    private_class_method :merge_default_headers
  end
end
