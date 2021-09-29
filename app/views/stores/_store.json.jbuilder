json.extract! store, :id, :name, :brand, :model, :color, :size, :price, :description, :created_at, :updated_at
json.url store_url(store, format: :json)
