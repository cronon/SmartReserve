require 'spec_helper'

describe OrdersController do
  before(:all) do
    attr = {
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
    @club = Club.create attr
    @table = @club.table.first
  end
  before(:each) do
    @order = Order.create :since => Time.now+4.hours+55.minutes, :until => Time.now+5.hours, :table_id => @table.id
  end
  after(:each) do
    Order.all.each{|o| o.destroy}
    @order = nil
  end

  describe "orders#index on GET /club/:id/orders" do
    it "assigns @orders" do
      get :index, :club_id => @club.id
      expect(assigns(:orders)).to eq(Order.where(:table_id => @table.id))
    end

    it "renders the index template" do
      get :index, :club_id => @club.id
      expect(response).to render_template("index")
    end
  end

  describe "orders#show on GET /orders/:id" do
    it "assigns @order" do
      get :show, :id => @order.id, :club_id => @order.table.club.id
      expect(assigns(:order)).to eq(@order)
    end

    it "renders the show template" do
      get :show, :id => @order.id, :club_id => @order.table.club.id
      expect(response).to render_template("show")
    end
  end

  describe "orders#destroy on DELETE /orders/:id" do
    it "destroys order and redirects to the tables index template" do
      o = Order.create :since => Time.now+1.hour, :until => Time.now+2.hours, :table_id => @table.id
      post :destroy, :id => o.id, :club_id => @table.club.id
      expect(response).to redirect_to(club_tables_url(@club))
      expect(Order.last.id).not_to be(o.id)
    end
  end

  describe "order#update on POST /orders" do
    it "updates order" do    
      put :update, {:club_id => @club.id, 
                    :tables_id => @table.id,
                    :id => @order.id,
                    :order => {:since => Time.now+3.hours, :until => Time.now+4.hours}
                  }
      expect(Order.find(@order.id).since).to be_within(TIMEOUT).of(Time.now+3.hours)
    end
    it "redirects to show template" do
      put :update, {:club_id => @club.id, 
                    :tables_id => @table.id,
                    :id => @order.id,
                    :order => {:since => Time.now+3.hours, :until => Time.now+4.hours}
                  }
      expect(response).to redirect_to(club_order_url(@club, @order))
    end
  end

  describe "orders#create on POST /tables/:table_id/orders" do
    it "should create new order" do
      post :create, {
          :club_id => @club.id, 
          :id => @table.id,
          :time => Time.now+1.hour
        }
      expect(Order.last.table).to eq(@table)
      Order.last.destroy
    end
    it "sets appropriate since and until" do
      post :create, {
          :club_id => @club.id, 
          :id => @table.id,
          :time => Time.now+1.hour
        }
      expect(Order.last.since).to be_within(TIMEOUT).of(Time.now + 1.hour - @club.time_before)
      expect(Order.last.until).to be_within(TIMEOUT).of(Time.now + 1.hour + @club.time_after)
      Order.last.destroy
    end
    it "can set since to Time.now" do
      post :create, {
          :club_id => @club.id, 
          :id => @table.id,
          :time => Time.now + 10.minutes
        }
      expect(Order.last.since).to be_within(TIMEOUT).of(Time.now)
      expect(Order.last.until).to be_within(TIMEOUT).of(Time.now + 10.minutes + @club.time_after)
      Order.last.destroy
    end
  end
end