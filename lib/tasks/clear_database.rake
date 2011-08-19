task :clear_database => :environment do
  Player.delete_all
  Draft.delete_all
  Team.delete_all
end