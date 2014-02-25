json.array!(@tables) do |table|
  json.extract! table, :id, :club_id
  json.url table_url(table, format: :json)
end
