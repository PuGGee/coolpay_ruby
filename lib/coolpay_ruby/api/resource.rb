module Coolpay
  module API
    class Resource

      def self.headers(auth_token = nil)
        auth_token ||= Session.auth_token || raise(AuthorizationMissingException)
        {
          'Authorization' => "Bearer #{auth_token}"
        }
      end
      private_class_method :headers

      attr :errors

      def initialize(attributes)
        attributes.each do |key, value|
          instance_variable_set("@#{key}", value)
        end
      end

      def valid?
        errors.nil?
      end
    end
  end
end
