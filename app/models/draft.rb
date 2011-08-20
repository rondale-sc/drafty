class Draft < ActiveRecord::Base
  belongs_to :team
  belongs_to :player

  scope :draft_order, order(:overall_pick)
  scope :on_the_clock, lambda{ where('drafts.draft_time <= ?', Time.now)}
  scope :pending, where('drafts.player_id IS NULL')
  scope :finalized, where('drafts.player_id IS NOT NULL')

  validates_uniqueness_of :player_id, :allow_nil => true

  def self.current_pick
    where("player_id is NULL").limit(1).first
  end

  def self.current_round
    current_pick.round
  end

  def self.current_team
    current_pick.team
  end

  def self.populate
    teams = Team.draft_order.all

    (1..16).step(2) do |round|
      teams.each_with_index do |team, index|
        Draft.create(
          :team         => team,
          :round        => round,
          :overall_pick => (index + 1) + ((round - 1) * teams.length)
        )
      end

      round += 1
      teams.reverse.each_with_index do |team, index|
        Draft.create(
          :team         => team,
          :round        => round,
          :overall_pick => (index + 1) + ((round - 1) * teams.length)
        )
      end
    end
  end

  def self.start_draft_clock
    minutes_from_now = 0
    Draft.pending.draft_order.each do |draft|
      draft.draft_time = Time.now + minutes_from_now.minutes
      draft.save!
      minutes_from_now += 2
    end
  end

  def self.stop_draft_clock
    Draft.pending.draft_order.each do |draft|
      draft.draft_time = nil
      draft.save!
    end
  end
end
