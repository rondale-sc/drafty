class PlayersController < ApplicationController
  before_filter :authenticate, :only => [ :edit, :create, :delete ]
  # GET /players
  # GET /players.xml
  def index
    @quarter_b =  Player.available.order("rank").limit(5).where("position LIKE ?", "%QB")
    @running_b =  Player.available.order("rank").limit(5).where("position LIKE ?", "%RB")
    @place_k   =  Player.available.order("rank").limit(5).where("position LIKE ?", "%K")
    @tight_e   =  Player.available.order("rank").limit(5).where("position LIKE ?", "%TE")
    @defense   =  Player.available.order("rank").limit(5).where("position LIKE ?", "%D/S")
    @wide_r    =  Player.available.order("rank").limit(5).where("position LIKE ?", "%WR")

#    t = Player.arel_table
#    @quarter_b =  Player.order("rank").limit(5).where(t[:position].matches('%QB'))
#    @running_b =  Player.order("rank").limit(5).where(t[:position].matches('%RB'))
#    @place_k   =  Player.order("rank").limit(5).where(t[:position].matches('%K'))
#    @tight_e   =  Player.order("rank").limit(5).where(t[:position].matches('%TE'))
#    @defense   =  Player.order("rank").limit(5).where(t[:position].matches('%D/S'))
#    @wide_r    =  Player.order("rank").limit(5).where(t[:position].matches('%WR'))
    
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

    respond_to do |format|
      if @player.update_attributes(params[:player])
        format.html { redirect_to(@player, :notice => 'Player was successfully updated.') }
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

  def assignment
    @player = Player.available.order("rank")
    @teams = Team.order("name")
  end
 def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == "admin" && password == "ransom"
    end
 end
end
