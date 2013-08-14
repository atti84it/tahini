class ShoppingList
  attr_reader :recipes
  
  def self.new_from_menu(menu)
    sl = ShoppingList.new
    menu.menu_items.each do |mi|
      sl.add_recipe mi.recipe_id, mi.yields
    end
    sl
  end
  
  def initialize
    @recipes = []
    @ingredients = []
  end
  
  def add_recipe(recipe_id, yields)
    @recipes << {:recipe_id => recipe_id, :yields => yields.to_f}
  end
  
  def group_by_recipe
    make_ingredients_list
    @ingredients
  end
  
  def group_by_ingredient_name
    make_ingredients_list
    sorted = @ingredients.sort_by {|i| i[:name] }
    sorted
  end
  
  private
  
  def make_ingredients_list
    @ingredients = []
    @recipes.each do |r|
      #puts "for #{r[:yields].class}"
      recipe = Recipe.find(r[:recipe_id])
      recipe.for(r[:yields]).ingredients.each do |i|
          @ingredients << {:name => i.name, :i => i}
      end  
    end      
  end # make_ingredients_list
    
end
