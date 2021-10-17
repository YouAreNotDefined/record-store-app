json.library do
  json.extract! @library, :id, :name, :content, :user_id
end

json.records do
  json.array! @records, :id, :title, :year, :artist_id
end
