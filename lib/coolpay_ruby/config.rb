module Coolpay

  class << self
    attr :config
  end

  def self.configure(&block)
    @config = Config.new
    block.call(@config)
  end

  class Config

    attr_accessor :username, :apikey, :env

    def production?
      env.to_s == 'production'
    end
  end
end
