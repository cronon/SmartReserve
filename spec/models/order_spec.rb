require 'spec_helper'

describe Order do

  it "should create a new instance given a valid attribute" do
    params = {
      :since => Time.now,
      :until => Time.now + 15.minutes
    }
    Order.create!(params)
  end

  it "should validate since and until" do
    params = {
      :since => Time.now + 6.minutes,
      :until => Time.now + 5.minutes
    }
    expect {Order.create!(params)}.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "sholud not create order in the past" do
    params = {
      :since => Time.now - 10.minutes,
      :until => Time.now + 10.minutes
    }
    expect {Order.create!(params)}.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "should not raise exception if time is within timeout" do
    params = {
      :since => Time.now + 1.minute,
      :until => Time.now + 2.minutes
    }
    Order.create!(params)
  end

end