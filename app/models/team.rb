class Team < ActiveRecord::Base
  has_many :players
  
  scope :with_pick, lambda {|pick_number| 
    draft_order = pick_number % 14
    draft_order = 14 if draft_order == 0
    where("draft_order = ?", draft_order) 
  } 
  
  scope :by_draft_order, order('draft_order')
  
end

