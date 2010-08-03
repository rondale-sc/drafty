class Player < ActiveRecord::Base
  belongs_to :team

  scope :available, where("selected != ?", true)
end
