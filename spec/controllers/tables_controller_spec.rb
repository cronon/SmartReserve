require 'spec_helper'

describe TablesController do
  before :all do
    Club.create(
      :name => 'Stopline', 
      :description => 'great drunken party', 
      :tables_count => 1, 
      :average_time => 5.minutes
    )
  end

  describe "tables#index on GET index" do
    it "assigns @tables" do
      get :index, :club_id => Club.last.id
      expect(assigns(:tables)).to eq(Club.last.table)
    end

    it "renders the index template" do
      get :index, :club_id => Club.last.id
      expect(response).to render_template("index")
    end
  end

  describe "tables#show on GET show" do
    it "assigns @table" do
      get :show, :club_id => Club.last.id, :id =>Club.last.table.last.id
      expect(assigns(:table)).to eq(Club.last.table.last)
    end

    it "renders the index template" do
      get :show, :club_id => Club.last.id, :id =>Club.last.table.last.id
      expect(response).to render_template("show")
    end
  end

  describe "tables#edit on GET edit" do
    it "assigns @table" do
      get :edit, :club_id => Club.last.id, :id =>Club.last.table.last.id
      expect(assigns(:table)).to eq(Club.last.table.last)
    end

    it "renders the index template" do
      get :edit, :club_id => Club.last.id, :id =>Club.last.table.last.id
      expect(response).to render_template("edit")
    end
  end

end