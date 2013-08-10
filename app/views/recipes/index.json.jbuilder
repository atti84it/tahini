json.array!(@recipes) do |recipe|
  json.extract! recipe, 
  json.url recipe_url(recipe, format: :json)
end
