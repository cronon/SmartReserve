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

  describe "order#create on POST /orders" do
    odrer.table.club.table.map{|t| t.will_free}.min
    it "creates new order" do
      post :create, :club_id => Club.last.id, :order => {:since => Time.now+3.hours, :until => Time.now+4.hours}
      expect(Order.last.table.id).to eq(Table.last.id)
      Order.last.destroy
    end
    it "redirects to show template" do
      post :create, :club_id => Club.last.id, :order => {:since => Time.now+3.hours, :until => Time.now+4.hours}
      expect(response).to redirect_to(Order.last)
      Order.last.destroy
    end
  end
end