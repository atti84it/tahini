class CustomUnit < ActiveRecord::Base
  require 'MetricConversions'
  include MetricConversions
  
  validates_presence_of :singular, :equivalence_unit, :equivalence_factor
  validates_numericality_of :equivalence_factor
  ### Scrivere un validation decente di controllo tra physical type e equivalence unit
  
  attr_accessor :factor
  
  def initialize(*args)
    @factor = 1
    super(*args)
  end  

  def metric
    @factor = self.equivalence_factor
    @name = self.equivalence_unit
    self
  end

  def nice_type
    case self.physical_type
      when Unit::WEIGHT
      'weight'
      when Unit::VOLUME
      'volume'
      else
      self.physical_type
    end
  end
end


