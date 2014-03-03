require 'spec_helper'

describe OrdersController do
  before(:all) do
    @club = Club.create :name => 'Baza', :description => '21+', :tables_count => 1, :average_time => 1.hour
    @table = @club.table.first
    @order = Order.create :since => Time.now, :until => Time.now+5.minutes
    @table.add_order @order
  end

  describe "orders#index on GET /club/:id/orders" do
    club = Club.create :name => 'Baza', :description => '21+', :tables_count => 1, :average_time => 1.hour
    table = club.table.first
    order = Order.create :since => Time.now, :until => Time.now+5.minutes
    table.add_order order
    it "assigns @orders" do
      get :index, :club_id => club.id
      expect(assigns(:orders)).to eq(club.table.map{|t| t.order}.flatten)
    end

    it "renders the index template" do
      get :index, :club_id => club.id
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
      o = Order.create :since => Time.now+1.hour, :until => Time.now+2.hours
      @table.add_order o
      post :destroy, :id => o.id, :club_id => @table.club.id
      expect(response).to redirect_to(club_tables_url(@club))
      expect(Order.last.id).not_to be(o.id)
    end
  end

  describe "order#update on POST /orders" do
    before(:all){@table.save}
    it "updates order" do
      put :update, {:club_id => @club.id, 
                    :tables_id => @table.id,
                    :id => @order.id,
                    :order => {:since => Time.now+3.hours, :until => Time.now+4.hours}
                  }
      expect(Order.find(@order.id).since).to be >= (Time.now+2.hours)
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
          :table_id => @table.id,
          :time => Time.now+1.hour
        }
      expect(Order.last.table).to be(@table)
    end
    it "sets appropriate since and until" do
      post :create, {
          :club_id => @club.id, 
          :table_id => @table.id,
          :time => Time.now+1.hour
        }
      expect(Order.last.since).to be_within(TIMEOUT).of(Time.now + 1.hour - @club.time_before)
      expect(Order.last.until).to be_within(TIMEOUT).of(Time.now + 1.hour + @club.time_after)
    end
    it "can set until to Time.now" do
      post :create, {
          :club_id => @club.id, 
          :table_id => @table.id,
          :time => Time.now
        }
      expect(Order.last.since).to be_within(TIMEOUT).of(Time.now)
      expect(Order.last.until).to be_within(TIMEOUT).of(Time.now + @club.time_after)
    end
  end
end