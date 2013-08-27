class Unit
  require 'MetricConversions'
  include MetricConversions
  attr_accessor :name, :physical_type, :factor
  METRIC = 1
  CUSTOM = 2

  WEIGHT = 1
  VOLUME = 2
  
  METRIC_FACTORS = { 
    WEIGHT => {
      'dag' => {'g' => 10},
      'hg' => {'g' => 100},
      'kg' => {'g' => 1000},  
      'g' => {
        'dag' => 0.1,
        'hg' => 0.01,
        'kg' => 0.001
      }
    }, 
    VOLUME => {
      'l' => {
        'dl' => 10,
        'cl' => 100,
        'ml' => 1000
      },
      'dl' => {'l' => 0.1},
      'cl' => {'l' => 0.01},
      'ml' => {'l' => 0.001}
    } # VOLUME  
  } # METRIC_FACTORS
  
  BASE_UNITS = { WEIGHT => 'g', VOLUME => 'l' }
  METRIC_UNITS = { WEIGHT => %w[g dag hg kg], VOLUME => %w[l dl cl ml] }
  
  def self.new_from_string(str)
    if METRIC_UNITS[WEIGHT].include? str
      u = Unit.new
      u.name = str
      u.physical_type = WEIGHT
      u
    elsif METRIC_UNITS[VOLUME].include? str
      u = Unit.new
      u.name = str
      u.physical_type = VOLUME     
      u    
    else
      u = CustomUnit.where('singular = ? OR plural = ?', str, str)
      return u.first if u.first
      
      raise UnknownUnit, "Couldn't find '#{str}'"
    end
    
  end
  
  def initialize
    @factor = 1
    self
  end
  
end

class UnknownUnit < Exception
end

class SpecificWeightRequired < Exception
end


