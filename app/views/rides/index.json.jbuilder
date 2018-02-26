json.array!(@rides) do |ride|
  json.extract! ride, :id,:source, :destination, :cost, :duration, :travel_date, :route, :user_id, :travellers
  json.url ride_url(ride, format: :json)
end
