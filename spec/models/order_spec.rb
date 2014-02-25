require 'spec_helper'

describe Order do

  it "should create a new instance given a valid attribute" do
    @attr = {
      :since => Time.now + 1.minutes,
      :until => Time.now + 5.minutes
    }
    Order.create!(@attr)
  end

  it "should validate since and until" do
    @attr = {
      :since => Time.now + 6.minutes,
      :until => Time.now + 5.minutes
    }
    expect {Order.create!(@attr)}.to raise_error
  end

end