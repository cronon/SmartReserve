require 'spec_helper'

describe Table do

  before(:all) do
    @club_attr = {
      :name => "metropole",
      :tables_count => "5",
      :time_after => 1.hour, # 300 sec == 5 min
      :time_before => 15.minutes,
      :time_last => Time.parse('23:00'),
      :time_waiting => 20.minutes,
      :mon_opens => '8:00', :mon_closes => '23:50',
      :tue_opens => '8:00', :tue_closes => '23:50',
      :wed_opens => '8:00', :wed_closes => '23:50',
      :thu_opens => '8:00', :thu_closes => '23:50',
      :fri_opens => '8:00', :fri_closes => '23:50',
      :sat_opens => '8:00', :sat_closes => '23:50',
      :sun_opens => '8:00', :sun_closes => '23:50',
      :description => "inka-chaka-zuma"
    }
    @club = Club.new @club_attr
  end
  before(:each) do 
    @table = Table.new
    @table.club = @club
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
      @table.add_order(o)
      expect {@table.save!}.to raise_error(ActiveRecord::RecordInvalid)
    end 
  end

  describe "status method" do
    it "free when has no orders today" do
      tomorrow_order = Order.new ({
        :since => Time.now + 5.days,
        :until => Time.now + 15.minutes + 5.days
      })

      @table.add_order tomorrow_order
      expect(@table.status(Time.now)).to be(:free)
    end

    it "booked when has order now" do
      current_order = Order.new ({
        :since => Time.now,
        :until => Time.now + 15.minutes
      })

      @table.add_order current_order
      expect(@table.status(Time.now)).to be(:booked)
    end

    it "booked in future when has order in future" do
      future_order = Order.new ({
        :since => Time.now + 5.minutes,
        :until => Time.now + 15.minutes
      })

      @table.add_order future_order
      expect(@table.status(Time.now+10.minutes)).to be(:booked)
    end

    it "busy now+time_after when status_now is busy" do
      @table.status_now = :busy
      @table.save
      expect(@table.status(Time.now + 30.minutes)).to eq(:busy)
    end

    it "isnt busy after a lot of time when status_now is busy" do
      @table.status_now = :busy
      @table.save
      expect(@table.status(Time.now + 3.hours)).to eq(:free)
    end

    it "isnt busy when no one come to mah party in time_waiting" do
      past_order = Order.new ({
        :since => Time.now - 30.minutes,
        :until => Time.now + 15.minutes
      })
      expect(@table.status(Time.now)).to eq(:free)
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