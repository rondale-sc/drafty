class Player < ActiveRecord::Base
  scope :available, where("selected != ?", true)
end
