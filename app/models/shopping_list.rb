class ShoppingList
  attr_reader :recipes
  
  def initialize
    @recipes = []
    @ingredients = []
  end
  
  def add_recipe(recipe, yields)
    @recipes << {:recipe => recipe, :yields => yields.to_f}
  end
  
  def group_by_recipe
    make_ingredients_list
  end
  
  def group_by_ingredient_name
    make_ingredients_list
    sorted = @ingredients.sort_by {|i| i[:name] }
    sorted
  end
  
  private
  
  def make_ingredients_list
    @recipes.each do |r|
      puts "for #{r[:yields].class}"
        r[:recipe].for(r[:yields]).ingredients.each do |i|
            @ingredients << {:name => i.name, :i => i}
        end  
    end
    @ingredients        
  end  
end
