require 'spec_helper'

class Time
  def to_hash
    result = {}
    [:year,:month,:day,:hour].each{|x| result[x]=self.send(x)}
    result[:minute]=self.min
    result[:second]=self.sec
    result
  end
end

describe OrdersController do
  before(:all) do
    @nine_oclock = Time.parse('9:00').tomorrow
    @club = create(:club)
    @table = @club.table.first
  end
  before(:each) do
    @order = create(:order)
    @order.table_id = @table.id
    @order.save
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
      o = create(:order)
      o.table = @table
      o.save
      post :destroy, :id => o.id, :club_id => @table.club.id
      expect(response).to redirect_to(club_tables_url(@club))
      expect(Order.last.id).not_to be(o.id)
    end
  end

  describe "order#update on PUT /orders" do
    it "updates order" do    
      put :update, {:club_id => @club.id, 
                    :table_id => @table.id,
                    :id => @order.id,
                    :order => attributes_for(:updated_order)
                  }
      expect(Order.find(@order.id).phone).to eq(attributes_for(:updated_order)[:phone])
    end
    it "redirects to show template" do
      put :update, {:club_id => @club.id, 
                    :table_id => @table.id,
                    :id => @order.id,
                    :order => attributes_for(:order)
                  }
      expect(response).to redirect_to(club_order_url(@club, @order))
    end
  end

  describe "orders#create on POST /tables/:table_id/orders" do
    before(:each){Order.last.destroy;Order.last.destroy;Order.last.destroy}
    it "should create new order" do
      params = attributes_for(:order)
      params[:table_id] = @table.id
      post :create, {
          :club_id => @club.id, 
          :order => params,
          :time => (@nine_oclock+1.hour).to_hash
        }
      expect(Order.last.table).to eq(@table)
    end
    it "sets appropriate since and until" do
      params = attributes_for(:order)
      params[:table_id] = @table.id
      post :create, {
          :club_id => @club.id, 
          :order => params,
          :time => (@nine_oclock+1.hour).to_hash
        }
      expect(Order.last.since).to be_within(TIMEOUT).of(@nine_oclock + 1.hour - @club.time_before)
      expect(Order.last.until).to be_within(TIMEOUT).of(@nine_oclock + 1.hour + @club.time_after)
    end
    it "can set since to Time.now" do
      params = attributes_for(:order)
      params[:table_id] = @table.id
      post :create, {
          :club_id => @club.id, 
          :order => params,
          :time => (@nine_oclock + 10.minutes).to_hash
        }
      expect(Order.last.since).to be_within(TIMEOUT).of(@nine_oclock)
      expect(Order.last.until).to be_within(TIMEOUT).of(@nine_oclock + 10.minutes + @club.time_after)
    end
  end
end