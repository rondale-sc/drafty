class PlayersController < ApplicationController
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

  def round
    @drafts = Draft.finalized.draft_order
  end

  def assignment
    @players = Player.available.for_position(params[:position]).by_ranking
    @teams = Team.order("name")
  end
end
