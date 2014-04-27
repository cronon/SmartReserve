require 'spec_helper'

describe Club do

  before(:all) do
    @attr = {
      :name => "metropole",
      :tables_count => "5",
      :time_after => 1.hour, # 300 sec == 5 min
      :time_before => 15.minutes,
      :time_last => '23:00',
      :time_waiting => 20.minutes,
      :mon_opens => '08:00', :mon_closes => '23:50',
      :tue_opens => '08:00', :tue_closes => '23:50',
      :wed_opens => '08:00', :wed_closes => '23:50',
      :thu_opens => '08:00', :thu_closes => '23:50',
      :fri_opens => '08:00', :fri_closes => '23:50',
      :sat_opens => '08:00', :sat_closes => '23:50',
      :sun_opens => '08:00', :sun_closes => '23:50',
      :description => "inka-chaka-zuma"
    }
  end

  it "should create a new instance given a valid attribute" do
    Club.create!(@attr)
  end

  it "should create a new tables" do
    club=Club.create(@attr)
    expect(club.table.length).to eq(5)
  end

  it "should raise error when invalid attribute" do
    @attr = {
      :name => "fff"
    }
    expect {Club.create!(@attr)}.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "should be free when all tables free" do
    club = Club.create(@attr)
    club.table.map.with_index do |t,i| 
      allow(t).to receive(:will_free) {Time.now}
    end
    expect(club.will_free(Time.now)).to be_within(TIMEOUT).of(Time.now)
  end

  it "should be free when first table will free" do
    club = Club.create(@attr)
    club.table.map.with_index do |t,i| 
      allow(t).to receive(:will_free) {Time.now + (i+10).minutes}
    end
    expect(club.will_free(Time.now)).to be_within(TIMEOUT).of(Time.now+10.minute)
  end

  describe "whether_order?" do
    before(:all){@c = Club.new(@attr)}
    it "possible when club works" do
      expect(@c.whether_order?(Time.parse('14:00'))).to eq(true)
    end

    it "impossible when club doesnt work" do
      expect(@c.whether_order?(Time.parse('7:00'))).to eq(false)
    end

    it "impossible when club doesnt take orders" do
      expect(@c.whether_order?(Time.parse('23:10'))).to eq(false)
    end
  end

end