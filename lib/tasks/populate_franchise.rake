desc 'Prepopulates all the franchise players based on their ranking.'
task :populate_franchise, :needs => :environment  do |t, args| 
  begin
  @players = {
    "Stephen Jackson" => { 
      :picks => [8, 21, 36],
      :player_names => ["Peyton Manning", "Ray Rice", "Andre Johnson"]
      },
    "Swain Strickland" => {
      :picks => [7, 22, 35],
      :player_names => ["Tony Romo", "Maurice Jones-Drew", "Roddy White"]
    },
    "Jonathan Jackson" => {
      :player_names => ["Adrian Peterson"]
    },
    "Robert Couch" => {
      :player_names => ["Chris Johnson"]
    },
    "David Jackson" => {
      :player_names => ["Larry Fitzgerald"]
    },
    "Laura Jackson" => {
      :player_names => ["Steven Jackson"]
    },
    "Michelle Jackson" => {
      :player_names => ["Brett Favre"]
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
