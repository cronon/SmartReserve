require 'spec_helper'

describe Club do

  before(:each) do
    @attr = {
      :name => "metropole",
      :tables_count => "5",
      :average_time => "300", # 300 sec == 5 min
      #:description => "inka-chaka-zuma"
    }
  end

  it "should create a new instance given a valid attribute" do
    Club.create!(@attr)
  end

  it "should create a new tables" do
    club=Club.create(@attr)
    expect(club.table.length).to eq(5)
  end

  it "should raises error when invalid attribute" do
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

end