json.array!(@menu_items) do |menu_item|
  json.extract! menu_item, :menu_id, :yields, :recipe_id
  json.url menu_item_url(menu_item, format: :json)
end
