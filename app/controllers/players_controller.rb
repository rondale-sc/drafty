class PlayersController < ApplicationController
  # GET /players
  # GET /players.xml
  def index
    @quarter_b =  Player.available.healthy.quaterbacks.by_ranking.limit(5)
    @running_b =  Player.available.healthy.running_backs.by_ranking.limit(5)
    @place_k   =  Player.available.healthy.place_kickers.by_ranking.limit(5)
    @tight_e   =  Player.available.healthy.tight_ends.by_ranking.limit(5)
    @defense   =  Player.available.healthy.defenses.by_ranking.limit(5)
    @wide_r    =  Player.available.healthy.wide_receivers.by_ranking.limit(5)

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
