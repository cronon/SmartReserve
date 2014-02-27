require 'spec_helper'

describe Table do

  before(:each) do
    @table = Table.new
    @table.club = Club.new(:name => "Club",:average_time => 20.minutes,:tables_count => 10)
  end

  describe "validators tests" do
    it "should create a new instance given a valid attribute" do
      Table.create!(@attr)
    end

    it "should adds valid orders" do
      future_order = Order.new ({
        :since => Time.now + 5.minutes,
        :until => Time.now + 15.minutes
      })

      @table.add_order future_order
      expect(@table.order.length).to eq(1)
    end

    it "should raise exception when orders intersects" do
      @table.add_order Order.new({:since=>Time.now, :until => Time.now+10.minutes})
      o = Order.new({:since=>Time.now+5.minutes, :until => Time.now+20.minutes})
      expect {@table.add_order(o)}.to raise_error(ActiveRecord::RecordInvalid)
    end 
  end

  describe "status method" do
    it "should be free when has no orders today" do
      tomorrow_order = Order.new ({
        :since => Time.now + 5.days,
        :until => Time.now + 15.minutes + 5.days
      })

      @table.add_order tomorrow_order
      expect(@table.status(Time.now)).to be(:free)
    end

    it "should be busy when has order now" do
      current_order = Order.new ({
        :since => Time.now,
        :until => Time.now + 15.minutes
      })

      @table.add_order current_order
      expect(@table.status(Time.now)).to be(:busy)
    end

    it "should be booked when has order in todays future" do
      future_order = Order.new ({
        :since => Time.now + 5.minutes,
        :until => Time.now + 15.minutes
      })

      @table.add_order future_order
      expect(@table.status(Time.now)).to be(:booked)
    end
  end

  describe "will_free method" do
    it "should be free when a lot of time between orders" do      
      @table.add_order Order.new({:since=>Time.now, :until => Time.now+10.minutes})
      @table.add_order Order.new({:since=>Time.now+10.days, :until => Time.now+10.days+10.minutes})
      expect(@table.will_free(Time.now)).to be_within(TIMEOUT).of(10.minutes)
    end

    it "shouldnt be free when little of time between orders" do
      @table.add_order Order.new({:since=>Time.now, :until => Time.now+10.minutes})
      @table.add_order Order.new({:since=>Time.now+15.minutes, :until => Time.now+50.minutes})
      expect(@table.will_free(Time.now)).to be_within(TIMEOUT).of(50.minutes)
    end

    it "should be free right now when has no orders" do
      expect(@table.will_free(Time.now)).to be_within(TIMEOUT).of(0)
    end
  end

end