class Menu < ActiveRecord::Base
  has_many :menu_items
  has_many :recipes, :through => :menu_items
end
