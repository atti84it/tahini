class MenuItem < ActiveRecord::Base
  belongs_to :menu
  belongs_to :recipe
  
  validates_numericality_of :yields
end
