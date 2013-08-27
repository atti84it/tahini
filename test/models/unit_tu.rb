# cd tahini
# ruby test/models/unit_tu.rb
require 'test/unit'
require './app/models/MetricConversions.rb'
require './app/models/unit.rb'
require 'active_record'
require './app/models/custom_unit.rb'

class TestUnit < Test::Unit::TestCase
  def test_new_from_string
    u = Unit.new_from_string 'l'
    assert_equal(Unit::VOLUME, u.physical_type)
    
    u = Unit.new_from_string 'g'
    assert_equal(Unit::WEIGHT, u.physical_type)    
    
    u = Unit.new_from_string 'taza'
    assert_equal(Unit::VOLUME, u.physical_type)    
  end
  
end
