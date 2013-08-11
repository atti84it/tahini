class ShoppingListController < ApplicationController
  def index
    @shopping_list = find_shopping_list
  end

  def add_recipe
    recipe = Recipe.find(params[:recipe_id]) ##Security
    @shopping_list = find_shopping_list
    @shopping_list.add_recipe(recipe, params[:yields]) ##Security
    redirect_to :action => 'index'
  end
  
  def clear
    session[:shopping_list] = ShoppingList.new
    redirect_to :action => 'index'
  end

  def ingredients
    @sorting_mode = params[:sorting_mode] ? params[:sorting_mode] : :by_recipe
    sl = find_shopping_list
    case @sorting_mode
      when :by_recipe
      @ingredients = sl.group_by_recipe
      when :by_ingredient_name
      @ingredients = sl.group_by_ingredient_name
      else
      redirect_to :action => 'index'
    end
  end
  
private
  def find_shopping_list
    session[:shopping_list] ||= ShoppingList.new
  end  
end
