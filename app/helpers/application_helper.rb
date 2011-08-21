module ApplicationHelper

  def player_link(player)
    link_to "#{player.name} #{player.nfl_team}(#{player.bye_week}) #{player.position}", player.url, {:id => 'search', :target => "blank"}
  end
end
