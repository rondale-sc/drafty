desc 'Grabs all the player information from the My Fantasy League Site.'
task :update_players => :environment do
  Player.populate
end

desc 'Grabs all the rank information from the My Fantasy League ADP Site.'
task :update_rankings => :environment  do
  Player.update_rankings
end
