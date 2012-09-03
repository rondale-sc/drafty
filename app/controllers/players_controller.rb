class PlayersController < ApplicationController
  # GET /players
  # GET /players.xml
  def index
    @players = Player.available.healthy.by_ranking.limit(5)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @players }
    end
  end

  def round
    @drafts = Draft.finalized.draft_order
  end

  def assignment
    @players = Player.available.for_position(params[:position]).by_ranking
    @teams = Team.order("name")
  end
end
