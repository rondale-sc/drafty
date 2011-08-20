class PlayersController < ApplicationController
  before_filter :authenticate, :only => [ :edit, :new, :delete, :update ]
  # GET /players
  # GET /players.xml
  def index
    @quarter_b =  Player.available.quaterbacks.by_ranking.limit(5)
    @running_b =  Player.available.running_backs.by_ranking.limit(5)
    @place_k   =  Player.available.place_kickers.by_ranking.limit(5)
    @tight_e   =  Player.available.tight_ends.by_ranking.limit(5)
    @defense   =  Player.available.defenses.by_ranking.limit(5)
    @wide_r    =  Player.available.wide_receivers.by_ranking.limit(5)

    if params[:selected]
      @players = @players.where(:selected => (params[:selected] == "1"))
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @players }
    end
  end

  # GET /players/1
  # GET /players/1.xml
  def show
    @player = Player.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @player }
    end
  end

  # GET /players/new
  # GET /players/new.xml
  def new
    @player = Player.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @player }
    end
  end

  # GET /players/1/edit
  def edit
    @player = Player.find(params[:id])
  end

  # POST /players
  # POST /players.xml
  def create
    @player = Player.new(params[:player])

    respond_to do |format|
      if @player.save
        format.html { redirect_to(@player, :notice => 'Player was successfully created.') }
        format.xml  { render :xml => @player, :status => :created, :location => @player }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @player.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /players/1
  # PUT /players/1.xml
  def update
    @player = Player.find(params[:id])

    if params[:player] && params[:player][:selected] && params[:player][:pick]
      @player.team = Team.with_pick(params[:player][:pick].to_i)
    end

    respond_to do |format|
      if @player.update_attributes(params[:player])
        format.html { redirect_to(:action => 'assignment') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @player.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /players/1
  # DELETE /players/1.xml
  def destroy
    @player = Player.find(params[:id])
    @player.destroy

    respond_to do |format|
      format.html { redirect_to(players_url) }
      format.xml  { head :ok }
    end
  end

  def round
    @drafts = Draft.finalized.draft_order
  end

  def assignment
    @players = Player.available.for_position(params[:position]).by_ranking
    @teams = Team.order("name")
  end

 def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      if username == "admin" && password == "ransom"
        session[:admin] = true
      end
    end
 end
end
