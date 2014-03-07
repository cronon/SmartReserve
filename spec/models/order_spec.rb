require 'spec_helper'

describe Order do
  before(:each){@params = attributes_for(:order)}
  it "should create a new instance given a valid attribute" do
    @params[:since] = Time.now
    @params[:until] = Time.now + 15.minutes
    Order.create!(@params)
  end

  it "should validate since and until" do
    @params[:since] = Time.now + 6.minutes
    @params[:until] = Time.now + 5.minutes
    expect {Order.create!(@params)}.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "sholud not create order in the past" do
    @params[:since] = Time.now - 10.minutes
    @params[:until] = Time.now + 10.minutes
    expect {Order.create!(@params)}.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "should not raise exception if time is within timeout" do
    @params[:since] = Time.now + 1.minute
    @params[:until] = Time.now + 2.minutes
    Order.create!(@params)
  end

  it "validates phone" do
    @params[:since] = Time.now
    @params[:until] = Time.now + 15.minutes
    @params[:phone] = '321321A'
    expect {Order.create!(@params)}.to raise_error(ActiveRecord::RecordInvalid)
  end

  describe "confiramtion code" do
    before(:each) do
      @o = Order.prepare :phone => '+37533123456', :name => 'vasya'
      allow(Order).to receive(:generate_token).and_return(1)
    end
    it "sets token for new order" do          
      expect(@o.token).to be
    end
  end
end