class RecordLibrary < ApplicationRecord
  belongs_to :record
  belongs_to :library
  belongs_to :user
end
