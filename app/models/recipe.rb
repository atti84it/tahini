class Recipe < ActiveRecord::Base
  validates_presence_of :title, :yields
  validates_numericality_of :yields
  attr_reader :ingredients
  
  def self.import_gourmet_text(txt)
    require 'nokogiri'
    noko = Nokogiri::XML(txt)

    noko.xpath('//recipe').each do |t|
      title = t.children.css('title').inner_text
      existing_recipe = Recipe.where(:title => title).first
      r = Recipe.new
      if existing_recipe
        r.title = "#{title} (#{Time.now.to_s})"
      else
        r.title = title
      end
      
      r.yields = t.children.css('yields').inner_text.to_f
      r.ingredients_text = ""
      
      t.children.css('ingredient-list').children.css('ingredient').each do |i|
          number = i.children.css('amount').inner_text.to_f
          unit = i.children.css('unit').inner_text
          name = i.children.css('item').inner_text
          r.ingredients_text = "#{r.ingredients_text}#{number} #{unit} #{name}\n"
      end
      
      r.save   
    end
  end # self.import_gourmet_text
  
  def parse_ingredients(txt=self.ingredients_text)
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
    self.yields = self.yields * factor.to_f
    @ingredients.each do |i|
      i.multiply(factor)
    end
    self
  end

  def for(yields)
    parse_ingredients self.ingredients_text
    multiply(yields / self.yields.to_f)
  end

  def nice_text
    output = "#{@title}\nYields: #{@yields} portions\n\n"
    @ingredients.each do |i|
      output = output + "#{i.nice_text}\n"
    end
    output
  end
  
end
