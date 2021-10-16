if @record.errors.present?
  json.errors @record.errors
else
  json.extract! @record, :id, :title, :year, :artist_id, :user_id
end
