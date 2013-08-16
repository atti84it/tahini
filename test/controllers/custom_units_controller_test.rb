require 'test_helper'

class CustomUnitsControllerTest < ActionController::TestCase
  setup do
    @custom_unit = custom_units(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:custom_units)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create custom_unit" do
    assert_difference('CustomUnit.count') do
      post :create, custom_unit: { equivalence_factor: @custom_unit.equivalence_factor, equivalence_unit: @custom_unit.equivalence_unit, plural: @custom_unit.plural, singular: @custom_unit.singular }
    end

    assert_redirected_to custom_unit_path(assigns(:custom_unit))
  end

  test "should show custom_unit" do
    get :show, id: @custom_unit
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @custom_unit
    assert_response :success
  end

  test "should update custom_unit" do
    patch :update, id: @custom_unit, custom_unit: { equivalence_factor: @custom_unit.equivalence_factor, equivalence_unit: @custom_unit.equivalence_unit, plural: @custom_unit.plural, singular: @custom_unit.singular }
    assert_redirected_to custom_unit_path(assigns(:custom_unit))
  end

  test "should destroy custom_unit" do
    assert_difference('CustomUnit.count', -1) do
      delete :destroy, id: @custom_unit
    end

    assert_redirected_to custom_units_path
  end
end
