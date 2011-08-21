desc 'Grabs all the player information from the My Fantasy League Site.'
task :update_players => :environment do
  Player.populate
end

desc 'Grabs all the rank information from the My Fantasy League ADP Site.'
task :update_rankings => :environment do
  Player.update_rankings
end

desc 'Update injury status from My Fantasy League Site.'
task :update_injury_status => :environment do
  Player.update_injury_status
end