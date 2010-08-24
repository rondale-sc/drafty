class Player < ActiveRecord::Base
  belongs_to :team

  scope :available, where("team_id is ?", nil)
  
  scope :picked, where( "team_id is NOT ?", nil )

  scope :for_pick, lambda {|pick_number| where("pick = ?", pick_number) } 
  
  def name
    first_name + ' ' + last_name
  end
end
