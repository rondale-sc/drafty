module ApplicationHelper

  def player_link(player)
    link_to "#{player.name} #{player.nfl_team}(#{player.bye_week}) #{player.position} #{"- <span style=\"color:red\">#{player.injury_status[0,1]}</span>" if player.injury_status}".html_safe,
            player.url, {:id => 'search', :target => "player_lookup"}
  end
end
