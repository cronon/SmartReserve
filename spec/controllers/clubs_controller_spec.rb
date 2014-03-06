require 'spec_helper'

describe ClubsController do
  before :each do 
    @club = Club.new :name => 'Baza', :description => '21+', :tables_count => '23', :time_last => '23:00'
  end
  before :all do
    Club.create(
      :name => 'Stopline', 
      :description => 'great drunken party', 
      :tables_count => 1, 
      :time_last => '23:00'
    )
  end

  describe "clubs#index on GET index" do
    it "assigns @clubs" do
      get :index
      expect(assigns(:clubs)).to eq(Club.all)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "clubs#new GET new" do
    it "renders the new template" do
      get :new
      expect(response).to render_template("new")
    end
    it "assigns @club" do
      get :new
      expect(assigns(:club).serializable_hash).to eq(Club.new.serializable_hash)
    end
  end

  describe "clubs#create POST /clubs" do
    it "creates new club" do
      post :create, :club=>{:name => 'Baza', :description => '21+', :tables_count => '23', :time_last => '23:00'}
      expect(Club.last.name).to eq('Baza')
    end

    it "redirects to the show template" do
      post :create, :club=>{:name => 'Baza', :description => '21+', :tables_count => '23', :time_last => '23:00'}
      expect(response).to redirect_to(Club.last)
    end
  end

  describe "clubs#show GET /clubs/:id" do
    it "renders the show template" do
      get :show, :id => Club.first.id
      expect(response).to render_template("show")
    end
    it "assigns @club" do
      get :show, :id => Club.first.id
      expect(assigns(:club)).to eq(Club.first)
    end
  end

  describe "clubs#edit on GET /clubs/:id/edit" do
    it "renders the edit template" do
      get :edit, :id => Club.first.id
      expect(response).to render_template("edit")
    end
    it "assigns @club" do
      get :edit, :id => Club.first.id
      expect(assigns(:club)).to eq(Club.first)
    end
  end

  describe "clubs#destroy on DELETE /clubs/:id/edit" do
    it "destroys club and redirects to the index template" do
      Club.create :name => 'Cosmos69', :description => '21+', :tables_count => '23', :time_last => '23:00'
      post :destroy, :id => Club.last.id
      expect(response).to redirect_to(:clubs)
      expect(Club.last.name).not_to be('Cosmos69')
    end
  end

  describe "clubs#update POST /clubs" do    
    it "updates a club and redirects to the show template" do
      Club.create :name => 'Cosmos69', :description => '21+', :tables_count => '23', :time_last => '23:00'
      post :update, :id=>Club.last,:club=>{:name => 'Baza', :description => '21+', :tables_count => '23', :time_last => '23:00'}
      expect(Club.last.name).to eq('Baza')
      expect(response).to redirect_to(Club.last)
    end
  end
end