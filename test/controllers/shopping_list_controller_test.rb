require 'test_helper'

class ShoppingListControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get add_recipe" do
    get :add_recipe
    assert_response :success
  end

  test "should get ingredients" do
    get :ingredients
    assert_response :success
  end

end
