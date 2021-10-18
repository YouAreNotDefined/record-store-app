if @library.errors.present?
  json.errors @library.errors
else
  json.extract! @library, :id, :name, :content
end
