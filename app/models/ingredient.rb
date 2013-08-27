class Ingredient
  attr_reader :number,:unit,:name
  attr_accessor :recipe

  @@units = %w[cucharadas cucharada cucharaditas cucharadita dientes diente hojas hoja gr g kilos kilo kg lbs lb libras libra litros litro l ml onzas onza oz pizcas pizca tazas taza]
  
  # Creates new object from strings like "1 1/2 kg rice" or "black pepper"
  def self.new_from_string(str, recipe)
    return Ingredient.new if str == ''
    results = /(?<number>([\d.]*)\s?((\d+)\/(\d+))?)?\s?(?<unit>#{@@units.join('|')})?\s?(?<name>[[:alpha:]\s]+)/u.match str
    i=Ingredient.new
    i.set_values(results[:number], results[:unit], results[:name] )
    i.recipe = recipe
    i
  end

  def initialize
    @number = 0
    @unit = ''
    @name = ''
  end

  def set_values(number, unit, name)
    value = parse_amount(number ? number.strip : nil)
    @number = value
    @unit = unit
    @name = name
    self
  end

  # Converts Ingredient into metric system
  #  '1 taza maní' -> '200 ml maní'
  #  '1 cup peanuts' -> '200 ml peanuts'
  def metric
    begin
      u = Unit.where("singular = #{@unit} OR plural = #{@unit}").first
    rescue StandardError
    
    end
    
    @number *= u
  end

  def multiply(factor)
    if @number != nil
      @number = @number * factor
    else
      @number = 0
    end
    self
  end

  def nice_number
    return '' if @number == 0 or @number == nil
    tmp = "%.1f" % @number
    return tmp.chomp '.0'
  end
  
  def nice_text
    "#{nice_number} #{@unit} #{@name}"
  end

  private

  # Transform '2 1/2' into 2.5
  def parse_amount(str)
    return str if str.is_a? Numeric
    return nil if str == nil or str == ''
    parts = str.split(' ')
    case parts.length
    when 1
    return parts.first.match(/\//) == nil ? parts.first.to_f : parse_rate(parts.first)

    when 2
    return parse_amount(parts[0]) + parse_amount(parts[1])

    else
    raise StandardError, "Can't parse '#{str}'"
    end
  end

  # Transform '1/2' into 0.5
  def parse_rate(str)
    str.split('/')[0].to_f / str.split('/')[1].to_f
  end

end
