require "spec_helper"
require "coolpay_ruby"
require "http_mock"

describe Coolpay::Payment do
  describe "#list" do
    before(:all) do
      Coolpay::Http.set_driver(HttpMock.new({
        'payments' => [
          {
            'id' => 1,
            'amount' => 10,
            'currency' => 'GBP',
            'recipient_id' => 'fake_id',
            'status' => 'paid'
          },
          {
            'id' => 2,
            'amount' => 10,
            'currency' => 'GBP',
            'recipient_id' => 'fake_id',
            'status' => 'paid'
          },
        ]
      }))
    end

    let(:result) { Coolpay::Payment.list('') }

    it "returns an array of payments" do
      expect(result.first.class).to eq(Coolpay::Payment)
    end

    it "returns the correct number of elements" do
      expect(result.size).to eq(2)
    end

    it "returns elements with the correct IDs" do
      expect(result.map(&:id)).to eq([1, 2])
    end
  end

  describe "#create" do
    it "sends the attributes to the api" do
      test_attributes = {
        'id' => 1,
        'amount' => 10,
        'currency' => 'GBP',
        'recipient_id' => 'fake_id',
        'status' => 'paid'
      }

      http = double('http')
      Coolpay::Http.set_driver(http)
      expect(http).to receive(:post).
        with(
          anything(),
          headers: anything(),
          body: {
            payment: test_attributes
          }
        ).
        and_return({'payment' => {}})

      Coolpay::Payment.create('', test_attributes)
    end

    describe "attributes are valid" do
      before(:all) do
        Coolpay::Http.set_driver(HttpMock.new({
          'payment' => {
            'id' => 2,
            'amount' => 20,
            'currency' => 'GBP',
            'recipient_id' => 'fake_id',
            'status' => 'paid'
          }
        }))
      end

      let(:result) { Coolpay::Payment.create('', {}) }

      it "returns a valid payment" do
        expect(result.class).to eq(Coolpay::Payment)
      end

      it "marks the payment valid" do
        expect(result).to be_valid
      end
    end

    describe "attributes are invalid" do
      before(:all) do
        Coolpay::Http.set_driver(HttpMock.new({
          'payment' => {
            'errors' => 'some error'
          }
        }))
      end

      let(:result) { Coolpay::Payment.create('', {}) }

      it "returns a payment" do
        expect(result.class).to eq(Coolpay::Payment)
      end

      it "marks payment invalid if there are errors" do
        expect(result).not_to be_valid
      end
    end
  end
end
