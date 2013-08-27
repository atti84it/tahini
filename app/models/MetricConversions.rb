module MetricConversions

  def factor_for(str)
    return 1 if @name == str
    
    metric if !is_metric?
    
    # e.g. if 'l' to 'ml'
    return @factor * Unit::METRIC_FACTORS[self.physical_type][@name][str] if Unit::METRIC_FACTORS[self.physical_type][@name] && Unit::METRIC_FACTORS[self.physical_type][@name][str]
    
    unit_to = Unit.new_from_string str
    raise SpecificWeightRequired, "Can't convert #{@name} into #{str}" if self.physical_type != unit_to.physical_type
    
    # goes to 'g' or 'l'
    base if !is_base?
    
    # e.g. 'dl' to 'ml' scales to 'l' then to 'ml'
    return factor_for str if unit_to.is_metric?
    
    unit_to.metric.base
    
    return @factor / unit_to.factor
  end
  
  # Scales down to 'g' or 'l'
  def base
    unit_to = Unit::BASE_UNITS[self.physical_type]
    @factor *= Unit::METRIC_FACTORS[self.physical_type][@name][unit_to]
    @name = unit_to
    self
  end
  
  # Return true if Unit is 'g' or 'l'
  def is_base?
    Unit::BASE_UNITS[@physical_type] == @name && @name != nil
  end
  
  # Return true if Unit is one of 'g, mg, kg, l, ml, etc.'
  def is_metric?
    Unit::METRIC_UNITS[self.physical_type].include? @name
  end
end
