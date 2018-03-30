require "spec_helper"

describe Coolpay do
  it "has a version number" do
    expect(Coolpay::VERSION).not_to be nil
  end

  it "lets you configure it" do
    Coolpay.configure do |config|
      config.username = 'test_name'
      config.apikey = 'test_key'
      config.env = :test
    end

    expect(Coolpay.config.username).to eq('test_name')
    expect(Coolpay.config.apikey).to eq('test_key')
    expect(Coolpay.config.env).to eq(:test)
  end
end
