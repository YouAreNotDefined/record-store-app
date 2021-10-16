if @artist.errors.present?
  json.errors @artist.errors
else
  json.extract! @artist, :id, :name, :user_id
end
