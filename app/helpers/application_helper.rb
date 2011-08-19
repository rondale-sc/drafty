module ApplicationHelper

 #TODO
  def get_picked_player(pick)
    @players ||= Player.picked

    @players.select{|p| p.pick == pick}.first
  end

  def current_pick
    Draft.current_pick
  end

  def current_round
    Draft.current_round
  end

  def current_team
    Draft.current_team
  end
end
