json.array!(@cars) do |car|
  json.extract! car, :id, :car_type, :seat, :brand, :user_id 
  json.url car_url(car, format: :json)
end
