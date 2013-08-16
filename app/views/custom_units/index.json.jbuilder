json.array!(@custom_units) do |custom_unit|
  json.extract! custom_unit, :singular, :plural, :equivalence_unit, :equivalence_factor
  json.url custom_unit_url(custom_unit, format: :json)
end
