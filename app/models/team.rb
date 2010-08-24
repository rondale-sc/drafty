class Team < ActiveRecord::Base
  has_many :players

  def self.with_pick(pick_number)
    team_count = Team.count
    @draft_order ||= by_draft_order.all
    @reversed_draft_order ||= by_reversed_draft_order.all
    
    round = (pick_number / team_count) + (pick_number % team_count == 0 ? 0 : 1)

    draft_order = pick_number % team_count
    draft_order = team_count if draft_order == 0
    draft_order -= 1
    
    rel = if round % 2 == 0
      # EVEN  
      @reversed_draft_order
    else
      # ODD
      @draft_order
    end
    
    rel[draft_order]
  end
  
  scope :by_draft_order, order('draft_order')
  scope :by_reversed_draft_order, order('draft_order desc')
end
