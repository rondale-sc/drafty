class Player < ActiveRecord::Base
  belongs_to :team

  scope :available, where("team_id is ?", nil)
end
