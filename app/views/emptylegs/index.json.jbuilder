json.array!(@emptylegs) do |emptyleg|
  json.extract! emptyleg, :id, :aircraft_type, :departon, :from, :to, :seats, :price, :min_price
  json.url emptyleg_url(emptyleg, format: :json)
end
