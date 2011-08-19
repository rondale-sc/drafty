task :clear_database => :environment do
  Player.delete_all
  Draft.delete_all
end