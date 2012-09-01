desc 'Prepopulates all the franchise players based on their ranking.'
task :populate_franchise => :environment  do
  begin
  @players = {
    "Stephen Jackson" => {
      :picks => [],
      :player_names => []
      },
    "Swain Strickland" => {
      :picks => [],
      :player_names => []
    },
    "Jonathan Jackson" => {
      :player_names => []
    },
    "Robert Couch" => {
      :player_names => []
    },
    "David Jackson" => {
      :player_names => []
    },
    "Laura Jackson" => {
      :player_names => []
    },
    "Michelle Jackson" => {
      :player_names => []
    }
  }

  @players.each do |key, value|
    value[:player_names].each_with_index do |name, i|
      @team = Team.find_by_player_name(key)
        player =  Player.full_name(name).first
          player.pick = (value[:picks].blank? ? @team.draft_order : value[:picks][i])
          player.team_id = @team.id
        player.save
    end
  end
  rescue StandardError => e
    puts e.backtrace
  end
end
