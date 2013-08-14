json.array!(@menus) do |menu|
  json.extract! menu, :title
  json.url menu_url(menu, format: :json)
end
