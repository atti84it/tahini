class Recipe < ActiveRecord::Base
  validates_presence_of :title, :yields
  validates_numericality_of :yields
  attr_reader :ingredients
  
  def initialize_bak(*args)
    super(*args)
    @ingredients = []
  end  
  
  def parse_ingredients(txt)
    @ingredients = []
    txt.split("\n").each do |line|
      if line.strip != ''
        i = Ingredient.new_from_string(line.strip, self)
        @ingredients << i
      end 
    end
    self     
  end

  def multiply(factor)
    self.yields = self.yields * factor
    @ingredients.each do |i|
      i.multiply(factor)
    end
    self
  end

  def for(yields)
    parse_ingredients self.ingredients_text
    multiply(yields / self.yields)
  end

  def nice_text
    output = "#{@title}\nYields: #{@yields} portions\n\n"
    @ingredients.each do |i|
      output = output + "#{i.nice_text}\n"
    end
    output
  end
  
end
