desc 'Prepopulates all the franchise players based on their ranking.'
task :populate_franchise, :needs => :environment  do |t, args| 
  begin
  @players = {
    "Stephen Jackson" => { 
      :player_rank  => [21, 4, 7],
      :picks => [8, 21, 36]
      },
    "Swain Strickland" => {
      :player_rank => [45, 3, 20 ],
      :picks => [7, 22, 35]
    },
    "Jonathan Jackson" => {
      :player_rank => [2]
    },
    "Robert Couch" => {
      :player_rank => [1]
    },
    "David Jackson" => {
      :player_rank => [12]
    },
    "Laura Jackson" => {
      :player_rank => [5]
    },
    "Michelle Jackson" => {
      :player_rank => [67]
    }
  }
  
  @players.each do |key, value|
    value[:player_rank].each_with_index do |rank, i|
        @team = Team.find_by_player_name(key)

        player = Player.find_by_rank(rank)
        player.pick = (value[:picks].blank? ? @team.draft_order : value[:picks][i])
        player.team_id = @team.id
        player.save
    end
  end
  rescue StandardError => e
    puts e.backtrace
  end
end
