module ApplicationHelper

  def player_link(player)
    link_to "#{player.name} #{player.nfl_team}(#{player.bye_week}) #{player.position} #{"- #{player.injury_status}" if player.injury_status}",
            player.url, {:id => 'search', :target => "player_lookup"}
  end
end
