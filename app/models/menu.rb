class Menu < ActiveRecord::Base
  has_many :menu_items
  has_many :recipes, :through => :menu_items
  
  def recipes_titles
    @recipes.map{|r| r.title}
  end
end
