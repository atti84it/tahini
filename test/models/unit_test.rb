require 'test_helper'

class IngredientTest < ActiveSupport::TestCase
  test "new_from_string" do
    u = Unit.new_from_string 'l'
    assert_equal(Unit::VOLUME, u.physical_type)

    u = Unit.new_from_string 'g'
    assert_equal(Unit::WEIGHT, u.physical_type)
    
    u = Unit.new_from_string 'kg'
    assert_equal(Unit::WEIGHT, u.physical_type)    

    cu = CustomUnit.new
    cu.singular = 'taza'
    cu.plural = 'tazas'
    cu.physical_type = Unit::VOLUME
    cu.equivalence_factor = 200
    cu.equivalence_unit = 'ml'
    cu.save

    cu = CustomUnit.new
    cu.singular = 'tbsp'
    cu.plural = 'tbsp'
    cu.physical_type = Unit::VOLUME
    cu.equivalence_factor = 14.79
    cu.equivalence_unit = 'ml'
    cu.save

    cu = CustomUnit.new
    cu.singular = 'tsp'
    cu.plural = 'tsp'
    cu.physical_type = Unit::VOLUME
    cu.equivalence_factor = 4.93
    cu.equivalence_unit = 'ml'
    cu.save

    u = Unit.new_from_string 'taza'
    assert_equal(Unit::VOLUME, u.physical_type)
  end

  test "metric conversions" do
    u = Unit.new_from_string 'kg'
    assert u.is_metric?, 'failed is_metric?'
    assert !u.is_base?, 'failed is_base?'
    assert_equal(1, u.factor_for('kg'))
    assert_equal(1000, u.factor_for('g'))
  end


end
