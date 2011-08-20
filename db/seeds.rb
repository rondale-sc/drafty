# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
Team.create(:id => 1,  :player_name => 'Robert Jackson',      :name => 'The Time Lords',      :draft_order => 8)
Team.create(:id => 2,  :player_name => 'Jonathan Jackson',    :name => 'The Jon Burgandy\'s', :draft_order => 9)
Team.create(:id => 3,  :player_name => 'David Jackson',       :name => 'The Grunts',          :draft_order => 3)
Team.create(:id => 4,  :player_name => 'Stephen Jackson',     :name => 'The Nerd Herd',       :draft_order => 11)
Team.create(:id => 5,  :player_name => 'Robert Couch',        :name => 'The Couch Potatoes',  :draft_order => 6)
Team.create(:id => 6,  :player_name => 'Michelle Jackson',    :name => 'FoxGloves',           :draft_order => 5)
Team.create(:id => 7,  :player_name => 'Swain Strickland',    :name => 'SwainTrain',          :draft_order => 12)
Team.create(:id => 8,  :player_name => 'Rickey Roach',        :name => 'Nimbly Bimblies',     :draft_order => 2)
Team.create(:id => 9,  :player_name => 'Janelle Roach',       :name => 'Janelle Roach',       :draft_order => 10)
Team.create(:id => 10, :player_name => 'Jacquie Jackson',     :name => 'The Starbucks',       :draft_order => 13)
Team.create(:id => 11, :player_name => 'John Jackson',        :name => 'Jackson Alpha\'s',        :draft_order => 1)
Team.create(:id => 12, :player_name => 'Jason Vanderburgh',   :name => 'Burghermeisters',     :draft_order => 14)
Team.create(:id => 13, :player_name => 'Paul Welch',          :name => 'Covert Penguins',     :draft_order => 4)
Team.create(:id => 14, :player_name => 'Spencer Strickland',  :name => 'Spencer for Hire',    :draft_order => 7)

Player.populate
Player.update_rankings

Draft.populate

# Andre Johnson, Ray Rice, Tom Brady
Team.franchise_players(:player_name => 'John Jackson', :players => [6931,9094,5848])

# Jay Cutler, Ahmad Bradshaw, Reggie Wayne
Team.franchise_players(:player_name => 'Robert Couch', :players => [8252,8917,4923])

# Arian Foster, Adrian Peterson, Greg Jennings
Team.franchise_players(:player_name => 'Jonathan Jackson', :players => [9690,8658,8293])

# Roddy White, Maurice Jones-Drew
Team.franchise_players(:player_name => 'Swain Strickland', :players => [7839,8301])

# Aaron Rodgers
Team.franchise_players(:player_name => 'Rickey Roach', :players => [7836])

# Frank Gore
Team.franchise_players(:player_name => 'Jason Vanderburgh', :players => [7877])

# Phillip Rivers
Team.franchise_players(:player_name => 'Michelle Jackson', :players => [7394])

# Michael Turner, Darren McFadden, Miles Austin
Team.franchise_players(:player_name => 'Spencer Strickland', :players => [7544,9087,8510])

# Drew Brees, Matt Forte
Team.franchise_players(:player_name => 'Jacquie Jackson', :players => [4925,9122])