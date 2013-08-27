FactoryGirl.define do
  factory :taza , :class => CustomUnit do
    singular 'taza'
    plural 'tazas'
    physical_type Unit::VOLUME
    equivalence_factor 200
    equivalence_unit 'ml'
  end
  
  factory :tbsp , :class => CustomUnit do
    singular 'tbsp'
    plural 'tbsp'
    physical_type Unit::VOLUME
    equivalence_factor 14.79
    equivalence_unit 'ml'
  end
  
  factory :tsp , :class => CustomUnit do
    singular 'tsp'
    plural 'tsp'
    physical_type Unit::VOLUME
    equivalence_factor 4.93
    equivalence_unit 'ml'
  end
  
end
