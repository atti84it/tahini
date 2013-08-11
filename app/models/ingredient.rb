class Ingredient
  attr_reader :name
  attr_accessor :recipe

  @@units = %w[ml l g gr kg lb lbs oz taza tazas]
  
  # Creates new object from strings like "1 1/2 kg rice" or "black pepper"
  def self.new_from_string(str, recipe)
    results = /(?<number>(\d*)\s((\d+)\/(\d+))?)?\s?(?<unit>#{@@units.join('|')})?\s?(?<name>[[:alpha:]\s]+)/u.match str
    i=Ingredient.new
    i.set_values(results[:number], results[:unit], results[:name] )
    i.recipe = recipe
    i
  end

  def set_values(number, unit, name)
    @number = parse_amount(number ? number.strip : nil)
    @unit = unit
    @name = name
    self
  end

  def human_number
    @number == 0 ? '' : @number
  end

  def multiply(factor)
    @number = @number * factor
    self
  end

  def nice_text
    "#{"%.1f" % @number} #{@unit} #{@name}"
  end

  private

  # Transform '2 1/2' into 2.5
  def parse_amount(str)
    return str if str.is_a? Numeric
    return nil if str == nil
    parts = str.split(' ')
    case parts.length
    when 1
    return parts.first.match(/\//) == nil ? parts.first.to_f : parse_rate(parts.first)

    when 2
    return parse_amount(parts[0]) + parse_amount(parts[1])

    else
    raise StandardError
    end
  end

  # Transform '1/2' into 0.5
  def parse_rate(str)
    str.split('/')[0].to_f / str.split('/')[1].to_f
  end

end
