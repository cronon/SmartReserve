require 'spec_helper'

describe Table do

  before(:each) do
    @table_p = {
      :club_id => 1
    }
    @order_p = {
      :since => Time.now + 5.minutes,
      :until => Time.now + 15.minutes
    }
  end

  it "should create a new instance given a valid attribute" do
    Table.create!(@attr)
  end

end