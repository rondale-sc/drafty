# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
Team.create(:id => 1,  :player_name => 'James Elliott',       :name => 'Pete\'s Dragon',              :draft_order => 11)
Team.create(:id => 2,  :player_name => 'Jonathan Jackson',    :name => 'The Jon Burgandy\'s',         :draft_order => 9)
Team.create(:id => 3,  :player_name => 'David Jackson',       :name => 'The Grunts',                  :draft_order => 1)
Team.create(:id => 4,  :player_name => 'Stephen Jackson',     :name => 'The Darkest Timelines',       :draft_order => 8)
Team.create(:id => 5,  :player_name => 'Susan & Mark',        :name => 'Midway Mayhem',               :draft_order => 6)
Team.create(:id => 6,  :player_name => 'Michelle Jackson',    :name => 'FoxGloves',                   :draft_order => 7)
Team.create(:id => 7,  :player_name => 'Swain Strickland',    :name => 'SwainTrain',                  :draft_order => 2)
Team.create(:id => 8,  :player_name => 'Rickey Roach',        :name => 'Nimbly Bimblies',             :draft_order => 10)
Team.create(:id => 9,  :player_name => 'Janelle Roach',       :name => 'The Extra Twenty-Five Yards', :draft_order => 5)
Team.create(:id => 12, :player_name => 'Jason Vanderburgh',   :name => 'Burghermeisters',             :draft_order => 3)
Team.create(:id => 14, :player_name => 'Spencer Strickland',  :name => 'Spencer for Hire',            :draft_order => 4)

Player.populate
Player.update_rankings
Player.update_injury_status

Draft.populate