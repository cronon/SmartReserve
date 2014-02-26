require 'spec_helper'

describe Club do

  before(:each) do
    @attr = {
      :name => "metropole",
      :tables_count => "24",
      :average_time => "300", # 300 sec == 5 min
      #:description => "inka-chaka-zuma"
    }
  end

  it "should create a new instance given a valid attribute" do
    Club.create!(@attr)
  end

  it "should create a new tables" do
    club=Club.create(@attr)
    expect(club.table.length).to eq(24)
  end

  it "should raise error when invalid attribute" do
    @attr = {
      :name => "fff"
    }
    expect {Club.create!(@attr)}.to raise_error(ActiveRecord::RecordInvalid)
  end

end