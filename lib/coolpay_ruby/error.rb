module Coolpay

  class CoolpayException < StandardError; end

  class AuthorizationMissingException < CoolpayException; end

  class FailedCreateException < CoolpayException; end
end
